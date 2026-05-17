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
