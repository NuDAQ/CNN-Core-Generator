# hls_streaming C++ HLS Project Analysis

This note is a working map of the `hls_streaming` C++ project. Its purpose is
to make later edits and throughput optimization less blind. The key target is
not minimum single-inference latency, but minimum steady-state chunk interval
for the semantic contract:

```text
256 time samples x 4 positions/channels -> one trigger score
```

The current project is still an hls4ml-style one-chunk transaction. It is a
good functional baseline, but its reported transaction interval is too long for
the desired chunk rate.

## Tooling Used

Useful local tools:

```text
ctags      symbol and template/function index
cscope     cross-reference database, useful for larger follow-up searches
doxygen    call/include graph generation if a rendered graph is useful
dot        Graphviz backend for Doxygen graphs
tree       directory overview
rg         fast source search
```

For day-to-day navigation, `clangd` plus an editor is the most useful setup.
For quick terminal work, `rg` and `ctags -x` are enough.

Analysis rule for optimization work: reason from the FPGA implementation view.
The C++ source is only the HLS input. The object being optimized is the RTL
that Vitis emits: modules, FSM states, ready/valid handshakes, ap_fifo reads
and writes, inferred local memories, achieved II, clock timing, and utilization.
When a claim matters, prefer generated Verilog/VHDL and HLS schedule/resource
reports over surface-level C loop intuition.

Functional comparison against the hls4ml baseline is a guardrail, not the final
metric. The DAQ/front-end packetization, test reference, and model-facing
interface can change if that improves total chunk throughput. For intentional
architecture/model changes, replace byte-for-byte baseline comparison with an
appropriate throughput/resource/reference test instead of forcing equivalence.

## Size and Reading Strategy

Excluding `hls_streaming/build/`, the project has about 27k lines of relevant
text-like source:

```text
Area                  Files   Lines   Read strategy
firmware/core             4     256   Read completely
tb                        1      50   Read completely
top README/Makefile       2     396   Read completely
firmware/weights          4      64   Inspect shapes, not values
firmware/nnet_utils      56  10,273   Read along active call path
firmware/ap_types        16  15,927   Treat as Xilinx simulation support
```

Complete reading of every line is possible, but not the best use of time.
`ap_types` should be treated as a compatibility library. Most `nnet_utils`
headers are unused by this model. The active model path is small enough to read
directly.

## Files That Matter First

```text
hls_streaming/Makefile
hls_streaming/tb/compare_runner.cpp
hls_streaming/firmware/cnn_core.cpp
hls_streaming/firmware/cnn_core.h
hls_streaming/firmware/defines.h
hls_streaming/firmware/parameters.h
hls_streaming/firmware/nnet_utils/nnet_stream.h
hls_streaming/firmware/nnet_utils/nnet_conv2d_stream.h
hls_streaming/firmware/nnet_utils/nnet_conv_stream.h
hls_streaming/firmware/nnet_utils/nnet_activation_stream.h
hls_streaming/firmware/nnet_utils/nnet_pooling_stream.h
hls_streaming/firmware/nnet_utils/nnet_dense_stream.h
hls_streaming/firmware/nnet_utils/nnet_dense_latency.h
```

The rest of `nnet_utils` is still useful as a reference library, especially the
Conv1D and resource-strategy variants, but it is not on the current execution
path.

## Build and Compare Flow

`Makefile` builds two runners from the same testbench:

```text
baseline_runner   tb/compare_runner.cpp + ../cnn_core_project/firmware/cnn_core.cpp
streaming_runner  tb/compare_runner.cpp + ./firmware/cnn_core.cpp
```

Both runners emit logs under `hls_streaming/build/run/`; `cmp` checks exact
output equality. On macOS, `prepare-compat` copies `ap_types` into temporary
build directories and patches the old Xilinx `<complex>` handling in the
temporary copies only.

The current testbench creates eight deterministic chunks by default. Each chunk
is 1024 scalar values, then `nnet::copy_data<float, input_t, 0, 256 * 4>` packs
them into the input stream. Each `cnn_core()` call is one independent
transaction.

## Top-Level Execution Path

Current working `hls_streaming/firmware/cnn_core.cpp` has replaced the
generated repack + Conv2D front end with a model-specific first-conv block:

```text
input_layer
  -> first_conv_4lane_temporal_wide_cl<input_t, layer3x4_t, config3>
  -> relu<layer3x4_t, layer4x4_t, relu_config4>
  -> maxpool2d_wide_nonoverlap_cl<layer4x4_t, layer5x4_t, config5>
  -> unpack_4lane_temporal_cl<layer5x4_t, layer5_t, config5>
  -> dense<layer5_t, result_t, config7>
  -> layer7_out
```

The immutable generated baseline under `../cnn_core_project/firmware` still
uses:

```text
input_layer
  -> repack_stream<input_t, layer2_t, 1024>
  -> conv_2d_cl<layer2_t, layer3_t, config3>
```

Internal streams:

```text
layer3x4_out depth 4      wide first-conv outputs, 4 widths x 7 filters per word
layer4x4_out depth 4      wide ReLU outputs, 4 widths x 7 filters per word
layer5x4_out depth 4      wide maxpool outputs, 4 widths x 7 filters per word
layer5_out   depth 168    maxpool outputs, 7 values per word
```

`make compare SAMPLES=1024` passes after the wide first-conv plus unpack
adapter change, so the working copy remains behavior-equivalent to the baseline
for the deterministic C++ comparisons. The regenerated HLS csynth report after
the flat-unpack experiment gives a top-level interval of 340 cycles. The
first-conv wide output and flat unpack optimizations both worked; unpack, ReLU,
and maxpool formed a three-way interval bottleneck around 339 cycles. The source
now pushes 4-width packing through ReLU and pool, then unpacks only after pool
to preserve dense input format. `make compare SAMPLES=1024` passes for this
wide-ReLU/wide-pool source, and HLS confirms a 260-cycle top interval.

## Data Types and Tensor Meaning

From `defines.h`:

```text
input_t   = nnet::array<ap_fixed<12,6>, 4>
layer2_t  = nnet::array<ap_fixed<12,6>, 1>
layer3_t  = nnet::array<ap_fixed<9,5>, 7>
layer4_t  = nnet::array<ap_fixed<16,6>, 7>
layer5_t  = nnet::array<ap_fixed<16,6>, 7>
result_t  = nnet::array<ap_fixed<16,6>, 1>
```

The final score type was widened from `ap_fixed<9,5>` to `ap_fixed<16,6>` after
wrapper/Keras comparison showed that large positive scores could wrap into the
negative range at the output port. The AXI-stream output is still 16 bits wide,
but downstream score decoding must use the `ap_fixed<16,6>` scale.

The model shape is represented as:

```text
height   = 256
width    = 4
channels = 1
```

This is important: the current implementation treats the four values in
`input_t` as the width dimension of a `256 x 4 x 1` tensor, not as `n_chan = 4`.
The first convolution has a `5 x 1` kernel, so it filters along time and applies
the same temporal filters independently across the four width positions. Early
cross-position/channel mixing is not performed by the first convolution; later
the dense layer sees all `42 x 4 x 7` pooled features.

## Layer Configuration

From `parameters.h`:

```text
Conv2D config3
  input:       256 x 4 x 1
  kernel:      5 x 1
  filters:     7
  stride:      3 x 1
  output:      84 x 4 x 7 = 2352 scalar values
  strategy:    latency
  reuse:       1
  impl:        linebuffer

ReLU relu_config4
  n_in:        2352
  io_type:     io_stream

MaxPool config5
  input:       84 x 4 x 7
  pool:        2 x 1
  stride:      2 x 1
  output:      42 x 4 x 7 = 1176 scalar values

Dense config7
  input:       1176
  output:      1
  strategy:    latency
  reuse:       1
```

Weights:

```text
w3:  5 x 1 x 1 x 7 = 35 values
b3:  7 values
w7:  1176 x 1 values
b7:  1 value
```

## Stage Behavior

### repack_stream

Active code: `nnet_stream.h`.

Current instantiation:

```text
data_T = input_t   size 4
res_T  = layer2_t  size 1
N      = 1024
```

This takes 256 input stream words and writes 1024 scalar stream words. The
active branch is `data_T::size > res_T::size`, so each input word is unpacked
into four output writes. The report shows:

```text
latency / interval: 3075 cycles
loop trip count:    1024
achieved II:        3
RTL FSM:            5 scheduled states, pipeline depth 5
local storage:      4 x 12-bit in_data RAM/register file
input port:         input_layer_TDATA 64-bit AXIS
output port:        layer8_out_din 12-bit ap_fifo
```

This is the largest current interval limiter. It is not doing neural-network
math; it is converting from 4-lane input words to scalar words for the generated
Conv2D stream implementation. This is the first place to question whether the
chosen internal data granularity is paying for itself.

RTL-level view:

```text
input_layer_TDATA[11:0], [27:16], [43:32], [59:48]
  -> tiny 4-entry local in_data storage
  -> one 12-bit lane read
  -> one layer8_out ap_fifo write
```

The generated module is not area-heavy: the HLS estimate is roughly 86 FF and
264 LUT, with no DSP and no BRAM. The problem is schedule shape. Vitis creates
a pipelined loop with II=3 over 1024 scalar outputs. Even with perfect AXIS
input availability and a non-full `layer8_out` FIFO, the adapter can only emit
one scalar word about every three cycles. The input side only needs 256 AXIS
reads, but the output side creates 1024 scalar FIFO writes and drives the
transaction interval.

This means `repack_stream` should be treated as an RTL data-width/protocol
adapter, not as a compute kernel. Micro-optimizing the C helper is unlikely to
be the right first move. The better target is to remove the scalar stream
boundary: either make the first convolution consume `input_t` directly, or fuse
the repack and first-conv schedules so the 4 lanes are used where they arrive
instead of being serialized into `layer8_out`.

### conv_2d_cl

Active code: `nnet_conv2d_stream.h` and `nnet_conv_stream.h`.

The current implementation is the line-buffer latency path:

```text
conv_2d_cl
  -> conv_2d_buffer_latency_cl
  -> compute_output_buffer_2d
  -> shift_line_buffer
  -> DenseLatency over the 5-sample kernel window
```

It reads 1024 scalar pixels because the input is now `layer2_t` size 1. It
produces 336 stream words, each holding 7 filter outputs. The report shows:

```text
latency / interval: 2051 cycles
loop trip count:    1024
achieved II:        2
```

The multiply for each output window is small: 5 inputs x 7 filters. The
important cost is not only arithmetic, but also the scalar stream schedule and
line-buffer/counter structure.

### ReLU

Active code: `nnet_activation_stream.h`.

This is straightforward streaming ReLU:

```text
input words:  2352 / 7 = 336
output words: 336
```

The report shows:

```text
latency / interval: 339 cycles
achieved II:        1
```

This stage is not a first-order optimization target.

### pooling2d_cl

Active code: `nnet_pooling_stream.h`.

The pooling layer consumes 336 words and emits 168 words. It uses a line-buffer
style implementation over `84 x 4 x 7` with pool `2 x 1` and stride `2 x 1`.
The report shows:

```text
latency / interval: 674 cycles
loop trip count:    336
achieved II:        2
```

This stage is smaller than `repack_stream` and `conv_2d`, but it is still too
large if the final target is one chunk every 256 cycles.

### dense

Active code: `nnet_dense_stream.h` and `nnet_dense_latency.h`.

The stream wrapper first collects all 1176 pooled scalar values into a fully
partitioned local array, then calls the dense latency kernel. The report breaks
it down as:

```text
data_prepare:            170 cycles
dense_latency_wrapper:     2 cycles, II=1
whole dense stage:       176 cycles
```

This stage is not the current interval limiter, but it dominates HLS resource
estimates:

```text
dense block: 13 DSP, 27888 FF, 31767 LUT
```

This happens because the latency strategy with `reuse_factor = 1` pushes heavy
parallelism into the dense dot product.

## Current Report Summary

The current working copy has a regenerated Vitis HLS csynth report under
`hls_streaming/cnn_core_streaming_prj/solution1`. There is not yet a checked-in
RTL cosim transaction report or OOC implementation report, so these are
pre-place-and-route HLS estimates.

Latest confirmed HLS report after the flat-unpack experiment:

```text
HLS latency estimate:    345 cycles
HLS interval estimate:   340 cycles
Latency time:            1.725 us at 5.00 ns
Estimated clock:         3.886 ns at 5.00 ns target
Resources:               32 BRAM_18K, 17 DSP, 30269 FF, 37938 LUT
```

Latest confirmed per-stage HLS estimates:

```text
Stage                           Latency   Interval   Main reason to care
unpack_4lane_temporal              339        339   flat loop II=1, tied limiter
relu                                339        339   simple streaming stage
maxpool2d_nonoverlap                339        339   flat pool II=1, tied limiter
first_conv_4lane_temporal_wide      259        259   fixed, input loop II=1
dense                               176        176   resource-heavy, not interval limiter
```

Result versus the original generated baseline:

```text
Latency:  3082 -> 345 cycles, about 8.93x faster
Interval: 3076 -> 340 cycles, about 9.05x faster
BRAM:       19 ->  32
DSP:        14 ->   17
FF:      30061 -> 30269
LUT:     34994 -> 37938
```

The useful FPGA-level interpretation is that the optimization bought about a
9x interval reduction versus the original baseline, and both scheduling
hypotheses are confirmed. The tradeoff is extra FIFO BRAM: `layer3x4_out` uses
14 BRAM_18K by itself because it is 252 bits wide at depth 84.

The remaining interval issue is no longer a single broken stage. The top is now
limited by 336-word narrow traffic through unpack/ReLU/pool, each scheduled at
II=1 plus a few pipeline cycles. This is the expected plateau for the current
choice of unpacking immediately after first conv.

The next high-value target is to remove the unpack entirely by pushing the
4-width packing through ReLU and pool. A secondary target is to reduce FIFO
depths, especially `layer3x4_out`, to recover BRAM.

Source update after this report: the current code has applied that high-value
target. ReLU now processes 84 `layer3x4_t` words, pool processes 84
`layer4x4_t` words and emits 42 `layer5x4_t` words, then a flat unpack restores
the 168-word `layer5_t` stream for dense. The wide intermediate FIFO depths are
set to 4. HLS confirms the expected interval:

```text
HLS latency estimate:    265 cycles
HLS interval estimate:   260 cycles
Latency time:            1.325 us at 5.00 ns
Estimated clock:         3.886 ns at 5.00 ns target
Resources:               57 BRAM_18K, 17 DSP, 30852 FF, 39067 LUT
```

The new per-stage intervals are:

```text
Stage                           Latency   Interval   Main reason to care
first_conv_4lane_temporal_wide      259        259   current limiter, input-read lower bound
dense                               176        176   resource-heavy, not interval limiter
post-pool unpack                    171        171   preserves dense input format
wide relu                            87         87   84 wide words, II=1
wide maxpool2d_nonoverlap            87         87   84 wide words, II=1
```

The remaining interval optimization space inside one core is very small because
first conv must read 256 input words. The main cleanup target is resource/timing:
the shallow 448-bit `layer4x4_out` and `layer5x4_out` FIFOs are each inferred as
25 BRAM_18K despite depth 4, so they should be bound to LUTRAM/SRL or otherwise
implemented as shallow fabric FIFOs.

Source update after this report: `layer4x4_out` and `layer5x4_out` now have
explicit `BIND_STORAGE type=fifo impl=srl` pragmas. `make compare SAMPLES=1024`
still passes. The next HLS run should check whether interval remains near 260
cycles and whether BRAM drops from the 57 BRAM_18K estimate.

Confirmed HLS result after SRL FIFO binding:

```text
HLS latency estimate:    265 cycles
HLS interval estimate:   260 cycles
Estimated clock:         3.886 ns at 5.00 ns target
Resources:               7 BRAM_18K, 17 DSP, 30756 FF, 39119 LUT
```

The BRAM regression is fixed. `layer3x4_out`, `layer4x4_out`, and `layer5x4_out`
are implemented as SRL FIFOs with 0 BRAM; only `layer5_out` remains a RAM FIFO
at 7 BRAM_18K. The next resource target is dense, which still dominates FF/LUT
while sitting below the 260-cycle top interval.

Current dense resource experiment:

```text
config7::reuse_factor: 1 -> 42
make compare SAMPLES=1024: PASS
```

HLS result with RF=42:

```text
HLS latency estimate:    265 cycles
HLS interval estimate:   260 cycles
Estimated clock:         3.886 ns at 5.00 ns target
Resources:               7 BRAM_18K, 17 DSP, 25733 FF, 39159 LUT
dense interval:          176 cycles
dense resources:         13 DSP, 22865 FF, 31807 LUT
```

Compared with RF=1, the top interval and dense interval are unchanged. Dense FF
drops by about 5k, but DSP is unchanged and LUT is essentially unchanged. The
reason is structural: the active latency dense still fully partitions the local
input and intermediate arrays and HLS still fully unrolls the product and
accumulation loops. `reuse_factor` alone is therefore not enough to turn this
into a genuinely resource-shared dense block. The next useful dense resource
optimization is a custom streaming/wide dense that reads `layer5x4_t` directly
and accumulates without first materializing all 1176 scalars in a fully
partitioned local array.

Source update after this report:

```text
maxpool_wide -> dense_wide_stream -> result
make compare SAMPLES=1024: PASS
```

The new dense path removes the post-pool unpack stage and the 168-deep
`layer5_out` FIFO. It reads 42 `layer5x4_t` words directly, processes one width
lane per cycle, and unrolls the 7 filters within that lane. Expected dense
interval is about 168 cycles, still below the 259-cycle first-conv limiter.
HLS csynth is pending to measure the actual FF/LUT/DSP/BRAM change and whether
the 7-lane MAC chain affects estimated clock.

Confirmed HLS result after wide streaming dense:

```text
HLS latency estimate:    263 cycles
HLS interval estimate:   260 cycles
Estimated clock:         3.886 ns at 5.00 ns target
Resources:               0 BRAM_18K, 11 DSP, 2975 FF, 26500 LUT
first_conv interval:     259 cycles
dense_wide interval:     176 cycles
dense_wide resources:    7 DSP, 769 FF, 19616 LUT
```

The structural dense cleanup worked: the unpack stage and `layer5_out` FIFO are
removed, BRAM drops to zero, and FF drops by almost an order of magnitude while
the top interval remains 260 cycles. Dense LUT is still noticeable because the
7-lane dense dynamically indexes a fully partitioned weight array, which HLS
implements as large muxing. This is now a resource-polish topic rather than a
throughput blocker.

Baseline top-level reports:

```text
RTL cosim latency:       3068 cycles
RTL cosim interval:      3074 cycles
HLS latency estimate:    3082 cycles
HLS interval estimate:   3076 cycles
Estimated clock:         3.236 ns at 5.00 ns target
```

Per-stage HLS estimates:

```text
Stage          Latency   Interval   Main reason to care
repack_stream     3075       3075   largest interval limiter, pure data reshaping
conv_2d           2051       2051   main compute/input-stream kernel
relu               339        339   simple streaming stage
pooling2d          674        674   II=2 over 336 input words
dense              176        176   resource-heavy, not interval limiter
```

Both baseline and optimized designs overlap dataflow stages, so the top-level
interval is near the slowest stage, not the sum. The limiting interval moved
from about 3075 cycles in `repack_stream` to about 1040 cycles in the custom
first-conv stage. For a target of one 256-sample chunk every 256 ns, this is a
major improvement but still too large unless the architecture changes further,
the chunk cadence requirement is relaxed, or multiple cores are interleaved.

## Important Architectural Interpretation

The present design is a transaction-level accelerator:

```text
call cnn_core once -> consume one 256 x 4 chunk -> produce one score
```

It is not yet a persistent streaming engine that continuously accepts chunk
fragments and keeps many chunks in flight through independent pipeline stages.
`DATAFLOW` helps within a chunk, but the reported transaction interval shows
that a new top-level transaction is still blocked for about one thousand cycles
after the first optimization.

For the desired optimization direction, the important question is:

```text
Can the next chunk enter while the previous chunk is in conv/pool/dense?
```

In the current top-level transaction model, the practical answer appears to be
no, at least not at the required interval. A future design likely needs one of:

```text
1. A persistent top-level loop over chunks with dataflow stages operating across chunk boundaries.
2. A custom input/kernel path that avoids scalar repack and lowers the slowest stage interval.
3. Multi-core interleaving, where several chunk engines run in parallel on staggered chunks.
4. A changed model/kernel structure, for example Conv1D-style temporal kernels or different channel mixing.
```

## Optimization Hypotheses

These should be treated as experiments, not conclusions:

1. Remove or bypass scalar `repack_stream`.

   The current input already arrives as 4 values per word. If the first conv can
   consume a 4-lane word or a chosen block granularity directly, the largest
   non-compute stage may disappear. This requires either adapting the conv
   line-buffer path or writing a model-specific first convolution.

   Current working-copy status: `first_conv_4lane_temporal_wide_cl` bypasses
   `layer8_out` and replaces `repack_stream + conv_2d_cl`, then an unpack
   adapter restores the original 336-word `layer3_t` stream. C++ comparison is
   preserved through 1024 deterministic chunks. Next evidence needed:
   regenerated HLS schedule and RTL cosim/OOC reports for the wide-output
   module.

2. Preserve chunk semantics but change input granularity.

   Candidate shapes include `16 x 4`, `32 x 4`, `64 x 4`, `128 x 4`, and
   `256 x 4`. The goal is not to match ADC packaging directly; the front end can
   repacketize. The goal is to find a granularity that keeps the CNN pipeline
   busy with acceptable buffering and routing cost.

3. Rework first convolution as a temporal Conv1D-like kernel.

   Because the current `5 x 1` Conv2D does temporal filtering independently for
   each width position, a model-specific temporal convolution may be simpler
   than the generic hls4ml Conv2D stream path. This must preserve model math
   unless training agrees to a changed model.

4. Pipeline across chunks explicitly.

   A persistent streaming top level could keep stage state alive and accept
   multiple chunks in sequence. This needs careful score ordering and chunk
   boundary handling. Static counters inside current line-buffer functions reset
   after a full image, which is good for one chunk at a time but must be audited
   for any cross-chunk pipeline.

5. Consider multi-core interleaving.

   If one optimized core still cannot reach the desired interval, replicate the
   core and distribute chunks round-robin. This is simple architecturally but
   costs resources and power.

6. Revisit dense resource strategy and quantization later.

   Dense is not the present interval bottleneck, but it is resource-heavy.
   Heterogeneous or channel-wise quantization, sparse/structured dense weights,
   or higher reuse may matter after the input/conv interval is improved.

## Suggested Next Analysis Steps

1. Add a streaming-throughput testbench.

   The current `compare_runner.cpp` calls `cnn_core()` once per chunk. A new
   testbench should drive a long ordered chunk stream and measure accepted chunk
   interval separately from output latency.

2. Prototype a no-op input-granularity harness.

   Before changing CNN math, build small adapters that feed equivalent chunk
   data as `16 x 4`, `32 x 4`, `64 x 4`, `128 x 4`, and `256 x 4`. Compare
   generated C simulation behavior and HLS estimates.

3. Isolate first-conv replacement candidates.

   Start with a model-specific function that consumes the natural 4-lane input
   and produces the same `84 x 4 x 7` stream as `conv_2d_cl`. This gives a
   clean equivalence target: replace `repack_stream + conv_2d_cl` with one
   function and compare against baseline.

4. Keep `make compare` as a behavior guard when equivalence is intended.

   For every refactor that should preserve math, run the baseline-vs-streaming
   comparison. For intentional model/architecture changes, create a new
   reference flow rather than changing `../cnn_core_project/firmware`. The
   Makefile supports `SAMPLES=...`, `ALLOW_MISMATCH=1`, and `run-streaming` for
   exploratory tests where byte equality is not the pass/fail criterion.

## Mental Model for Future Edits

Use this project as two layers:

```text
Functional reference:
  ../cnn_core_project/firmware

Editable architecture experiment:
  hls_streaming/firmware
```

The safe editing path is to keep the output stream identical for the same
256 x 4 chunk input while changing the internal schedule. The first meaningful
optimization target is not the dense layer; it is the data path around
`repack_stream` and the first convolution, because that is where the current
transaction interval is set.
