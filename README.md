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

At the 200 MHz target clock, HLS reports an initiation interval of 178 cycles
and a latency of 183 cycles. This corresponds to a theoretical steady-state
throughput of about 1.12 million inferences per second and a latency of
0.915 us per inference.

Vivado out-of-context synthesis reports 5,857 CLB LUTs (4,764 logic and 1,093
shift-register LUTs), 2,956 flip-flops, 7 DSP48E2s, 2 RAMB18E2s, and no URAM.
These resource figures are before place and route.

## License

This project is licensed under the Apache License 2.0. See [LICENSE](LICENSE).
