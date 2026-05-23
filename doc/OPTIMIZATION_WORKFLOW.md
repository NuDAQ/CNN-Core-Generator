# HLS CNN Optimization Workflow

This document describes a reusable workflow for turning an hls4ml-generated
CNN core into a higher-throughput C++ HLS implementation while preserving the
model-level semantics. It is written to support three use cases:

1. Manual optimization of this repository's current CNN trigger core.
2. Porting the same style of optimization to other similar hls4ml models.
3. Future automation scripts that can inspect generated model files, propose
   transformations, run checks, and summarize evidence.

The concrete reference implementation is the current `hls_streaming` design.
The general method is more important than the exact function names, but the
function names and report numbers are included because they are useful anchors
for correctness.

## Core Principle

Optimize the FPGA/RTL implementation, not the surface appearance of the C++.

hls4ml emits C++ that describes an HLS design. The real object being optimized
is the RTL that Vitis HLS creates: modules, FIFOs, FSM states, ready/valid
handshakes, local memories, inferred RAMs, loop initiation intervals, and
scheduled operations. A C++ loop that looks small can become the transaction
interval bottleneck if it creates a narrow stream boundary or a poor schedule.

The first goal is not to change the neural-network math. The first goal is to
remove unnecessary data reshaping and stream-width mismatches while keeping the
same model semantic:

```text
one 256 x 4 input chunk -> one trigger score
```

For the current trigger definition, adjacent chunks are independent. There is
no required sliding-window overlap. Output scores only need to remain ordered
with respect to input chunks.

The main performance metric is the steady-state chunk interval, not minimum
single-inference latency. A fixed latency of multiple microseconds can be
acceptable if the design can accept new chunks often enough. A low-latency
single-transaction design is not automatically a high-throughput streaming
trigger.

## Current Repository Roles

Keep the generated baseline and optimized working copy separate.

```text
cnn_core_project/firmware
    Immutable hls4ml-generated functional baseline.

hls_streaming/firmware
    Editable C++ HLS working copy for throughput/resource optimization.

hls_streaming/tb/compare_runner.cpp
    C++ behavioral comparison testbench.

hls_streaming/Makefile
    Builds baseline_runner and streaming_runner, then compares output logs.

hls_streaming/AI_CONTEXT.md
    Durable project memory for future AI/code-editing sessions.

hls_streaming/PROJECT_ANALYSIS.md
    Detailed bottleneck and report analysis.
```

The baseline should stay available as a reference even when the optimized copy
diverges structurally. Do not modify the baseline merely to make the comparison
pass, except for intentional shared model fixes such as a known output type
correction that must be mirrored in both implementations.

## Current Model Summary

From the current generated configuration:

```text
Input window:       256 x 4 x 1
Input stream word:  input_t = nnet::array<ap_fixed<12,6>, 4>
Conv2D:             5 x 1 kernel, 7 filters, stride 3 x 1
Conv output:        84 x 4 x 7 = 2352 scalar values
ReLU output:        84 x 4 x 7 = 2352 scalar values
MaxPool2D:          2 x 1 pool, stride 2 x 1
Pool output:        42 x 4 x 7 = 1176 scalar values
Dense output:       1 trigger score
```

Important tensor interpretation:

```text
height   = 256
width    = 4
channels = 1
```

The four values in `input_t` are the width dimension of a `256 x 4 x 1`
tensor, not `n_chan = 4`. The first convolution uses a `5 x 1` kernel, so it
does temporal filtering independently at each of the four width positions. It
does not perform early cross-position/channel mixing. Later, the dense layer
sees all `42 x 4 x 7` pooled features.

This distinction matters when generating model-specific kernels. A true
`256 x 1 x 4` model would require different channel-mixing logic.

## Baseline Generated Data Path

The hls4ml baseline path is:

```text
input_layer
  -> repack_stream<input_t, layer2_t, 1024>
  -> conv_2d_cl<layer2_t, layer3_t, config3>
  -> relu<layer3_t, layer4_t, relu_config4>
  -> pooling2d_cl<layer4_t, layer5_t, config5>
  -> dense<layer5_t, result_t, config7>
  -> layer7_out
```

The baseline top-level uses:

```text
#pragma HLS INTERFACE axis port=input_layer,layer7_out
#pragma HLS DATAFLOW
```

The original internal streams were:

```text
layer8_out   depth 1024   repacked scalar input stream
layer3_out   depth 336    conv output, packed 7 values per stream word
layer4_out   depth 336    ReLU output
layer5_out   depth 168    maxpool output, packed 7 values per stream word
```

The key inefficiency is the first boundary:

```text
input_t  = 4 values per stream word
layer2_t = 1 value per stream word
```

The generated `repack_stream` serializes each 4-lane input word into four
scalar stream writes. It does not perform neural-network math, but in the
baseline report it dominates the transaction interval.

## Baseline Bottleneck Evidence

Use the latest available reports for each metric:

```text
Top-level latency/interval:  RTL cosim transaction report
Resource usage:              Vivado synthesis or HLS csynth reports
Per-block bottlenecks:       HLS csynth reports
Loop II details:             HLS schedule/csynth reports
```

For the original generated baseline, the recorded top-level estimates were:

```text
RTL cosim latency:       3068 cycles
RTL cosim interval:      3074 cycles
HLS latency estimate:    3082 cycles
HLS interval estimate:   3076 cycles
Estimated clock:         3.236 ns at a 5.00 ns target
```

Recorded per-stage estimates:

```text
Stage          Latency cycles   Interval cycles   Notes
repack_stream  3075             3075              Largest interval limiter
conv_2d        2051             2051              Main compute/input-stream kernel
relu            339              339              Simple streaming stage
pooling2d       674              674              II=2 over 336 input words
dense           176              176              Resource-heavy, not interval limiter
```

Loop-level notes:

```text
repack_stream loop       trip count 1024, achieved II=3
conv_2d input loop       trip count 1024, achieved II=2
relu loop                trip count 336,  achieved II=1
pooling2d input loop     trip count 336,  achieved II=2
dense DataPrepare loop   trip count 168,  achieved II=1
```

Interpretation:

1. Because the design is dataflow, the top-level interval is approximately
   dominated by the slowest dataflow stage, not by the sum of all stage
   latencies.
2. `repack_stream` is the largest interval bottleneck despite doing no CNN
   math.
3. The next major bottleneck is the generated generic Conv2D stream path.
4. The dense layer is resource-heavy, but it is below the top interval and was
   not the first throughput blocker.

## Optimization Workflow Overview

The high-level workflow is:

```text
1. Freeze the generated baseline.
2. Build a C++ equivalence comparison.
3. Extract model shape, stream widths, layer configs, and data types.
4. Run baseline HLS and identify interval bottlenecks.
5. Classify each bottleneck as compute, format conversion, buffering, or wrapper overhead.
6. Remove pure format-conversion boundaries first.
7. Replace generic generated kernels with model-specific streaming kernels only where justified.
8. Keep packed/wide data through elementwise and simple reduction layers.
9. Push unpacking as late as possible, or remove it entirely.
10. Re-run C++ equivalence after every functional refactor.
11. Re-run HLS after meaningful schedule/resource changes.
12. Record interval, latency, resource, and clock evidence.
13. Update durable context files when assumptions or results change.
```

Each step should produce a concrete artifact: a report, a code diff, a passing
comparison, or an updated note.

## Step 1: Freeze the Generated Baseline

Before optimization, create or identify an immutable baseline tree:

```text
cnn_core_project/firmware
```

Make all architecture experiments in a separate working copy:

```text
hls_streaming/firmware
```

For another model, use the same structure:

```text
generated_project/firmware      baseline
optimized_work_area/firmware    editable copy
```

Rules:

1. Do not edit the baseline for ordinary architecture changes.
2. Do not tune the baseline to match the optimized design.
3. If a shared correctness fix is required, document it explicitly and apply it
   consistently.
4. Keep enough generated metadata to reconstruct layer shapes and types.

The baseline is the functional reference. It does not have to be a good
hardware architecture.

## Step 2: Build a C++ Equivalence Harness

Before changing HLS internals, build a fast behavioral comparison:

```text
baseline_runner
    tb/compare_runner.cpp + baseline firmware/cnn_core.cpp

streaming_runner
    tb/compare_runner.cpp + optimized firmware/cnn_core.cpp
```

In this repository:

```bash
cd hls_streaming
make compare
make compare SAMPLES=128
make compare SAMPLES=1024
```

The testbench should:

1. Generate deterministic input chunks.
2. Pack input values exactly as the top-level HLS interface expects.
3. Call each implementation with the same chunk sequence.
4. Emit comparable output logs.
5. Use byte-for-byte comparison when the math should be identical.

For intentional math, quantization, model, or interface changes, byte equality
may no longer be the right reference. In that case, create a new reference
test, such as:

```text
fixed tolerance score comparison
classification/trigger decision comparison
DAQ-level chunk/order comparison
throughput/resource acceptance test
model-reference comparison
```

Do not silently weaken the comparison. If `ALLOW_MISMATCH=1` or a tolerance is
used, document why the mismatch is expected.

## Step 3: Extract Static Model Facts

Read these files first:

```text
firmware/defines.h
firmware/parameters.h
firmware/cnn_core.cpp
firmware/weights/*.h shape comments
```

For the current model, the important types are:

```text
input_t    = nnet::array<ap_fixed<12,6>, 4>
layer2_t   = nnet::array<ap_fixed<12,6>, 1>
layer3_t   = nnet::array<ap_fixed<9,5>, 7>
layer4_t   = nnet::array<ap_fixed<16,6>, 7>
layer5_t   = nnet::array<ap_fixed<16,6>, 7>
result_t   = nnet::array<ap_fixed<16,6>, 1>
```

The optimized wide types are:

```text
layer3x4_t = nnet::array<ap_fixed<9,5>,  7 * 4>
layer4x4_t = nnet::array<ap_fixed<16,6>, 7 * 4>
layer5x4_t = nnet::array<ap_fixed<16,6>, 7 * 4>
```

For automation, parse:

```text
input stream word size
output stream word size for each layer
input tensor dimensions
kernel height/width
stride height/width
number of filters
pool size and stride
dense input/output dimensions
reuse factor
precision typedefs
weight array sizes
```

Also parse the top-level layer sequence from `cnn_core.cpp`. This lets a script
identify candidate patterns such as:

```text
repack_stream -> conv_2d_cl
activation on narrow stream
generic pooling after packed conv output
stream dense wrapper that materializes all inputs
```

## Step 4: Read HLS Reports Before Editing

Do not optimize blind. First collect or regenerate the baseline HLS evidence.

Useful report locations in this repository:

```text
cnn_core_project/cnn_core_prj/solution1/syn/report/cnn_core_csynth.rpt
cnn_core_project/cnn_core_prj/solution1/sim/verilog/cnn_core.performance.result.transaction.xml
cnn_core_project/vivado_synth.rpt
hls_streaming/cnn_core_streaming_prj/solution1/hls_summary.txt
```

In `hls_streaming`, the lightweight flow is:

```bash
cd hls_streaming
make hls
```

Useful overrides:

```bash
HLS_CLOCK=4 make hls
HLS_CSIM=1 make hls
HLS_COSIM=1 make hls
HLS_OOC_SYNTH=1 make hls
HLS_PROJECT=my_streaming_prj HLS_SOLUTION=trial_a make hls
```

The C++ comparison flow is intended to work on both Ubuntu and macOS. On macOS,
Apple Clang/libc++ can conflict with the older Xilinx `ap_fixed` and `ap_int`
simulation headers. The Makefile handles this by creating temporary patched
copies of `ap_types` under:

```text
hls_streaming/build/baseline_ap_types
hls_streaming/build/streaming_ap_types
```

Only these temporary build copies should be patched. Do not edit the real
`firmware/ap_types` headers merely to make local C++ simulation pass on one
host.

Record at least:

```text
top latency
top interval
estimated clock period
per-stage latency and interval
loop trip counts and achieved II
BRAM / DSP / FF / LUT usage
slowest dataflow instances
```

For a throughput optimization, always sort candidate work by interval impact.
Do not start with a resource-heavy block if it is well below the top-level
interval unless resource pressure is the active problem.

## Step 5: Classify Bottlenecks

For each slow stage, classify it:

```text
format conversion
    repack, unpack, reshape, width adapter, scalarization

generic compute wrapper
    hls4ml general Conv2D, general pooling, generic dense wrapper

real arithmetic
    multiply-accumulate, activation approximation, reduction

buffering/memory
    line buffers, local arrays, FIFOs, inferred BRAM/SRL/LUTRAM

protocol/control
    stream handshakes, transaction-level blocking, FSM scheduling
```

The highest-value first target is usually:

```text
a high-interval format-conversion stage immediately before or after compute
```

In the current model, that was:

```text
repack_stream<input_t, layer2_t, 1024>
```

It turned 256 input words into 1024 scalar words and achieved II=3, producing
an interval around 3075 cycles. Because it did not perform model math, removing
it was safer and more valuable than rewriting dense first.

## Step 6: Remove Scalar Repack Before First Conv

Original path:

```text
input_t stream, 4 values per word
  -> repack_stream
layer2_t stream, 1 value per word
  -> generic conv_2d_cl
```

Optimized path:

```text
input_t stream, 4 values per word
  -> first_conv_4lane_temporal_wide_cl
layer3x4_t stream, 4 width positions x 7 filters per word
```

Why this is valid for the current model:

```text
input width = 4
input channels = 1
conv kernel = 5 x 1
stride = 3 x 1
filters = 7
```

The first convolution only needs a temporal window of 5 samples at each width
position. Since the input word already contains all 4 width positions for one
time sample, the custom kernel can:

1. Read one `input_t` per cycle.
2. Maintain a temporal buffer or shift structure for the last 5 rows.
3. Emit an output row when the stride condition is met.
4. Compute all 4 width positions and 7 filters in a packed output word.

Preserve output order exactly. The generated downstream layers expect outputs
ordered by the model's flattening convention. If an optimization changes the
order, either fix the order immediately or update every downstream consumer and
test reference consistently.

For another model, only apply this transformation directly if the same shape
conditions hold. If `filt_width > 1`, `n_chan > 1`, padding is nonzero, or width
is larger/different, generate a different specialized kernel or keep the
generic path until the indexing is proven.

## Step 7: Validate the First Replacement Conservatively

The first replacement should minimize blast radius. A safe intermediate design
is:

```text
first_conv_4lane_temporal_wide_cl
  -> unpack adapter back to layer3_t
  -> original ReLU
  -> original Pool
  -> original Dense
```

This answers one question:

```text
Does the custom first convolution preserve the generated Conv2D math and order?
```

Run:

```bash
cd hls_streaming
make compare
make compare SAMPLES=128
make compare SAMPLES=1024
```

Only after this passes should the wide representation be pushed farther through
the network.

## Step 8: Push Wide Data Through Elementwise Layers

Elementwise layers are usually easy to widen because each scalar operation is
independent. ReLU is the current example.

Narrow path:

```text
layer3_t stream
336 words, 7 values per word
```

Wide path:

```text
layer3x4_t stream
84 words, 28 values per word
```

Current optimized path:

```text
nnet::relu<layer3x4_t, layer4x4_t, relu_config4>
```

Important checks:

1. The activation implementation must iterate over `data_T::size` or otherwise
   support the wider array size.
2. `relu_config4::n_in` should still describe the total scalar count:
   `84 * 4 * 7 = 2352`.
3. Stream word count changes, but scalar count and scalar order must not.
4. C++ comparison must still pass.

For automation, elementwise layers are good candidates for generic widening if
the implementation is templated over `nnet::array` size and does not assume a
fixed stream word count unrelated to `CONFIG_T::n_in / data_T::size`.

## Step 9: Push Wide Data Through Simple Pooling

The current MaxPool layer is:

```text
input:       84 x 4 x 7
pool:        2 x 1
stride:      2 x 1
output:      42 x 4 x 7
operation:   Max
```

Because the pool is non-overlapping along height and does not combine width
positions, it can be replaced with a specialized wide non-overlap pool:

```text
maxpool2d_wide_nonoverlap_cl<layer4x4_t, layer5x4_t, config5>
```

This consumes:

```text
84 wide words, each 4 x 7 values
```

and emits:

```text
42 wide words, each 4 x 7 values
```

Do not apply this exact replacement blindly. Check:

```text
pool_height == stride_height
pool_width == stride_width or the implementation explicitly supports overlap
pool_width == 1 for this exact current implementation
padding == 0 or correctly handled
operation is Max or the specialized kernel supports the operation
data order matches the dense flattening order
```

For overlapping pooling, padded pooling, average pooling with count-pad
behavior, or larger width pooling, generate a different implementation and
validate against the baseline.

## Step 10: Remove Late Unpack and Stream Dense Directly

An intermediate optimized design may still unpack after pool:

```text
layer5x4_t
  -> unpack_4lane_temporal_cl
layer5_t
  -> dense<layer5_t, result_t, config7>
```

This preserves the generated dense input format but adds an adapter and often a
deep FIFO. The current final design removes that path:

```text
layer5x4_t
  -> dense_wide_stream<layer5x4_t, result_t, config7>
  -> result_t
```

The custom wide dense reads 42 wide words. Each word contains:

```text
4 width positions x 7 filters = 28 scalar features
```

The dense layer still computes the same dot product over 1176 features. The
optimization is structural:

1. Do not materialize all 1176 scalar inputs in a fully partitioned local
   array.
2. Accumulate directly from the incoming packed stream.
3. Preserve the exact feature order used by `w7`.
4. Keep the dense interval below the first-conv interval so dense does not
   become the top-level limiter.

Current confirmed result after wide streaming dense:

```text
HLS latency estimate:    263 cycles
HLS interval estimate:   260 cycles
Estimated clock:         3.886 ns at 5.00 ns target
Resources:               0 BRAM_18K, 11 DSP, 2975 FF, 26500 LUT
first_conv interval:     259 cycles
dense_wide interval:     176 cycles
dense_wide resources:    7 DSP, 769 FF, 19616 LUT
```

Dense LUT usage remains noticeable because dynamic indexing into a fully
partitioned weight array can become mux-heavy. At this point it is resource
polish, not the top throughput blocker.

## Step 11: Update Top-Level Wiring

The current optimized top-level path in `hls_streaming/firmware/cnn_core.cpp`
is:

```text
cnn_core(input_layer, layer7_out)
  -> first_conv_4lane_temporal_wide_cl<input_t, layer3x4_t, config3>
  -> relu<layer3x4_t, layer4x4_t, relu_config4>
  -> maxpool2d_wide_nonoverlap_cl<layer4x4_t, layer5x4_t, config5>
  -> dense_wide_stream<layer5x4_t, result_t, config7>
```

The internal streams are:

```text
layer3x4_out depth 4      wide first-conv output, 4 widths x 7 filters
layer4x4_out depth 4      wide ReLU output, 4 widths x 7 filters
layer5x4_out depth 4      wide MaxPool output, 4 widths x 7 filters
```

Use shallow FIFO depths where dataflow backpressure remains safe. After HLS,
check whether shallow wide FIFOs are inferred as BRAM. If so, bind them to SRL
or another appropriate fabric implementation:

```cpp
#pragma HLS BIND_STORAGE variable=layer4x4_out type=fifo impl=srl
#pragma HLS BIND_STORAGE variable=layer5x4_out type=fifo impl=srl
```

In the current design, this fixed a BRAM regression while preserving interval:

```text
Before SRL binding: 57 BRAM_18K
After SRL binding:   7 BRAM_18K in one intermediate state
After wide dense:    0 BRAM_18K in the confirmed final state
```

Always confirm with HLS. A storage pragma is a request to the tool, not a
guarantee that timing and scheduling are still acceptable.

## Step 12: Verify After Every Step

Use two verification levels.

### C++ Behavioral Equivalence

Run after every source-level transformation that should preserve math:

```bash
cd hls_streaming
make compare
make compare SAMPLES=128
make compare SAMPLES=1024
```

Passing means:

```text
baseline and optimized C++ outputs match exactly for the deterministic inputs
```

It does not prove RTL timing, resource use, AXI behavior, or full system
correctness.

### HLS Evidence

Run after meaningful schedule/resource changes:

```bash
cd hls_streaming
make hls
```

Record:

```text
top latency
top interval
per-stage interval
estimated clock
BRAM / DSP / FF / LUT
slowest dataflow instances
unexpected RAM inference
loop II changes
```

Optional deeper checks:

```bash
HLS_CSIM=1 make hls
HLS_COSIM=1 make hls
HLS_OOC_SYNTH=1 make hls
```

Use out-of-context synthesis for this internal CNN block instead of treating it
like a full device top with externally placed pins and I/O buffers.

## Step 13: Interpret the Current Optimization Result

The original hls4ml baseline:

```text
top interval around 3076 cycles
largest limiter: repack_stream around 3075 cycles
```

The current optimized design:

```text
top interval around 260 cycles
first_conv interval around 259 cycles
```

This is close to the single-core lower bound imposed by reading 256 input
stream words when the top-level interface accepts one `input_t` per cycle.

Therefore, further single-core interval reduction is limited unless one of
these changes happens:

```text
wider top-level input interface
more than one input word per cycle
multiple cores interleaved across chunks
persistent top-level loop that overlaps chunks differently
model architecture change
different input granularity and scheduler contract
```

For the current core, the next important work is less about removing another
large single-stage bottleneck and more about:

```text
system-level chunk scheduling
multi-core interleaving if needed
timing closure
resource polish
weight quantization correctness
DAQ/front-end packetization
RTL cosim and integration tests
```

## Known Numerical Correctness Issues

### Output Type Wrap

`result_t` was widened from:

```text
ap_fixed<9,5>
```

to:

```text
ap_fixed<16,6>
```

Reason:

```text
large positive scores could wrap in the old output type
```

The downstream decoder must interpret RTL output as:

```text
signed 16-bit output / 1024.0
```

not the old low-9-bit `ap_fixed<9,5>` format.

This fix was mirrored to the baseline and optimized firmware because it is a
shared model correctness issue, not a streaming architecture change.

### Reference Model Alignment

Keep numerical/model-reference issues separate from structural HLS throughput
changes. If the optimized C++ or RTL output disagrees with the chosen reference
model, first determine whether the mismatch comes from:

```text
interface packing/unpacking
fixed-point type width or signedness
weight or bias quantization
activation or pooling semantics
output decoder interpretation
testbench reference drift
```

Only change firmware weights, quantization policy, or acceptance tolerances
after documenting which reference is authoritative and why the mismatch is
expected. These are model-correctness decisions, not data-path optimization
steps.

## Automation Design

A future automation script can be organized into five phases.

### Phase A: Static Extraction

Inputs:

```text
firmware/defines.h
firmware/parameters.h
firmware/cnn_core.cpp
firmware/weights/*.h
```

Extract:

```text
typedef names and nnet::array sizes
fixed-point precision per layer
layer config structs
input/output tensor dimensions
kernel and stride dimensions
pool dimensions
dense dimensions
weight array sizes
top-level call graph
internal stream declarations and depths
HLS pragmas
```

Output a machine-readable model summary, for example:

```json
{
  "input": {"height": 256, "width": 4, "channels": 1, "word_lanes": 4},
  "conv": {"kernel": [5, 1], "stride": [3, 1], "filters": 7},
  "pool": {"kernel": [2, 1], "stride": [2, 1], "op": "max"},
  "dense": {"n_in": 1176, "n_out": 1}
}
```

### Phase B: Pattern Detection

Detect patterns such as:

```text
input_t size > next layer stream size
repack_stream immediately before first conv
Conv2D with filt_width == 1 and n_chan == 1
elementwise activation after conv
non-overlap pool with simple dimensions
dense wrapper reading a flattened stream after pool
wide shallow FIFO inferred as BRAM
```

Emit candidate transformations with preconditions:

```text
candidate: fuse repack + first conv
requires:  input word lanes == in_width
           filt_width == 1
           n_chan == 1
           pad_left/right/top/bottom == 0
           known flatten order
```

A script should refuse or mark manual-review-required when preconditions are
not proven.

### Phase C: Code Generation

Generate or instantiate:

```text
wide typedefs
custom first-conv kernel
wide activation path
wide non-overlap pool
wide streaming dense
top-level stream declarations
FIFO depth and storage pragmas
includes for new helper headers
```

Prefer small, model-specific helpers over trying to make one overly general
kernel cover every possible generated model. Over-generalization can recreate
the same HLS scheduling problem that the generated library had.

### Phase D: Verification Runner

Automatically run:

```bash
make compare
make compare SAMPLES=128
make compare SAMPLES=1024
```

Then, if behavior passes:

```bash
make hls
```

Collect:

```text
pass/fail
first mismatching sample if any
top interval and latency
stage intervals
resource table
estimated clock
```

### Phase E: Report and Context Update

Write a summary:

```text
before/after data path
before/after interval
before/after resources
transformation list
verification commands and results
remaining bottleneck
manual review notes
```

Update durable context files when appropriate:

```text
hls_streaming/AI_CONTEXT.md
hls_streaming/PROJECT_ANALYSIS.md
new model-specific optimization log
```

Do not overwrite prior evidence without preserving the date, tool version, or
configuration when those details matter.

### Source Navigation Artifacts

For manual analysis and future automation, prefer `rg` for text search and keep
generated navigation indexes separate from source truth:

```text
hls_streaming/code_analysis/tags
hls_streaming/code_analysis/cscope.files
```

`tags` is a generated ctags index. `cscope.files` is the selected source-file
list for cross-reference tooling and should exclude large/generated dependency
trees such as `firmware/ap_types` and `build`.

Refresh them after meaningful firmware or testbench changes:

```bash
ctags -R -f hls_streaming/code_analysis/tags hls_streaming/firmware hls_streaming/tb

find hls_streaming/firmware hls_streaming/tb \
  -path 'hls_streaming/firmware/ap_types' -prune -o \
  -path 'hls_streaming/build' -prune -o \
  -type f \( -name '*.h' -o -name '*.cpp' \) -print \
  > hls_streaming/code_analysis/cscope.files
```

If `cscope` query mode fails on paths with spaces or cloud-synced directory
components, treat `rg` and ctags as the reliable navigation tools until the
database is regenerated from a simpler path.

## Manual Checklist for Another Similar Model

Use this checklist when applying the workflow by hand.

```text
[ ] Identify immutable generated baseline.
[ ] Create editable firmware copy.
[ ] Build baseline-vs-optimized C++ comparison harness.
[ ] Confirm initial copied optimized firmware matches baseline.
[ ] Confirm host-specific simulation patches stay under build-only copies.
[ ] Extract input shape, layer shapes, precisions, and stream word sizes.
[ ] Run or locate baseline HLS reports.
[ ] Rank stages by interval, not just latency or resource.
[ ] Identify pure format-conversion stages.
[ ] Check whether first conv can consume the original packed input directly.
[ ] Add wide intermediate typedefs.
[ ] Replace repack + first conv with custom first conv.
[ ] Validate with make compare.
[ ] Push wide data through elementwise activation.
[ ] Validate with make compare.
[ ] Replace simple pooling with wide specialized pooling if preconditions hold.
[ ] Validate with make compare.
[ ] Remove late unpack by streaming directly into dense if feasible.
[ ] Validate with make compare.
[ ] Run HLS and record top/per-stage interval.
[ ] Bind shallow wide FIFOs away from BRAM if needed.
[ ] Re-run HLS after resource pragmas.
[ ] Check output type range and downstream decoder format.
[ ] Check model-reference quantization issues separately from HLS structure.
[ ] Refresh navigation artifacts if source layout changed.
[ ] Update project memory and optimization notes.
```

## Common Failure Modes

### Wrong Flatten Order

Symptom:

```text
C++ comparison fails even though per-layer values look plausible
```

Cause:

```text
custom wide kernel emits features in a different order than the generated dense
weights expect
```

Fix:

```text
trace the generated output order
write a small diagnostic that dumps intermediate streams
align custom output order to baseline before optimizing further
```

### Width Dimension Mistaken for Channel Dimension

Symptom:

```text
first conv output differs significantly
```

Cause:

```text
treating 256 x 4 x 1 as 256 x 1 x 4, or vice versa
```

Fix:

```text
derive indexing from config.in_height, config.in_width, config.n_chan
validate the first few output windows manually against baseline
```

### ReLU or Activation Word Count Mismatch

Symptom:

```text
stream underflow, deadlock, or missing outputs
```

Cause:

```text
CONFIG_T::n_in is total scalar count, but the stream loop count must account
for the number of scalars per stream word
```

Fix:

```text
ensure loop count = CONFIG_T::n_in / data_T::size when using packed stream words
```

### Pooling Preconditions Not Met

Symptom:

```text
pool output mismatch at row/width boundaries
```

Cause:

```text
using a non-overlap specialized pool on an overlapping or padded pooling layer
```

Fix:

```text
check pool_height, pool_width, stride_height, stride_width, padding, and count_pad
generate a different pool kernel if needed
```

### Dense Weight Index Mismatch

Symptom:

```text
conv/pool intermediate checks pass, final score fails
```

Cause:

```text
wide streaming dense reads features in a different order than w7
```

Fix:

```text
map each incoming packed lane to the exact dense input index used by baseline
compare partial sums or one-hot feature tests
```

### BRAM Explosion from Shallow Wide FIFOs

Symptom:

```text
interval improves but BRAM usage jumps unexpectedly
```

Cause:

```text
wide shallow streams inferred as BRAM FIFOs
```

Fix:

```cpp
#pragma HLS BIND_STORAGE variable=<stream_name> type=fifo impl=srl
```

Then re-run HLS and timing checks.

### Output Fixed-Point Wrap

Symptom:

```text
large positive expected scores appear negative
```

Cause:

```text
result_t has too few integer bits
```

Fix:

```text
widen result_t and update downstream decoder
re-run baseline and optimized comparisons
separate this model-correctness fix from throughput optimization notes
```

## When Not to Apply This Exact Workflow

This workflow is directly applicable when:

```text
the generated model has a small fixed input window
the input stream word already packs useful parallel lanes
the first generated stage scalarizes or repacks that word
early conv/pool layers have simple geometry
the goal is higher steady-state chunk throughput
```

Manual redesign is needed when:

```text
the model has true multi-channel convolution with complex channel mixing
the first conv uses filt_width > 1 and width packing is nontrivial
padding or dilation changes the boundary behavior
sliding-window chunk overlap is part of the model semantic
the DAQ interface requires a different transaction contract
the required throughput is beyond one chunk per input-window read
accuracy changes require retraining or model architecture changes
```

For those cases, keep the same evidence-driven loop:

```text
context -> targeted source read -> small transformation -> C++ compare -> HLS report -> context update
```

but do not reuse the current specialized kernels without proving their
preconditions.

## Target End State

For this repository, the current optimized single-core end state is:

```text
ADC/DAQ packetization or scheduler
  -> input_t stream, one time row with 4 width positions per word
  -> first_conv_4lane_temporal_wide_cl
  -> wide ReLU
  -> wide non-overlap maxpool
  -> wide streaming dense
  -> one ordered trigger score per chunk
```

Measured current status:

```text
C++ comparison:         make compare SAMPLES=1024 PASS
HLS interval:           about 260 cycles
HLS latency:            about 263 cycles
BRAM_18K:               0 in latest confirmed wide-dense result
Remaining limiter:      first conv input-read lower bound around 259 cycles
```

The result is close to the lower bound for a single core reading 256 input
words at one word per cycle. Further throughput improvement should be treated
as a system architecture problem rather than another local hls4ml wrapper
cleanup.

## Repository Hygiene

Keep checked-in files focused on source, durable reports, scripts, and
documentation. Do not commit transient HLS/Vitis implementation databases or
logs as optimization evidence:

```text
.autopilot/
*.log
vitis_hls.log
solution1.log
```

Regenerate those artifacts when needed, then preserve only the compact reports
or explicit notes that explain a design decision. This keeps future model ports
from inheriting stale local tool state.
