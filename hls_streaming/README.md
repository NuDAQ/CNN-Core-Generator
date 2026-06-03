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

Current verified results (pair parallelism, commit 14f2686):

```
csynth interval:   178 cycles   (dense bottleneck 177, first_conv 131)
RTL cosim:         177 cycles max, PASS
OOC LUT (logic):   4829  (2.2%)
OOC LUT (SR):      1093  (1.1%, 5-row shift-register row buffer)
OOC FF:            2953  (0.7%)
OOC DSP:           7
OOC BRAM:          2× RAMB18E2  (0.2%)
OOC WNS:           +2.152 ns ✓
```

After edits to `first_conv_2row_4lane_temporal_wide_cl`, check the
`ReadPairsWide` loop in the generated first-conv report. The loop iterates
over input pairs (`in_height/2` = 128 iterations). Each iteration reads one
stream word (row0 + row1), snapshots the registered `row_buf` into a local
`old_buf` (wire connections, no extra register stage), advances `row_buf` by
two rows from `old_buf` and inputs, and conditionally emits a MAC result.

Scheduling rule: the `AdvanceBufPair` block writes `row_buf` from `old_buf`
and current inputs in a single unrolled stage. Because all sources are
registered values (old_buf) or combinational stream inputs, the write lands at
stage 0 and is visible to stage 0 of the next iteration — II=1 is achievable.

`pair_phase` cycles 0→1→2→0... (for stride_height=3):
- phase == EMIT_ROW0_PHASE (2): emit row0 MAC output
- phase == EMIT_ROW1_PHASE (0): emit row1 MAC output
- phase == 1: no output
Stride=3 guarantees at most one output per pair iteration.

### History of II violations

| Attempt | Loop | II | Root cause |
|---------|------|----|------------|
| Ring buffer | `ReadInputPairsWide` (128 iter) | 2 | Variable-index ring pointer, aliasing |
| Shift register, 2-shift | `ReadInputPairsWide` (128 iter) | 2 | ShiftRow0 writes row_buf; ShiftRow1 reads it within same iteration → 2-stage RAW |
| Shift register, 1-shift | `ReadInputsWide` (256 iter) | **1** | One shift per iteration; per-row loop |
| **Pair parallelism** | **`ReadPairsWide` (128 iter)** | **1** | old_buf snapshot; row_buf updated from registered values only |

If Vitis reports `II=2` on `ReadPairsWide`, the most likely cause is that
`old_buf` was inferred as a registered pipeline stage rather than a wire
connection. Check that `old_buf` is fully unrolled (`complete` partition) and
that the `AdvanceBufPair` write is not conditional on any loop-carried variable.
