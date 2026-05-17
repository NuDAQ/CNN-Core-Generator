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
