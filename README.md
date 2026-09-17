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

The figures below are for the two-convolution F12 model
(`fpga_2cv_k5s3_f12_es0`), generated with Aria 1.7.2 using P8/D4 and
`Optimization.TargetII: 85`. Performance and resource figures are provided for
reference only. Refer to the committed [HLS report](cnn_core/cnn_core_prj/solution1/syn/report/cnn_core_csynth.rpt)
and [Vivado utilization report](cnn_core/vivado_synth.rpt) for authoritative results.

| Performance            |                   Result |
| ---------------------- | -----------------------: |
| Target clock           |           200 MHz (5 ns) |
| Latency                |     71 cycles (0.355 us) |
| Initiation interval    |                63 cycles |
| Theoretical throughput | 3.17 million inferences/s |

Latency in microseconds and theoretical throughput are calculated from the HLS
cycle counts at the target clock frequency.

| Resource   |   Used | Available | Utilization (KU5P) |
| ---------- | -----: | --------: | -----------------: |
| CLB LUTs   | 28,684 |   216,960 |             13.22% |
| Flip-flops | 19,261 |   433,920 |              4.44% |
| DSP48E2    |     64 |     1,824 |              3.51% |
| BRAM tiles |      0 |       480 |              0.00% |
| URAM       |      0 |        64 |              0.00% |

Vitis HLS synthesis completed successfully. C simulation and
[RTL co-simulation](cnn_core/cnn_core_prj/solution1/sim/report/cnn_core_cosim.rpt)
passed for 96 built-in test samples, with identical C and RTL output logs.
Conversion verification also passed for 1,000 additional supplied samples,
with zero Keras-to-RAVEL score difference.

The resource figures are from Vivado synthesis and `opt_design`; place and route
were not run. The 200 MHz target has not been validated by routed timing for
this generated project.

## License

This project is licensed under the Apache License 2.0. See [LICENSE](LICENSE).
