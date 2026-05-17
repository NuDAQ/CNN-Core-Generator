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

Current `cnn_core.cpp` is short and generated:

```text
input_layer
  -> repack_stream<input_t, layer2_t, 1024>
  -> conv_2d_cl<layer2_t, layer3_t, config3>
  -> relu<layer3_t, layer4_t, relu_config4>
  -> pooling2d_cl<layer4_t, layer5_t, config5>
  -> dense<layer5_t, result_t, config7>
  -> layer7_out
```

Internal streams:

```text
layer8_out   depth 1024   scalar input stream after repack
layer3_out   depth 336    conv outputs, 7 filters per word
layer4_out   depth 336    ReLU outputs, 7 values per word
layer5_out   depth 168    maxpool outputs, 7 values per word
```

`#pragma HLS DATAFLOW` allows these stages to overlap inside a transaction.
However, the HLS report still gives a back-to-back top-level interval of about
3076 cycles. Current dataflow overlap does not mean the core can accept a new
256-sample chunk every 256 cycles.

## Data Types and Tensor Meaning

From `defines.h`:

```text
input_t   = nnet::array<ap_fixed<12,6>, 4>
layer2_t  = nnet::array<ap_fixed<12,6>, 1>
layer3_t  = nnet::array<ap_fixed<9,5>, 7>
layer4_t  = nnet::array<ap_fixed<16,6>, 7>
layer5_t  = nnet::array<ap_fixed<16,6>, 7>
result_t  = nnet::array<ap_fixed<9,5>, 1>
```

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
```

This is the largest current interval limiter. It is not doing neural-network
math; it is converting from 4-lane input words to scalar words for the generated
Conv2D stream implementation. This is the first place to question whether the
chosen internal data granularity is paying for itself.

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

Top-level reports:

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

The current design overlaps dataflow stages, so the top-level interval is near
the slowest stage, not the sum. Unfortunately, the slowest stage is still about
3075 cycles. For a target of one 256-sample chunk every 256 ns, this is far too
large unless the clock is dramatically faster or multiple cores are interleaved.

## Important Architectural Interpretation

The present design is a transaction-level accelerator:

```text
call cnn_core once -> consume one 256 x 4 chunk -> produce one score
```

It is not yet a persistent streaming engine that continuously accepts chunk
fragments and keeps many chunks in flight through independent pipeline stages.
`DATAFLOW` helps within a chunk, but the reported transaction interval shows
that a new top-level transaction is still blocked for thousands of cycles.

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

4. Keep `make compare` as the behavior guard.

   For every refactor that should preserve math, run the baseline-vs-streaming
   comparison. For intentional model/architecture changes, create a new
   reference flow rather than changing `../cnn_core_project/firmware`.

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
