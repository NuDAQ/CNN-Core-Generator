# hls_streaming

This directory is the C++ HLS working area for the streaming trigger design.
It starts from an unmodified copy of:

```text
../cnn_core_project/firmware
```

The original hls4ml firmware remains the baseline. Modify this directory when
developing the streaming ADC pipeline.

## Intended Use

```text
../cnn_core_project/firmware   Reference hls4ml chunk implementation
./firmware                     Working copy for C++ HLS changes
./tb/compare_runner.cpp        Simple output-alignment testbench
./Makefile                     Build and compare flow
```

The current comparison verifies C++ behavior, not RTL. It answers:

```text
Does hls_streaming/firmware still produce the same output as the original
hls4ml firmware for the test inputs?
```

## Compare

Run:

```bash
make compare
```

The Makefile builds two executables:

```text
baseline_runner   links ../cnn_core_project/firmware/cnn_core.cpp
streaming_runner  links ./firmware/cnn_core.cpp
```

Both runners use the same deterministic input vectors. Their outputs are written
under `build/run/` and compared with `cmp`.

A passing result looks like:

```text
PASS: baseline and hls_streaming C++ outputs match exactly.
```

## Development Flow

1. Keep `../cnn_core_project/firmware` unchanged as the baseline.
2. Make C++ HLS changes under `./firmware`.
3. Run `make compare`.
4. If the comparison fails, decide whether the output change is expected. For
   intentional architecture changes, update or extend the testbench/reference
   flow rather than changing the original baseline.

## Current Development Plan

The trigger problem is primarily a throughput problem, not a single-window
end-to-end latency problem. The ADC stream is expected to provide one sample per
channel per nanosecond. For the current four-channel inference path, this means
the hardware must keep up with a continuous stream of four-channel samples. A
fixed latency of multiple microseconds can still be acceptable if the steady
state pipeline interval is high enough to keep up with the input stream.

The current hls4ml implementation processes one complete 256 x 4 input window
per inference. This is a useful baseline, but it is not the natural hardware
shape for a continuous ADC trigger. Adjacent trigger windows overlap heavily, so
reloading and repacking a full tensor for every score wastes throughput. The
streaming design should instead move toward:

```text
ADC stream
  -> sliding sample buffer / shift register
  -> convolution kernel
  -> activation
  -> pooling or time-domain reduction
  -> dense / accumulator / score logic
  -> trigger output
```

Near-term work should preserve baseline equivalence while isolating the input
path:

1. Use `make compare` as the guardrail while refactoring.
2. Keep the hls4ml baseline untouched under `../cnn_core_project/firmware`.
3. First replace or wrap the `repack_stream`/full-window input path in
   `./firmware`.
4. Introduce a sliding-window generator that can reuse samples across adjacent
   windows.
5. Keep output alignment against the baseline for equivalent non-overlapping
   test windows before adding continuous-window tests.

Once the input path is stable, the next optimization target is the first
convolution path. For waveform-trigger workloads, a 1D-CNN-like implementation
may map more directly to shift-register and FSM hardware than a general 2D CNN.
The current model is represented as Conv2D with a 5 x 1 kernel over a 256 x 4 x
1 input, so changes to channel mixing or true Conv1D structure should be
coordinated with the model-training side rather than treated as a pure HLS
refactor.

Open design questions:

```text
Throughput target       Can the steady-state pipeline accept 4 channel samples every ns?
Window semantics        Should the trigger score be produced for every sample or for a coarser stride?
Channel mixing          Should early kernels mix the 4 channels, or preserve per-channel feature extraction first?
Quantization            Can heterogeneous or channel-wise quantization reduce kernel cost without accuracy loss?
Reference comparison    How should continuous overlapping windows be aligned against the chunk baseline?
```

## CNN and C++ Structure

The current hls4ml model is a small stream-oriented CNN. The logical input
window is:

```text
height = 256
width  = 4
channels = 1
```

At the top-level C++ interface, this appears as an AXI-stream of `input_t`,
where each stream word contains 4 fixed-point values:

```text
input_t = nnet::array<ap_fixed<12,6>, 4>
```

The network implemented in `firmware/cnn_core.cpp` is:

```text
input_layer
  -> repack_stream
  -> q_conv2d
  -> q_conv2d_relu
  -> max_pooling2d
  -> q_dense
  -> layer7_out
```

Layer shapes from `firmware/parameters.h`:

```text
Input window:        256 x 4 x 1
Repack output:       1024 scalar stream words
Conv2D:              5 x 1 kernel, 7 filters, stride 3 x 1
Conv2D output:       84 x 4 x 7 = 2352 values
ReLU output:         84 x 4 x 7
MaxPool2D:           2 x 1 pool, stride 2 x 1
MaxPool output:      42 x 4 x 7 = 1176 values
Dense output:        1 trigger score
```

The hls4ml C++ code mirrors the CNN layer structure. The main pieces are:

```text
firmware/cnn_core.cpp       Top-level function and layer wiring
firmware/cnn_core.h         Top-level function declaration
firmware/defines.h          Fixed-point types for inputs, outputs, and layers
firmware/parameters.h       Layer configs, dimensions, reuse factors, weights
firmware/weights/           Quantized weights and biases
firmware/nnet_utils/        hls4ml layer implementations
```

`cnn_core()` uses `#pragma HLS DATAFLOW`, so each layer is a dataflow process
connected by `hls::stream` FIFOs:

```text
layer8_out   depth 1024   repacked scalar input stream
layer3_out   depth 336    conv output, packed 7 values per stream word
layer4_out   depth 336    ReLU output
layer5_out   depth 168    maxpool output, packed 7 values per stream word
```

This mapping is important for streaming work. The current C++ project still
processes one complete hls4ml input window at a time. A future ADC-streaming
version should replace or wrap the `repack_stream`/window input path so that
overlapping ADC windows can reuse samples instead of repacking a full tensor for
every score. The first milestone is not to change the network math, but to make
the data path look more like a continuous stream while preserving baseline
outputs for equivalent windows.

## Current hls4ml Baseline Bottlenecks

Use the latest available report for each metric:

```text
Top-level latency/interval:  RTL cosim transaction report
Resource usage:              Vivado synthesis utilization report
Per-block bottleneck detail: HLS csynth reports
```

Relevant files:

```text
../cnn_core_project/cnn_core_prj/solution1/sim/verilog/cnn_core.performance.result.transaction.xml
../cnn_core_project/vivado_synth.rpt
../cnn_core_project/cnn_core_prj/solution1/syn/report/cnn_core_csynth.rpt
```

Top-level RTL cosim result:

```text
Latency:   3068 cycles
Interval:  3074 cycles for completed back-to-back transactions
```

The HLS synthesis estimate is close but slightly different:

```text
Latency estimate:   3082 cycles
Interval estimate:  3076 cycles
Pipeline type:      dataflow
Estimated clock:    3.236 ns at a 5.00 ns target
```

Per-block latency and interval from HLS csynth:

```text
Block                   Latency cycles   Interval cycles   Notes
repack_stream           3075             3075              Largest window-level throughput limiter
conv_2d                 2051             2051              Main CNN compute latency after repack
relu                    339              339               II=1 loop, relatively small
pooling2d               674              674               II=2 loop over 336 outputs
dense                   176              176               Small latency, large LUT/FF footprint
```

Loop-level notes:

```text
repack_stream loop       trip count 1024, achieved II=3
conv_2d input loop       trip count 1024, achieved II=2
relu loop                trip count 336,  achieved II=1
pooling2d input loop     trip count 336,  achieved II=2
dense DataPrepare loop   trip count 168,  achieved II=1
```

Resource usage from Vivado synthesis:

```text
CLB LUTs:       18182 / 216960  (8.38%)
CLB registers:  27975 / 433920  (6.45%)
BRAM tiles:         5 / 480     (1.04%)
DSPs:              17 / 1824    (0.93%)
```

HLS resource estimates are still useful for per-block attribution:

```text
Dense block:     13 DSP, 27888 FF, 31767 LUT
Conv block:       1 DSP,   533 FF,  1432 LUT
```

Interpretation for streaming work:

1. The top-level dataflow design overlaps blocks, so the sustained per-window
   interval is dominated by the slowest dataflow stage, not by the sum of all
   layer latencies.
2. In this baseline, `repack_stream` is the largest interval bottleneck. This is
   likely format-conversion overhead between the hls4ml tensor/window view and
   the internal scalar stream.
3. `conv_2d` is the next important latency/throughput block. Its main loop has
   achieved II=2, not II=1.
4. The dense layer dominates the HLS per-block LUT/FF/DSP estimate, but it is
   not the main interval limiter for the current single-window hls4ml pipeline.
5. For a continuous ADC trigger pipeline, the first targets should be the input
   formatting/repack path, the sliding-window generator, and the first
   convolution path. Avoid reloading or repacking highly overlapping windows if
   the ADC stream can feed the compute pipeline directly.

## macOS and Ubuntu

The comparison flow is intended to work on both macOS and Ubuntu.

On macOS, Apple Clang/libc++ can conflict with the older Xilinx `ap_fixed` and
`ap_int` simulation headers. To handle this, `make compare` creates temporary
patched copies of `ap_types` under:

```text
build/baseline_ap_types
build/streaming_ap_types
```

Only these temporary files are patched. The real source directories are not
modified.

## Clean

```bash
make clean
```
