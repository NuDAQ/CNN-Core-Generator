# AI Context for hls_streaming

This file is the compact project memory for future AI/code-editing sessions.
It records what has already been read and understood about the C++ HLS project,
so future work should not need to rediscover the whole generated codebase.

## How Future AI Agents Should Use This File

Start here before scanning the project. This file is intended to be the shared
working memory for Codex, Claude Code, and other AI coding agents.

Recommended workflow:

```text
1. Load this AI_CONTEXT.md.
2. Load hls_streaming/PROJECT_ANALYSIS.md only if more detail is needed.
3. Use hls_streaming/code_analysis/tags and rg for navigation.
4. Read source code only for the specific function/module being changed or verified.
5. After learning a durable new fact, update this file.
6. After generating new tool indexes or reports, document where they are and how to use them.
```

Do not repeatedly re-read the whole project to recover basic context. The
purpose of this file is to avoid that. It is acceptable and expected to read
source code when making an edit, checking a subtle behavior, or validating a
claim. The distinction is:

```text
Use AI_CONTEXT.md for stable project facts and mental model.
Use code reads for exact local implementation details before edits.
Use reports/tool indexes for evidence and cross-checks.
```

Important analysis rule: optimization reasoning should be from the FPGA/RTL
implementation view. Treat the C++ as an HLS specification that becomes RTL
modules, FSMs, FIFOs, handshake logic, local memories, and scheduled
operations. Prefer evidence from generated Verilog/VHDL, HLS schedule reports,
RTL cosim transaction reports, and implementation/synthesis resource reports
over surface-level C loop intuition.

When this file becomes stale, update it in the same change that changes the
code or analysis assumption. Treat it as part of the working project state, not
as a one-time note.

Suggested update rules:

```text
If a layer implementation changes, update Current Model Path and Stage-Level Understanding.
If a type/shape changes, update Data Types and Model Geometry.
If HLS reports change, update Current Bottleneck Facts.
If a new testbench or flow is added, update Codebase Shape and Editing Boundaries.
If a tool index is regenerated, update Tool Artifacts.
If an optimization hypothesis is disproven, mark or remove it.
```

For large future work, prefer this loop:

```text
context -> targeted source read -> edit -> make compare -> HLS/report check if needed -> update context
```

`make compare` is a useful equivalence guardrail, not the project gold
standard. The design owner can change packetization, model-facing interfaces,
test references, and DAQ scheduling to improve total throughput. When an
architecture or model change intentionally changes output values, use
throughput/resource/DAQ-level tests and updated references instead of treating
baseline byte equality as mandatory.

## Current Goal

The current optimization target is steady-state chunk interval, not minimum
single-inference latency.

Fixed model semantic:

```text
256 time samples x 4 positions/channels -> 1 trigger score
```

Adjacent chunks are independent. There is no required sliding-window overlap.
Scores only need to remain ordered with respect to chunks.

The front-end data format is flexible. The ADC/DAQ path can perform CDC,
buffering, packetization, and scheduling before data reaches this CNN core.
Therefore input granularity is a design variable, not a fixed hardware
constraint. Candidate granularities include `16 x 4`, `32 x 4`, `64 x 4`,
`128 x 4`, and `256 x 4`.

## What Was Actually Read

Directly read and analyzed:

```text
hls_streaming/README.md
hls_streaming/Makefile
hls_streaming/tb/compare_runner.cpp
hls_streaming/firmware/cnn_core.cpp
hls_streaming/firmware/cnn_core.h
hls_streaming/firmware/defines.h
hls_streaming/firmware/parameters.h
hls_streaming/firmware/weights/*.h shape comments
hls_streaming/firmware/nnet_utils/nnet_stream.h
hls_streaming/firmware/nnet_utils/nnet_conv2d_stream.h
hls_streaming/firmware/nnet_utils/nnet_conv_stream.h
hls_streaming/firmware/nnet_utils/nnet_activation_stream.h
hls_streaming/firmware/nnet_utils/nnet_pooling_stream.h
hls_streaming/firmware/nnet_utils/nnet_dense.h
hls_streaming/firmware/nnet_utils/nnet_dense_stream.h
hls_streaming/firmware/nnet_utils/nnet_dense_latency.h
hls_streaming/firmware/nnet_utils/nnet_helpers.h testbench helpers
cnn_core_project/cnn_core_prj/solution1/syn/report/* relevant HLS reports
cnn_core_project/cnn_core_prj/solution1/sim/verilog/cnn_core.performance.result.transaction.xml
```

Tool-assisted inspected:

```text
ctags symbol index over firmware and tb
rg search over all nnet_utils symbols/includes/call names
tree and line-count summaries
HLS report grep for latency, interval, loop II, and per-block resources
```

Not line-by-line read because they are support/generated libraries:

```text
hls_streaming/firmware/ap_types/*
most unused hls_streaming/firmware/nnet_utils/*.h
```

The unused `nnet_utils` headers were categorized by symbol search. They are
available as reference implementations but are not on the current model path.

## Codebase Shape

`hls_streaming` is a working copy of the generated hls4ml firmware plus a small
comparison harness.

```text
../cnn_core_project/firmware   immutable hls4ml baseline
hls_streaming/firmware         editable C++ HLS working copy
hls_streaming/tb               comparison runner
hls_streaming/Makefile         builds baseline_runner and streaming_runner
```

The current comparison is behavioral C++ comparison, not RTL comparison.

`make compare` does this:

```text
1. Copy and patch temporary ap_types under build/.
2. Build baseline_runner from tb/compare_runner.cpp and ../cnn_core_project/firmware/cnn_core.cpp.
3. Build streaming_runner from tb/compare_runner.cpp and hls_streaming/firmware/cnn_core.cpp.
4. Run both on SAMPLES deterministic chunks, default 8.
5. Compare output logs byte-for-byte.
```

Useful Makefile knobs:

```text
make compare SAMPLES=128
make compare ALLOW_MISMATCH=1
make run-streaming SAMPLES=1024
```

Current verification status:

```text
make compare: PASS
latest checked after first_conv_4lane_temporal_cl replacement: PASS
extra 128-chunk runner comparison after replacement: PASS
make compare PASS after ring-buffer + stride-counter + nonoverlap-pool: PASS (8 chunks)
make compare SAMPLES=128 PASS after same changes: PASS (128 chunks)
make compare SAMPLES=1024 PASS after wide first_conv + unpack adapter: PASS (1024 chunks)
make compare SAMPLES=1024 PASS after flat unpack adapter: PASS (1024 chunks)
make compare SAMPLES=1024 PASS after wide ReLU + wide pool: PASS (1024 chunks)
```

## Current Model Path

The current `hls_streaming/firmware` active model is:

```text
cnn_core(input_layer, layer7_out)
  -> first_conv_4lane_temporal_wide_cl<input_t, layer3x4_t, config3> [packs 4 width outputs]
  -> relu<layer3x4_t, layer4x4_t, relu_config4>                    [wide ReLU]
  -> maxpool2d_wide_nonoverlap_cl<layer4x4_t, layer5x4_t, config5>  [wide non-overlap pool]
  -> dense_wide_stream<layer5x4_t, result_t, config7>               [wide streaming dense]
```

The immutable baseline under `../cnn_core_project/firmware` still uses:

```text
repack_stream<input_t, layer2_t, 1024>
  -> conv_2d_cl<layer2_t, layer3_t, config3>
  -> pooling2d_cl (ap_shift_reg based)
```

The working copy is behavior-equivalent in C++ comparison for all tested vectors.
The latest confirmed HLS csynth result after the wide-ReLU/wide-pool experiment
is top latency / interval 265 / 260 cycles. This is close to the current
single-core, one-input-word-per-cycle lower bound of 256 cycles.

`cnn_core()` has:

```text
#pragma HLS INTERFACE axis port=input_layer,layer7_out
#pragma HLS DATAFLOW
```

Internal streams:

```text
layer3x4_out depth 4      wide first-conv output, packed 4 widths x 7 filters
layer4x4_out depth 4      wide ReLU output, packed 4 widths x 7 filters
layer5x4_out depth 4      wide MaxPool output, packed 4 widths x 7 filters
```

## Data Types

From `defines.h`:

```text
input_t   = nnet::array<ap_fixed<12,6>, 4>
layer2_t  = nnet::array<ap_fixed<12,6>, 1>
layer3_t  = nnet::array<ap_fixed<9,5>, 7>
layer3x4_t = nnet::array<ap_fixed<9,5>, 28>
layer4_t  = nnet::array<ap_fixed<16,6>, 7>
layer4x4_t = nnet::array<ap_fixed<16,6>, 28>
layer5_t  = nnet::array<ap_fixed<16,6>, 7>
layer5x4_t = nnet::array<ap_fixed<16,6>, 28>
result_t  = nnet::array<ap_fixed<16,6>, 1>
```

`input_t` contains 4 fixed-point values per AXI-stream word.

Current output precision note: `result_t` was widened from `ap_fixed<9,5>` to
`ap_fixed<16,6>` after wrapper/Keras comparison showed final-score wraparound
on large positive samples such as 675 and 933. Baseline C++, streaming C++, and
wrapper RTL matched exactly before this change; the wrap originated in the
shared hls4ml output type, not in the optimized streaming architecture. The
wrapper/testbench score decoder must interpret the 16-bit output as
`ap_fixed<16,6>` (divide signed raw output by 1024), not the old
`ap_fixed<9,5>` byte-aligned format (divide low 9 bits by 16).

Important interpretation: the model represents the input as `256 x 4 x 1`,
not as `256 x 1 x 4`. That means the four values are the width dimension, while
`n_chan = 1`.

## Model Geometry

From `parameters.h`:

```text
Input:      256 x 4 x 1
Conv2D:     kernel 5 x 1, 7 filters, stride 3 x 1
Conv out:   84 x 4 x 7 = 2352 scalar values = 336 stream words of 7
ReLU:       2352 values = 336 stream words of 7
MaxPool2D:  pool 2 x 1, stride 2 x 1
Pool out:   42 x 4 x 7 = 1176 scalar values = 168 stream words of 7
Dense:      1176 -> 1 score
```

Weights:

```text
w3: 5 x 1 x 1 x 7 = 35 values
b3: 7 values
w7: 1176 x 1 values
b7: 1 value
```

Consequence: the first convolution is temporal filtering applied independently
at each of the four width positions. Early cross-position/channel mixing is not
done in Conv2D. Cross-position information can only combine in the dense layer
unless the model structure changes.

## Stage-Level Understanding

### first_conv_4lane_temporal_cl

Location:

```text
firmware/nnet_utils/nnet_first_conv_stream.h
```

Working-copy status:

```text
Replaces repack_stream + conv_2d_cl in hls_streaming/firmware/cnn_core.cpp.
Consumes 256 input_t words directly, each with 4 lanes.
Maintains a 5 x 4 row window (ring buffer, not shift register).
Emits 84 layer3x4_t wide words, then unpack adapter restores 336 layer3_t words.
make compare 8/128/1024 chunks: PASS.
HLS csynth after wide-output first_conv + nested unpack adapter: first_conv
fixed, unpack adapter bottlenecked the top interval. Source now uses a flat
unpack loop; HLS csynth pending.
```

Previous csynth result (shift-register version, before ring-buffer fix):

```text
top latency / interval:      1041 / 1041 cycles
first_conv latency/interval: 1040 / 1040 cycles
first_conv ReadInputHeight:  trip count 256, achieved II=4
estimated clock:             3.236 ns at a 5.00 ns top target
first_conv resources:        4 DSP, 1198 FF, 3700 LUT, 0 BRAM
II violation cause:          loop-carried RAW on row_window shift register
urem overhead:               % stride_height → ~189 FF + 106 LUT divider
```

Changes applied (nnet_first_conv_stream.h):

```text
1. row_window[5][4] (shift register) → row_buf[5][4] (ring buffer, wptr pointer).
   Each iteration writes one slot; #pragma HLS DEPENDENCE variable=row_buf inter false
   tells HLS no inter-iteration RAW exists, removing the II violation source.
2. % CONFIG_T::stride_height → unsigned stride_cnt counter.
   Eliminates the urem synthesized divider (~295 FF+LUT saved).
3. CopyKernel reads via circular index ridx = (oldest + k) % filt_height
   implemented as a branch (no division; HLS generates a 5:1 register mux).
4. ap_uint<3>/ap_uint<2> indices → plain unsigned.
   Avoids HLS 214-358 bit-extension warning on array index paths.
```

New implementation (nnet_pooling_stream.h, maxpool2d_nonoverlap_cl):

```text
prev_row changed from data_T[in_width] (struct array, causes HLS 214-338 partition error)
to data_value_t[in_width][data_T::size] (primitive 2D array, complete partition works).
Element-wise StorePrev loop (unrolled) replaces struct assignment.
Verified: make compare SAMPLES=128 PASS after fix.
```

Confirmed csynth result after ring-buffer + stride-counter + nonoverlap-pool (2026-05-17):

```text
top latency / interval:        1032 / 1029 cycles
first_conv latency/interval:   1028 / 1028 cycles   (II=4, see root cause below)
maxpool2d_nonoverlap:           339 /  339 cycles   (II=1 confirmed, PoolMain trip 336)
relu latency/interval:          339 /  339 cycles   (unchanged)
dense latency/interval:         176 /  176 cycles   (unchanged)
estimated clock:               3.886 ns at 5.00 ns  (up from 3.236 ns, ring mux path)
Resources:                  18 BRAM_18K, 17 DSP, 29687 FF, 37553 LUT
```

Confirmed root cause of first_conv II=4 (post-fix):

```text
WriteOutputWidth was completely unrolled by the outer PIPELINE pragma (confirmed in log).
The 4 unrolled res.write() calls to the same hls::stream cannot be parallelized.
HLS schedules them as 4 sequential cycles → outer loop II=4.
The RAW dependency is gone; the new bottleneck is stream-write throughput.
Net gain from ring buffer: only −12 cycles (from urem removal, not RAW fix).
```

Clock path concern:

```text
3.886 ns + 1.35 ns uncertainty = 5.24 ns > 5.00 ns target (csynth estimate only).
Suspect path: oldest + k → ridx mux → row_buf register → kernel_data → dense.
20 sparsemux instances (5:1 mux, 4 lanes × 5 ring positions) add ~520 LUT.
Verify after OOC synthesis before treating as a hard timing failure.
```

Next step for first_conv interval: eliminate the 4 sequential stream writes.
Implemented experiment:

```text
first_conv_4lane_temporal_wide_cl:
  84 stride events -> 84 writes of layer3x4_t (4 widths x 7 filters)

unpack_4lane_temporal_cl:
  84 reads of layer3x4_t -> 336 writes of layer3_t

Nested-unpack HLS result:
  top latency / interval:        844 / 842 cycles
  first_conv wide:               259 / 259 cycles, ReadInputHeightWide II=1
  unpack adapter:                841 / 841 cycles
  relu / maxpool2d_nonoverlap:   339 / 339 cycles each
```

The first-conv hypothesis is confirmed: packing 4 width outputs into one
`layer3x4_t` write removes the II=4 output-FIFO bottleneck. The adapter did not
meet the expected ~336-cycle limit because HLS schedules the outer
`UnpackOutputHeight` loop as an unpipelined loop with latency 840 cycles. It
calls the pipelined `UnpackOutputWidth` helper 84 times, and that helper has
latency/interval 6 cycles despite inner II=1.

Source update after this report: unpack is now a flat 336-iteration loop with a
small current-wide-word register and a width counter. It reads one `layer3x4_t`
when the width counter is zero and writes one `layer3_t` every cycle, targeting
about 336-339 cycles. `make compare SAMPLES=1024` passes after this change.

Flat-unpack HLS result:

```text
top latency / interval:        345 / 340 cycles
unpack flat:                   339 / 339 cycles, UnpackOutputFlat II=1
first_conv wide:               259 / 259 cycles, ReadInputHeightWide II=1
relu / maxpool2d_nonoverlap:   339 / 339 cycles each
dense:                         176 / 176 cycles
estimated clock:               3.886 ns at 5.00 ns target
Resources:                  32 BRAM_18K, 17 DSP, 30269 FF, 37938 LUT
```

The larger follow-on experiment is to push 4-width packing through ReLU and pool
rather than unpacking immediately. Source update: this experiment is now
implemented by running `relu<layer3x4_t, layer4x4_t>` and
`maxpool2d_wide_nonoverlap_cl<layer4x4_t, layer5x4_t>`, then unpacking only
after pool to preserve dense input format. `layer3x4_out`, `layer4x4_out`, and
`layer5x4_out` FIFO depths are set to 4 to avoid full-frame BRAM buffering.
`make compare SAMPLES=1024` passes.

Wide-ReLU/wide-pool HLS result:

```text
top latency / interval:        265 / 260 cycles
first_conv wide:               259 / 259 cycles
wide ReLU:                       87 /  87 cycles
wide maxpool2d_nonoverlap:       87 /  87 cycles
post-pool unpack:              171 / 171 cycles
dense:                         176 / 176 cycles
estimated clock:               3.886 ns at 5.00 ns target
Resources:                  57 BRAM_18K, 17 DSP, 30852 FF, 39067 LUT
```

The optimization reaches the expected first-conv limit. Remaining single-core
cycle-level improvement is only a few cycles unless input width, core count, or
model/chunk semantics change. Resource cleanup is still useful: HLS maps the
shallow 448-bit `layer4x4_out` and `layer5x4_out` FIFOs to 25 BRAM_18K each
despite depth 4; bind these shallow wide FIFOs to LUTRAM/SRL or otherwise avoid
BRAM inference.

Source update after this report:

```text
#pragma HLS BIND_STORAGE variable=layer4x4_out type=fifo impl=srl
#pragma HLS BIND_STORAGE variable=layer5x4_out type=fifo impl=srl
make compare SAMPLES=1024: PASS
```

HLS csynth is pending for this resource-cleanup change. Expected result: top
interval stays near 260 cycles, while BRAM drops substantially if Vitis accepts
the SRL binding for these shallow 448-bit FIFOs.

Confirmed HLS result after SRL FIFO binding:

```text
top latency / interval:        265 / 260 cycles
estimated clock:               3.886 ns at 5.00 ns target
Resources:                   7 BRAM_18K, 17 DSP, 30756 FF, 39119 LUT
```

FIFO implementation:

```text
layer3x4_out depth 4, 252 bits -> SRL, 0 BRAM
layer4x4_out depth 4, 448 bits -> SRL, 0 BRAM
layer5x4_out depth 4, 448 bits -> SRL, 0 BRAM
layer5_out   depth 168,112 bits -> RAM, 7 BRAM_18K
```

This fixes the BRAM regression without changing interval. Remaining resource
hotspot is dense: about 27.9k FF and 31.8k LUT, while dense interval is only
176 cycles and the top interval is 260 cycles.

Current dense resource experiment:

```text
config7::reuse_factor: 1 -> 42
make compare SAMPLES=1024: PASS
```

HLS result with RF=42:

```text
top latency / interval:        265 / 260 cycles
estimated clock:               3.886 ns at 5.00 ns target
Resources:                   7 BRAM_18K, 17 DSP, 25733 FF, 39159 LUT
dense interval:                176 cycles
dense resources:             13 DSP, 22865 FF, 31807 LUT
```

Compared with RF=1, the top interval and dense interval are unchanged. Dense FF
drops by about 5k, but DSP is unchanged and LUT is essentially unchanged. The
current hls4ml latency dense implementation still fully partitions the input
and intermediate arrays and fully unrolls the product/accumulation loops, so
`reuse_factor` alone is not a strong resource-control knob here. The next dense
resource step should be a custom streaming/wide dense that accumulates directly
from `layer5x4_t` words, instead of unpacking into a 1176-scalar fully
partitioned array.

Source update after this report:

```text
maxpool_wide -> dense_wide_stream -> result
make compare SAMPLES=1024: PASS
```

`dense_wide_stream` reads the 42 pooled `layer5x4_t` words directly. It processes
one width lane per cycle and unrolls the 7 filters inside that lane, so the
expected dense interval is about 168 cycles. This keeps dense below the
259-cycle first-conv limiter while removing the post-pool unpack stage and the
168-deep `layer5_out` FIFO. HLS csynth is pending for the actual resource and
timing estimates.

Confirmed HLS result after wide streaming dense:

```text
top latency / interval:        263 / 260 cycles
estimated clock:               3.886 ns at 5.00 ns target
Resources:                   0 BRAM_18K, 11 DSP, 2975 FF, 26500 LUT
first_conv interval:           259 cycles
dense_wide interval:           176 cycles
dense_wide resources:        7 DSP, 769 FF, 19616 LUT
```

The post-pool unpack stage and `layer5_out` FIFO are gone. BRAM is now zero,
FF is roughly 10x lower than the hls4ml baseline, and throughput remains at the
first-conv lower bound. Dense LUT remains noticeable because the 7-lane streaming
dense dynamically indexes fully partitioned weights, which HLS implements with
large muxing; this is now a resource cleanup issue, not a throughput issue.

Source update after this report: the final `result_t` precision is now
`ap_fixed<16,6>` to avoid output wraparound. `make compare SAMPLES=1024` passes
after the type change, so the baseline and optimized C++ paths remain exactly
aligned under the new output precision. HLS csynth and wrapper RTL need to be
rerun before treating the older 263/260-cycle resource/timing numbers as
current.

### repack_stream

Location:

```text
firmware/nnet_utils/nnet_stream.h
```

Instantiation:

```text
data_T = input_t   size 4
res_T  = layer2_t  size 1
N      = 1024
```

Behavior:

```text
reads 256 input words, each with 4 values
writes 1024 scalar words, each with 1 value
```

The active branch is `data_T::size > res_T::size`. For each input word, the
function writes four output words.

Observed HLS report:

```text
latency / interval: 3075 cycles
trip count:         1024
achieved II:        3
generated RTL:      5-state pipelined FSM, pipeline depth 5
local storage:      4 x 12-bit in_data RAM/register file
input interface:    64-bit AXIS input_layer
output interface:   12-bit ap_fifo layer8_out, depth 1024
```

Meaning: this is currently the largest interval limiter, and it performs only
format conversion in the original hls4ml baseline. In the current working copy,
it has been bypassed by `first_conv_4lane_temporal_cl`; keep this section as
the baseline bottleneck evidence for the old generated RTL.

RTL-level interpretation:

```text
input_layer_TDATA carries four useful 12-bit lanes in a 64-bit AXIS word.
The generated RTL stores those four lanes into a tiny 4-entry local memory.
It then reads one 12-bit lane and writes one scalar word to layer8_out.
The flattened output loop has 1024 iterations and II=3, so one scalar leaves
about every three cycles even when input/output handshakes are not stalling.
```

The limiting issue is not LUT/DSP/BRAM area. `repack_stream` uses only about
86 FF and 264 LUT in the HLS estimate. The issue is the scheduled RTL shape:
AXIS read, lane extraction, local memory writes, local memory read, and
ap_fifo write are serialized through the HLS-generated FSM. Because the
downstream Conv2D expects a scalar `layer2_t` stream, the design pays four
scalar output transactions for every one 4-lane input word.

Optimization stance:

```text
Do not treat repack_stream as a C helper to micro-optimize.
Treat it as an RTL protocol/data-width adapter that should disappear or be
fused into the first convolution.
Best target: consume input_t directly in a model-specific first-conv RTL/HLS
block and emit the same 336 layer3_t words as baseline Conv2D.
```

### conv_2d_cl

Locations:

```text
firmware/nnet_utils/nnet_conv2d_stream.h
firmware/nnet_utils/nnet_conv_stream.h
```

Instantiation:

```text
data_T = layer2_t  size 1
res_T  = layer3_t  size 7
CONFIG = config3
```

Behavior:

```text
reads 1024 scalar pixels
uses linebuffer implementation
produces 336 output words, each with 7 filter values
```

Call path:

```text
conv_2d_cl
  -> conv_2d_buffer_latency_cl
  -> compute_output_buffer_2d
  -> shift_line_buffer
  -> DenseLatency over 5 input values and 7 filters
```

Observed HLS report:

```text
latency / interval: 2051 cycles
input loop trip:    1024
achieved II:        2
```

Meaning: the multiply itself is small, but the scalarized input stream,
line-buffer/counter schedule, and II=2 make it the second major interval
problem.

### ReLU

Location:

```text
firmware/nnet_utils/nnet_activation_stream.h
```

Behavior:

```text
reads 336 words of 7
writes 336 words of 7
elementwise max(x, 0)
```

Observed HLS report:

```text
latency / interval: 339 cycles
achieved II:        1
```

Meaning: simple streaming stage, not a main optimization target.

### maxpool2d_nonoverlap_cl  (replaces pooling2d_cl)

Location:

```text
firmware/nnet_utils/nnet_pooling_stream.h  (added at end of file)
firmware/cnn_core.cpp: call changed from pooling2d_cl to maxpool2d_nonoverlap_cl
```

Behavior:

```text
reads 336 words of 7  (84 rows x 4 width, each word = 7 filters)
non-overlapping 2x1 max pool (pool_height=2, stride_height=2, pool_width=1)
writes 168 words of 7
```

Previous pooling2d_cl HLS report (ap_shift_reg based, II=2):

```text
latency / interval: 674 cycles
input loop trip:    336
achieved II:        2
root cause:         ap_shift_reg read-modify-write + conditional FiltLoop
```

New implementation (flat single loop, target II=1):

```text
Single PoolMain loop: 84 * 4 = 336 iterations, #pragma HLS PIPELINE II=1
State: prev_row[in_width=4] (array of data_T, complete partition) + on_second_row bool
First row pass:  store data.read() into prev_row[i_w]
Second row pass: elementwise max(prev_row[i_w], cur), write to res
No ap_shift_reg, no static counters, no conditional nested loops.
Expected interval: ~336 cycles (2x improvement over 674).
HLS csynth pending.
```

Static asserts guard correct use: pool_height==2, pool==stride, pool_width==1, no padding, Max op.

### dense

Locations:

```text
firmware/nnet_utils/nnet_dense_stream.h
firmware/nnet_utils/nnet_dense_latency.h
```

Behavior:

```text
data_prepare reads 168 stream words x 7 = 1176 scalar values
stores them into a fully partitioned local array
dense_latency computes 1176 -> 1
res_write emits 1 result word
```

Observed HLS report:

```text
whole dense latency / interval: 176 cycles
data_prepare:                    170 cycles
dense_latency_wrapper:             2 cycles, II=1
```

Resource note:

```text
dense block HLS estimate: 13 DSP, 27888 FF, 31767 LUT
```

Meaning: dense is not the current interval limiter, but it is the main resource
hotspot. It should become a resource optimization target after repack/conv/pool
intervals are improved.

## Current Bottleneck Facts

All numbers are HLS csynth estimates unless noted. No OOC or RTL cosim yet.

Last confirmed HLS csynth (shift-register first_conv + pooling2d_cl, before ring-buffer + pool changes):

```text
HLS latency estimate:    1041 cycles
HLS interval estimate:   1041 cycles
Estimated clock:         3.236 ns at 5.00 ns target
Resources:               18 BRAM_18K, 17 DSP, 30477 FF, 36936 LUT
```

```text
Stage                      Latency   Interval   Why it mattered
first_conv_4lane_temporal     1040       1040   II=4 from shift-register RAW + urem
pooling2d_cl                   674        674   II=2 from ap_shift_reg
relu                           339        339   simple stream stage, II=1
dense                          176        176   resource-heavy, not interval limiter
```

Confirmed bottleneck chain after ring-buffer + nonoverlap-pool (2026-05-17):

```text
Stage                   Interval   II   Notes
first_conv (ring buf)     1028      4   stream-write throughput limit (4 writes/stride)
relu                       339      1   simple stage, unchanged
maxpool2d_nonoverlap       339      1   II=1 confirmed, was 674 (II=2)
dense                      176      -   resource hotspot, not interval limiter
Top interval              1029          first_conv dominates; pool gain absorbed
```

Pool improvement (674→339) is real but invisible at top level while first_conv > 339.
Top interval gain this round: 1041 → 1029 (−12 cycles, ~1%).
Current source breaks first_conv's 4-write bottleneck and flattens unpack. HLS
confirms first_conv drops to 259 cycles, unpack drops to 339 cycles, and the top
interval reaches 340 cycles. The current bottleneck is a three-way tie:
unpack/ReLU/maxpool at about 339 cycles.

After pushing 4-width packing through ReLU and pool, the top interval is 260
cycles. The bottleneck is now first_conv at 259 cycles, which is essentially the
256 input-read lower bound plus pipeline overhead.

Baseline reports before first-conv replacement:

```text
RTL cosim latency:       3068 cycles
RTL cosim interval:      3074 cycles
HLS latency estimate:    3082 cycles
HLS interval estimate:   3076 cycles
Estimated clock:         3.236 ns at a 5.00 ns target
```

Baseline per-stage estimates:

```text
Stage          Latency   Interval   Why it matters
repack_stream     3075       3075   largest limiter, pure reshaping
conv_2d           2051       2051   main compute/input kernel
pooling2d          674        674   II=2 over 336 inputs
relu               339        339   simple stream stage
dense              176        176   resource-heavy, not interval limiter
```

Interpretation:

```text
DATAFLOW overlaps stages within a transaction.
The top-level interval is near the slowest stage, not the sum.
The slowest stage moved from repack_stream at about 3075 cycles to first_conv at
about 1040 cycles.
The current design is about 3x faster than the generated baseline but still not
a 1-sample-per-cycle or 1-chunk-per-256-cycle persistent engine.
```

## Transaction Model vs Desired Engine

Current design:

```text
call cnn_core once
  -> consume one complete 256 x 4 chunk
  -> produce one score
  -> next transaction starts after long interval
```

Desired direction:

```text
accept ordered chunks at a much shorter steady-state interval
allow longer end-to-end latency
keep multiple chunks in flight if needed
preserve one score per chunk in order
```

The key architectural question is whether a new chunk can enter while older
chunks occupy later CNN stages. Current reports suggest that the generated
transaction-level top function does not achieve this at the needed interval.

## Editing Boundaries

Do not edit the baseline unless explicitly asked:

```text
../cnn_core_project/firmware
```

Edit experiments here:

```text
hls_streaming/firmware
```

Preserve behavior with:

```text
cd hls_streaming
make compare
```

For math-preserving refactors, output should remain byte-for-byte identical to
baseline for equivalent chunk inputs.

## Local HLS Estimate Flow

`hls_streaming` has an independent lightweight Vitis HLS flow, separate from
the hls4ml-generated `cnn_core_project` scripts.

```text
hls_streaming/project.tcl                  part/clock/project defaults
hls_streaming/build_opt.tcl                flow switches
hls_streaming/build_hls.tcl                creates/runs the HLS project
hls_streaming/scripts/run_hls.sh           shell entry point
hls_streaming/scripts/summarize_hls.py     extracts compact latency/clock/resource summary
hls_streaming/scripts/vivado_ooc_synth.tcl optional out-of-context Vivado synthesis
```

Default remote-Ubuntu use:

```bash
cd hls_streaming
source /tools/Xilinx/Vitis/2023.2/settings64.sh
make hls
```

Useful overrides:

```bash
HLS_CLOCK=4 make hls
HLS_CSIM=1 make hls
HLS_COSIM=1 make hls
HLS_PROJECT=my_streaming_prj HLS_SOLUTION=trial_a make hls
HLS_OOC_SYNTH=1 make hls
```

Default output:

```text
cnn_core_streaming_prj/solution1/hls_summary.txt
```

The default flow runs `csynth_design` only. This is intentional for quick
iteration on estimated clock, latency/interval, top resources, and slowest
instances. Avoid using full top-level implementation as the first timing
signal, because this CNN core is intended as an internal module. If extra
timing/resource checking is needed, use the OOC Vivado flow so external
pin/IO-buffer assumptions do not dominate the result.

## Best First Optimization Experiments

1. Replace `repack_stream + conv_2d_cl` with a model-specific first-conv block.

   Target equivalence:

   ```text
   input_t stream of 256 words x 4 lanes
     -> custom first conv
     -> same 336 layer3_t words as baseline conv
   ```

   Reason: this attacks both the largest non-compute bottleneck and the second
   bottleneck together. From the RTL view, the goal is to remove the scalar
   adapter and its 1024-iteration II=3 output schedule, not merely to rewrite
   the C++ helper.

2. Test input granularity variants.

   Candidate internal formats:

   ```text
   16 x 4, 32 x 4, 64 x 4, 128 x 4, 256 x 4
   ```

   These are not ADC constraints. They are scheduling/interface experiments.

3. Add a throughput-oriented testbench.

   The current C++ compare runner calls `cnn_core()` once per chunk. It checks
   functional equivalence, not true stream throughput. A new testbench should
   help reason about many chunks in order and about accepted chunk interval.

4. Consider persistent streaming top-level logic.

   A future design may need a top-level loop over chunks, with dataflow stages
   operating continuously across chunk boundaries. Static counters in current
   linebuffer helpers reset after one image; audit carefully before reusing them
   in a persistent design.

5. Consider multi-core interleaving if one core cannot meet interval.

   Round-robin chunk dispatch is architecturally simple, but costs resources and
   power. It should be evaluated after single-core interval improvements.

6. Revisit dense only after interval bottlenecks move.

   Dense dominates FF/LUT/DSP estimates but currently has only 176-cycle
   interval. Optimize dense resource use later via quantization, sparsity,
   reuse, or a different dense strategy.

## Useful Search Commands

Active top-level calls:

```bash
rg -n "nnet::(repack_stream|conv_2d_cl|relu|pooling2d_cl|dense)" hls_streaming/firmware
```

Layer configs:

```bash
rg -n "struct config3|struct relu_config4|struct config5|struct config7" hls_streaming/firmware/parameters.h
```

Report bottlenecks:

```bash
rg -n "Latency|Interval|repack_stream|conv_2d|pooling2d|dense|achieved" cnn_core_project/cnn_core_prj/solution1/syn/report
```

Generated symbol index:

```bash
ctags -x hls_streaming/firmware/cnn_core.cpp hls_streaming/firmware/parameters.h hls_streaming/firmware/nnet_utils/nnet_conv_stream.h
```

## Tool Artifacts

`hls_streaming/code_analysis/tags` is a generated ctags index.

`hls_streaming/code_analysis/cscope.files` lists the source files selected for
cross-reference indexing, excluding `ap_types` and `build`.

Note: the local `cscope` binary generated a database, but query mode reported
`cannot read trailer offset` on this workspace path. Treat ctags/rg as reliable
for now unless cscope is regenerated from a path without spaces/iCloud
components.

To regenerate the ctags index after code changes:

```bash
ctags -R -f hls_streaming/code_analysis/tags hls_streaming/firmware hls_streaming/tb
```

To refresh the selected source list:

```bash
find hls_streaming/firmware hls_streaming/tb \
  -path 'hls_streaming/firmware/ap_types' -prune -o \
  -path 'hls_streaming/build' -prune -o \
  -type f \( -name '*.h' -o -name '*.cpp' \) -print \
  > hls_streaming/code_analysis/cscope.files
```

After regenerating any tool database, add a short note here if the workflow or
tool behavior changes.
