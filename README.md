# CNN-Core-Generator

This repository contains the CNN trigger core workflow for an FPGA-based
inference pipeline. The generated reference project is kept under
`cnn_core_project`, while streaming-oriented architecture work is kept under
`hls_streaming`.

The current target part is:

```text
xcku5p-ffvb676-2-e
```

## Layout

```text
data/                  Test arrays used by the conversion flow
models/                Trained Keras/PyTorch model artifacts
scripts/               Model conversion and project generation scripts
build/                 Local generated conversion scratch space
cnn_core_project/       hls4ml-generated Vitis HLS project
cnn_core_project/firmware/
                       Current generated IOStream baseline
hls_streaming/          Working C++ HLS area for streaming trigger development
rtl/                   RTL sources managed outside the hls4ml generated output
```

`build/` is local scratch space and should not be committed. Treat
`cnn_core_project/firmware` as the functional reference. Future architecture
work should normally happen under `hls_streaming/firmware`.

## Python Setup

```bash
pip install -r requirements.txt
```

## HGQ-Guided Baseline Generation

The conversion entry point is:

```bash
python scripts/hgq_streaming_pipeline.py
```

This script loads:

```text
models/hgq_config_beta7_gamma6_p1_cl_best_v3.keras
```

The flow generates two temporary projects under `build/hgq_streaming_pipeline`:

```text
ioparallel_reference/   Direct HGQ/IOParallel conversion used as precision oracle
iostream_candidate/     IOStream project used as the hardware baseline candidate
```

The IOParallel project is not the target implementation. It is used to extract
the propagated HGQ precision, weights, sparsity metadata, and per-index
quantizers. Those values are then applied to the IOStream project so that the
installed baseline keeps the stream interface while matching the HGQ model
numerically.

The default command builds and verifies the temporary projects only:

```bash
python scripts/hgq_streaming_pipeline.py
```

After verification, install the generated IOStream baseline:

```bash
python scripts/hgq_streaming_pipeline.py --install
```

This overwrites:

```text
cnn_core_project/
```

To initialize both the generated baseline and the streaming working tree from
the same generated firmware, use:

```bash
python scripts/hgq_streaming_pipeline.py --install --init-streaming
```

Use this only when the streaming tree should be reset to the generated baseline.
For normal optimized development, keep `hls_streaming/firmware` separate and
patch it deliberately.

Useful development options:

```bash
python scripts/hgq_streaming_pipeline.py --skip-compile --skip-verify
python scripts/hgq_streaming_pipeline.py --keep-build
python scripts/hgq_streaming_pipeline.py --debug-zero-quantizers
```

`--debug-zero-quantizers` is a compile-path check. It intentionally changes the
numerical result and should not be used for final validation.

Important generated reference files include:

```text
cnn_core_project/firmware/
cnn_core_project/hls4ml_config.yml
cnn_core_project/hgq_reference_manifest.json
build/hgq_streaming_pipeline/hgq_reference_manifest.json
```

## Streaming Optimization Flow

`hls_streaming` contains a copy of the hls4ml firmware plus a small comparison
testbench. It is used to check whether the optimized streaming implementation
still matches the generated IOStream baseline.

```bash
cd hls_streaming
make compare
make compare-long
```

The comparison builds two executables:

```text
../cnn_core_project/firmware/cnn_core.cpp
./firmware/cnn_core.cpp
```

Both are run on the same deterministic inputs, and their output logs are
compared byte-for-byte. This works on macOS and should also work on Ubuntu. On
macOS, the Makefile patches temporary copies of the Xilinx `ap_types` headers
under `hls_streaming/build/`; the source trees are not modified.

The current optimized streaming firmware keeps the 4-lane stream interface and
uses the HGQ-derived precision data from the installed baseline. In particular:

```text
nnet_hgq_stream.h                 Per-index HGQ stream quantizers
nnet_first_conv_stream.h          Input quantization before first convolution
nnet_dense_stream.h               Dense input quantization by flattened index
parameters.h / defines.h          HGQ-derived precision and sparsity metadata
weights/                          HGQ-derived generated weights and biases
```

Per-index HGQ quantizers should stay compact. Do not emit one large
`switch(index)` with one case per scalar position in the optimized HLS path.
Use an index-to-format table plus a small switch over the distinct quantizer
formats. The current compact implementation avoids the HLS front-end expansion
seen with the direct per-index switch.

The optimized implementation may differ structurally from the generated
baseline. It should still pass `make compare` before HLS synthesis is used for
resource or timing decisions.

Current HLS direction:

```text
top interval: about 262 cycles
primary limiter: first_conv_4lane_temporal_wide_cl, about 261 cycles
secondary limiter: dense_wide_stream, about 211 cycles
ReLU / MaxPool: about 87 cycles each
```

The main throughput limit is now the first convolution input path. With the
current 4-lane input stream, the lower bound is close to reading 256 input
words. ReLU and MaxPool are not first-order cycle targets. Further large
throughput gains likely require a planned input-interface change, such as
8-lane or 16-lane input words, and a corresponding dense-path review so the
bottleneck does not simply move from first conv to dense.

## Vitis HLS Build

For the generated baseline, run the hls4ml/Vitis project under:

```text
cnn_core_project/
```

For the optimized streaming implementation:

```bash
cd hls_streaming
make hls
```

For an out-of-context synthesis check:

```bash
cd hls_streaming
make hls-ooc-synth
```

The HLS flow writes project outputs under `hls_streaming/cnn_core_streaming_prj`.
These are generated outputs and should not be treated as source.

## Reports

HLS synthesis report:

```text
cnn_core_project/cnn_core_prj/solution1/syn/report/cnn_core_csynth.rpt
hls_streaming/cnn_core_streaming_prj/solution1/syn/report/cnn_core_csynth.rpt
```

Vivado synthesis report:

```text
cnn_core_project/vivado_synth.rpt
hls_streaming/cnn_core_streaming_prj/solution1/hls_summary.txt
```

Record at least:

```text
Latency cycles
Initiation interval
Estimated clock period / fmax
LUT / FF / DSP / BRAM usage
```

For final timing and utilization, run a separate Vivado implementation flow with
place and route, then collect timing summary and utilization reports.

## Bender

```bash
bender update
```

Before release, update `Bender.yml` if needed:

```bash
bash ./scripts/generate_bender_sources.sh
```

## Large File Check

Before pushing, check large tracked objects:

```bash
git rev-list --objects --all \
| git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
| sed -n 's/^blob //p' \
| sort --numeric-sort --key=2 --reverse \
| head -n 10 \
| cut -c 1-12,41- \
| numfmt --field=2 --to=iec-i --suffix=B --padding=7
```

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE).
