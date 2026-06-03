# Homogeneous Streaming HLS Workspace

This directory is the editable C++ HLS implementation for the v3.4
homogeneous HGQ model. The generated functional reference remains in
`../cnn_core_project`.

## Current Contract

The generated baseline consumes one time row per AXIS word:

```text
input_layer_t = 1 time sample x 4 lanes
```

The optimized streaming top consumes two time rows per AXIS word:

```text
input_layer_x2_t = 2 time samples x 4 lanes
```

Both implementations still compute one score for the same semantic input:

```text
256 x 4 input chunk -> 1 trigger score
```

The comparison testbench packs the same deterministic input data into either
the baseline 1x stream or the optimized 2x stream, then compares output logs
byte-for-byte.

## Optimized Path

Current top-level path:

```text
input_layer_x2_t
  -> first_conv_2row_4lane_temporal_wide_cl
  -> relu<q_conv2d_x4_t, q_conv2d_relu_x4_t>
  -> maxpool2d_wide_nonoverlap_cl
  -> dense_wide_stream
  -> layer9_out
```

This path keeps the homogeneous HGQ fixed-point types generated into
`firmware/defines.h` and `firmware/parameters.h`. It does not use the old
heterogeneous per-index HGQ cast tables from earlier branches.

## Validation

Run C++ behavioral equivalence before HLS:

```bash
make compare
make compare SAMPLES=1024
```

Run HLS in a Vitis environment:

```bash
make hls
make hls-ooc-synth
```

`build_hls.tcl` passes `-DHLS_STREAMING_2X_INPUT` to the C simulation
testbench by default. Without that flag, the testbench creates a 1x input
stream and CSIM fails because the top-level function now expects
`input_layer_x2_t`.

Record top interval, stage intervals, estimated clock, LUT/FF/DSP/BRAM, and
any unexpected RAM inference after every meaningful schedule change.
