# CNN-Core-Generator

This codebase contains a CNN generator for high-energy neutrino detection. With
the introduction of [RAVEL (Rate-Aware Vectorized Engine for
Low-latency)](https://github.com/albertc9/RAVEL), an independently developed
library for CNN conversion and throughput-oriented optimization, the complete
generation flow now lives in the fewer-than-100-line [`generator.py`](generator.py).

The checked-in reference targets `xcku5p-ffvb676-2-e` at 5 ns. On Linux with
Python 3.11, install RAVEL and generate the project with:

```bash
python -m pip install ravel-hls
python generator.py
```

Vitis HLS 2023.2 is required only for vendor synthesis and RTL co-simulation.
After loading its environment, run:

```bash
cd cnn_core
vitis_hls -f build_prj.tcl
```

## Repository layout

```text
generator.py   Loads the model and test set, then generates and verifies Aria
models/        Trained Keras model and training references
data/          Test inputs and labels
cnn_core/      Generated hls4ml-compatible source, configuration, and evidence
```

The generated firmware is under `cnn_core/firmware/`. RAVEL records the model,
configuration, interface, and source-verification facts in
`cnn_core/ravel_manifest.json`. The current checked-in run verifies 1,000 test
inputs against Keras and the clean hls4ml baseline, then uses 32 of those inputs
for Vitis C/RTL comparison.

## Reports and logs

- HLS synthesis: `cnn_core/cnn_core_prj/solution1/syn/report/cnn_core_csynth.rpt`
- RTL co-simulation: `cnn_core/cnn_core_prj/solution1/sim/report/cnn_core_cosim.rpt`
- C/RTL outputs: `cnn_core/tb_data/csim_results.log` and
  `cnn_core/tb_data/rtl_cosim_results.log`
- Vitis HLS log: `cnn_core/vitis_hls.log`
- Vivado OOC utilization: `cnn_core/vivado_synth.rpt`
- Vivado log: `cnn_core/vivado.log`

Large reproducible HLS/Vivado databases are ignored; source files, reports, and
logs remain tracked.

## License

This project is licensed under the Apache License 2.0. See [LICENSE](LICENSE).
