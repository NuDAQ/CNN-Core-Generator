# CNN-Core-Generator

This codebase contains a CNN generator for high-energy neutrino detection. With
the introduction of [RAVEL (Rate-Aware Vectorized Engine for
Low-latency)](https://github.com/albertc9/RAVEL), an independently developed
library for CNN conversion and throughput-oriented optimization, the complete
generation flow now lives in the fewer-than-100-line [`generator.py`](generator.py).

The checked-in reference targets `xcku5p-ffvb676-2-e` at 5 ns. On Linux with
Python 3.11, install RAVEL (recommend a venv) and run:

```bash
python -m pip install ravel-hls
python generator.py
```

Vitis HLS is required only for vendor synthesis and RTL co-simulation.
After loading its environment, run:

```bash
cd cnn_core
vitis_hls -f build_prj.tcl
```

## Repository layout

```text
generator.py   The Python script
models/        Keras model
data/          Test inputs and labels
cnn_core/      Generated project
```

The generated firmware is under `cnn_core/firmware/`. RAVEL records the model,
configuration, interface, and source-verification facts in
`cnn_core/ravel_manifest.json`.

The RTL is generated under `cnn_core/cnn_core_prj/solution1/impl`.

## Reports and logs

- HLS synthesis: `cnn_core/cnn_core_prj/solution1/syn/report/cnn_core_csynth.rpt`
- RTL co-simulation: `cnn_core/cnn_core_prj/solution1/sim/report/cnn_core_cosim.rpt`
- C/RTL outputs: `cnn_core/tb_data/csim_results.log` and
  `cnn_core/tb_data/rtl_cosim_results.log`
- Vitis HLS log: `cnn_core/vitis_hls.log`
- Vivado OOC utilization: `cnn_core/vivado_synth.rpt`
- Vivado log: `cnn_core/vivado.log`

Large reproducible HLS/Vivado databases are ignored.

## Performance

Performance and resource figures are provided for reference only. Refer to the
latest committed reports for authoritative results.

| Performance | Result |
|---|---:|
| Target clock | 200 MHz (5 ns) |
| Latency | 57 cycles (0.285 us) |
| Initiation interval | 52 cycles |
| Theoretical throughput | 3.85 million inferences/s |

| Resource | Used | Available | Utilization (KU5P) |
|---|---:|---:|---:|
| CLB LUTs | 6,003 | 216,960 | 2.77% |
| Flip-flops | 3,964 | 433,920 | 0.91% |
| DSP48E2 | 67 | 1,824 | 3.67% |
| BRAM tiles | 1.5 | 480 | 0.31% |
| URAM | 0 | 64 | 0.00% |

Vitis HLS synthesis and RTL co-simulation passed for 32 test samples. The
resource figures are from Vivado synthesis and `opt_design`; place and route
were not run.

## License

This project is licensed under the Apache License 2.0. See [LICENSE](LICENSE).
