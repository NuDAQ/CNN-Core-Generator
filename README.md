# CNN-Core-Generator

This repository contains the current CNN trigger core workflow for an FPGA-based
inference pipeline. The immediate baseline is an hls4ml-generated Vitis HLS
project, with a separate C++ working area for streaming ADC-oriented changes.

The current target part is:

```text
xcku5p-ffvb676-2-e
```

## Layout

```text
data/                  Test arrays used by the conversion flow
models/                Trained Keras/PyTorch model artifacts
scripts/               Model conversion scripts
cnn_core_project/       hls4ml-generated Vitis HLS project
cnn_core_project/firmware/
                       Original hls4ml C++ firmware baseline
hls_streaming/          Working C++ HLS area for streaming trigger development
rtl/                   RTL sources managed outside the hls4ml generated output
```

Treat `cnn_core_project/firmware` as the reference hls4ml chunk implementation.
Future C++ HLS development should normally happen under `hls_streaming/firmware`.

## Python Setup

```bash
pip install -r requirements.txt
```

## hls4ml Conversion

The conversion entry point is:

```bash
python scripts/convert_homogeneous.py
```

This script loads:

```text
models/hgq_config_beta7_gamma6_p1_cl_best_v3.keras
```

and writes the hls4ml/Vitis project under:

```text
cnn_core_project/
```

Important generated files include:

```text
cnn_core_project/hls4ml_config.yml
cnn_core_project/firmware/
cnn_core_project/tb_data/
cnn_core_project/cnn_core_prj/
```

## C++ HLS Comparison

`hls_streaming` contains a copy of the hls4ml firmware plus a small comparison
testbench. It is used to check whether the working C++ implementation still
matches the original hls4ml baseline.

```bash
cd hls_streaming
make compare
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

## Vitis HLS Build

Edit:

```text
cnn_core_project/build_opt.tcl
```

Typical full check:

```tcl
array set opt {
    reset      0
    csim       1
    synth      1
    cosim      1
    validation 1
    export     1
    vsynth     1
    fifo_opt   1
}
```

Then run:

```bash
cd cnn_core_project
vitis_hls -f build_prj.tcl
```

The `vsynth` step runs Vivado synthesis on the generated RTL. It does not run
full place-and-route implementation.

## Reports

HLS synthesis report:

```text
cnn_core_project/cnn_core_prj/solution1/syn/report/cnn_core_csynth.rpt
```

Vivado synthesis report:

```text
cnn_core_project/vivado_synth.rpt
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
