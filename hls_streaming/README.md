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

Useful variants:

```bash
make compare SAMPLES=128
make compare ALLOW_MISMATCH=1
make run-streaming SAMPLES=1024
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

This comparison is a guardrail, not the final design metric. It is useful for
math-preserving refactors. For intentional DAQ/interface/model changes, use
`ALLOW_MISMATCH=1` or a new reference/test flow and judge the design by
throughput, resources, and trigger requirements.

## Vitis HLS Estimate Flow

`hls_streaming` has its own lightweight Vitis HLS flow. It does not reuse the
hls4ml-generated `cnn_core_project` scripts directly.

On a machine with Vitis available:

```bash
cd hls_streaming
source /tools/Xilinx/Vitis/2023.2/settings64.sh
make hls
```

Equivalent direct entry point:

```bash
./scripts/run_hls.sh
```

The default flow runs C/RTL synthesis only and writes a short summary to:

```text
cnn_core_streaming_prj/solution1/hls_summary.txt
```

The summary reports:

```text
Estimated clock period
HLS latency and interval
Top-level resource estimates
RTL cosim transaction latency/interval if cosim was run
Slowest dataflow instances by interval
```

Useful overrides:

```bash
HLS_CLOCK=4 make hls
HLS_CSIM=1 make hls
HLS_COSIM=1 make hls
HLS_PROJECT=my_streaming_prj HLS_SOLUTION=trial_a make hls
```

The main scripts are:

```text
project.tcl                         Default part/clock/project settings
build_opt.tcl                       Default flow switches
build_hls.tcl                       Vitis HLS project build
scripts/summarize_hls.py            Compact report extractor
scripts/vivado_ooc_synth.tcl        Optional out-of-context Vivado synthesis
```

The optional Vivado step should be out-of-context:

```bash
HLS_OOC_SYNTH=1 make hls
```

Out-of-context synthesis avoids treating this internal CNN block like a full
device top with externally placed pins and I/O buffers. For quick iteration,
prefer the HLS `csynth` report first; only use OOC synthesis when you need a
more realistic internal-module timing/resource sanity check.

## Development Flow

1. Keep `../cnn_core_project/firmware` unchanged as the baseline.
2. Make C++ HLS changes under `./firmware`.
3. Run `make compare`.
4. If the comparison fails, decide whether the output change is expected. For
   intentional architecture changes, update or extend the testbench/reference
   flow rather than changing the original baseline.

## Current Development Plan

The trigger problem is primarily a throughput problem, not a single-inference
end-to-end latency problem. The fixed model-level semantic contract is:

```text
256 time samples x 4 channels -> one trigger score
```

Adjacent 256-sample chunks are independent for the current trigger definition;
there is no required sliding-window overlap between chunks. Scores only need to
be produced in the same order as the input chunks.

The front-end packet format is a design variable, not a hard constraint. The
ADC/DAQ path can include clock-domain crossing, buffering, packetization, and
scheduling before data reaches the CNN core. Therefore the HLS interface should
be chosen for the best CNN throughput/resource tradeoff rather than for direct
cycle-by-cycle attachment to the ADC. Candidate input granularities include:

```text
16 x 4
32 x 4
64 x 4
128 x 4
256 x 4
```

Larger input blocks may reduce control overhead, but can increase buffering,
routing pressure, resource use, and the cost of internal reshaping. Smaller
blocks may be easier to stream and schedule, but can make it harder to keep the
CNN compute pipeline full. The useful design point should be measured, not
assumed.

The key metric is the steady-state chunk interval: how often the core can
accept a new 256-sample chunk and eventually produce the corresponding score. A
fixed latency of multiple microseconds can still be acceptable if multiple
chunks can be in flight and the interval is short enough. This makes the main
question:

```text
Can the implementation pipeline different chunks concurrently, or does each
chunk block the next chunk until the whole inference completes?
```

The current hls4ml implementation treats one complete 256 x 4 input window as
one inference transaction, which is the correct functional baseline. The
hardware work should focus on reducing the steady-state interval by improving
the input path, the CNN kernels, and the ability to overlap work from different
chunks.

The streaming design should move toward:

```text
ADC/DAQ stream
  -> CDC / buffering / packetization / scheduler
  -> chosen CNN input granularity
  -> convolution kernel
  -> activation
  -> pooling
  -> dense / score logic
  -> trigger output
```

Near-term work should preserve baseline equivalence while isolating the input
path:

1. Use `make compare` as the guardrail while refactoring.
2. Keep the hls4ml baseline untouched under `../cnn_core_project/firmware`.
3. Preserve the model semantic contract: each 256 x 4 chunk produces exactly
   one score, and scores remain ordered.
4. Measure whether the current dataflow core can overlap multiple chunks, using
   interval rather than latency as the main throughput metric.
5. Experiment with input granularities such as 16 x 4, 32 x 4, 64 x 4, 128 x 4,
   and 256 x 4.
6. Replace or wrap the `repack_stream`/full-window input path if it only adds
   format-conversion overhead.
7. Keep output alignment against the baseline for equivalent chunk inputs before
   adding higher-throughput streaming tests.

The input path and CNN kernel cannot be optimized independently. If the current
core cannot accept a new chunk while earlier chunks are still inside later
layers, the CNN structure itself must be changed or replicated. The first
convolution path is therefore a major optimization target together with
`repack_stream`. For waveform-trigger workloads, a 1D-CNN-like implementation
may map more directly to HLS pipelines and FSM scheduling than a general 2D CNN.
The current model is represented as Conv2D with a 5 x 1 kernel over a 256 x 4 x
1 input, so changes to channel mixing or true Conv1D structure should be
coordinated with the model-training side rather than treated as a pure HLS
refactor.

Open design questions:

```text
Throughput target       Can the steady-state pipeline keep up with one 256-sample chunk every 256 ns?
Input granularity       Which packet/block shape gives the best interval/resource tradeoff?
Pipeline overlap        Can multiple chunks be in flight through different CNN stages?
Scheduling strategy     Is one core enough, or is multi-core interleaving required?
Channel mixing          Should early kernels mix the 4 channels, or preserve per-channel feature extraction first?
Quantization            Can heterogeneous or channel-wise quantization reduce kernel cost without accuracy loss?
Reference comparison    How should high-throughput chunk streams be checked against the chunk baseline?
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
processes one complete hls4ml input window at a time. This matches the current
model-level chunk semantic: one non-overlapping 256 x 4 chunk produces one
score. A future ADC-streaming version should replace or wrap the
`repack_stream`/window input path so that the data path accepts the chosen input
granularity efficiently instead of spending cycles on avoidable internal format
conversion. The first milestone is not to change the network math, but to make
the data path support a higher-throughput stream of independent chunks while
preserving baseline outputs for equivalent chunk inputs.

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
5. For a continuous ADC trigger pipeline with non-overlapping chunks, the first
   targets should be the input formatting/repack path, chunk buffering or direct
   chunk streaming, and the first convolution path. Avoid internal data
   reshaping that does not contribute to the one-chunk-in, one-score-out
   contract.

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
