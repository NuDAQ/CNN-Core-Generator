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

## Performance Summary

Target device: `xcku5p-ffvb676-2-e`, 5 ns clock (200 MHz).

### Throughput (top-level interval per 256×4 inference)

| Branch / Optimization | Loop structure | csynth interval | RTL cosim interval |
|----------------------|----------------|----------------|--------------------|
| v3.2 (1x streaming) | per-row, 1 row/word | 260 cycles | — |
| v3.4 per-row loop (7677c0d) | 256 iter/II=1, 2 rows/word | 260 cycles | 257 cycles ✓ |
| **v3.4 pair parallelism** | **128 iter/II=1, 2 rows/word** | **178 cycles** | **177 cycles ✓** |

v3.4 pair parallelism delivers a **32% interval reduction** vs. v3.2 (260 → 178 cycles
csynth; 257 → 177 cycles cosim). The top-level bottleneck shifted from
`first_conv` (259 → 131 cycles) to `dense_wide_stream` (177 cycles).

### Per-layer interval (v3.4 pair parallelism, csynth)

| Layer | Interval | Loop | Notes |
|-------|----------|------|-------|
| `dense_wide_stream` | **177** | `DenseWideMain` 168 iter II=1 | **bottleneck** |
| `first_conv_2row_4lane_temporal_wide_cl` | **131** | `ReadPairsWide` 128 iter II=1 | was 259 |
| `relu` | 87 | — | |
| `maxpool2d_wide_nonoverlap_cl` | 87 | — | |

### Resource usage

| Metric | v3.2 csynth est. | v3.4 csynth est. | v3.4 OOC actual |
|--------|-----------------|-----------------|-----------------|
| LUT (logic) | 26 500 | 28 922 | **4 829** (2.2%) |
| LUT (shift reg) | — | — | **1 093** (1.1%) |
| FF | 2 975 | 3 483 | **2 953** (0.7%) |
| DSP | 11 | 4 | **7** (0.4%) |
| BRAM | 0 | 0 | **2× RAMB18E2** (0.2%) |
| OOC WNS | — | — | **+2.152 ns** ✓ |

Notes:
- v3.2 has no OOC synthesis report; csynth estimates are pre-place-and-route.
- v3.4 uses wider homogeneous HGQ precision (`ap_fixed<22,11>` for dense vs
  `ap_fixed<9,5>` in v3.2), which inflates csynth LUT estimates but is
  absorbed efficiently post-synthesis (OOC logic LUT < 5k vs. csynth 29k).
- LUT-SR (1 093) is the 5-row shift-register row buffer inferred by Vivado.
- DSP stays at 7 (OOC) despite csynth reporting 4; Vivado infers a few
  additional DSPs for the dense fixed-point multiply tree.

### Reports

HLS synthesis report:

```text
cnn_core_project/cnn_core_prj/solution1/syn/report/cnn_core_csynth.rpt
hls_streaming/cnn_core_streaming_prj/solution1/syn/report/cnn_core_csynth.rpt
```

HLS summary (interval, latency, top resources, cosim):

```text
hls_streaming/cnn_core_streaming_prj/solution1/hls_summary.txt
```

OOC timing and utilization (post-synthesis, v3.4 only):

```text
hls_streaming/cnn_core_streaming_prj/solution1/ooc_synth/timing_ooc.rpt
hls_streaming/cnn_core_streaming_prj/solution1/ooc_synth/utilization_ooc.rpt
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
