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
hls_streaming_bk/       Previous streaming implementation kept as reference
```

`build/` is local scratch space and should not be committed. Treat
`cnn_core_project/firmware` as the functional reference. Future architecture
work should normally happen under `hls_streaming/firmware`.

## Python Setup

```bash
pip install -r requirements.txt
```

## Homogeneous HGQ Baseline Generation

The conversion entry point is:

```bash
python scripts/convert_homo_stream.py
```

This script loads:

```text
models/hgq_config_beta7_gamma6_p1_cl_lowbop.keras
```

The v3.4 model is already homogeneous. The conversion therefore goes directly
from the Keras model to an hls4ml IOStream project. There is no IOParallel
precision oracle, no per-index HGQ extraction, and no generated stream
quantizer patching step.

The default output is:

```text
cnn_core_project/
```

The generated baseline still contains HGQ-derived homogeneous fixed-point
types. Do not confuse this with the older heterogeneous per-index HGQ flow:
homogeneous quantization should be represented by the generated layer types and
weights, not by index-dependent cast tables.

Useful options:

```bash
python scripts/convert_homo_stream.py --skip-compile --skip-verify
python scripts/convert_homo_stream.py --compile --verify
python scripts/convert_homo_stream.py --io-type io_stream
```

The older `scripts/hgq_streaming_pipeline.py` flow is retained as historical
context for heterogeneous HGQ models. Do not use it for the current v3.4
homogeneous baseline unless the model changes back to a heterogeneous
precision contract.

Important generated reference files include:

```text
cnn_core_project/firmware/
cnn_core_project/hls4ml_config.yml
cnn_core_project/keras_model.keras
```

## Streaming Optimization Flow

`hls_streaming` contains the editable C++ HLS implementation. It is compared
against the immutable generated baseline in `cnn_core_project`.

The previous optimized implementation was moved to:

```text
hls_streaming_bk/
```

Keep it as a reference while v3.4 settles; remove it in a later cleanup once
the new homogeneous streaming path has enough HLS evidence.

Run the behavioral comparison:

```bash
cd hls_streaming
make compare
make compare SAMPLES=1024
```

The comparison builds two executables:

```text
../cnn_core_project/firmware/cnn_core.cpp   generated baseline
./firmware/cnn_core.cpp                     optimized streaming implementation
```

The current optimized path uses a 2x input stream contract:

```text
baseline input word:   input_layer_t    = 1 time sample x 4 lanes
streaming input word:  input_layer_x2_t = 2 time samples x 4 lanes
```

The testbench repacks the same deterministic `256 x 4` input chunk differently
for the two runners, then compares output logs byte-for-byte.

Current optimized data path:

```text
input_layer_x2_t
  -> first_conv_2row_4lane_temporal_wide_cl
  -> relu over 4-width packed words
  -> maxpool2d_wide_nonoverlap_cl
  -> dense_wide_stream
  -> layer9_out
```

The optimized implementation may differ structurally from the generated
baseline. It should still pass `make compare` before HLS synthesis is used for
resource or timing decisions.

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
