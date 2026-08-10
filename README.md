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
latest committed reports for authoritative results. The standalone-core
resource figures are from Vivado out-of-context synthesis before place and
route.

| Performance | Result |
|---|---:|
| Target clock | 200 MHz (5 ns) |
| Initiation interval | 178 cycles |
| Latency | 183 cycles (0.915 us) |
| Theoretical throughput | 1.12 million inferences/s |

| Resource | Used | Available | Utilization |
|---|---:|---:|---:|
| CLB LUTs | 5,857 | 216,960 | 2.70% |
| Flip-flops | 2,956 | 433,920 | 0.68% |
| DSP48E2 | 7 | 1,824 | 0.38% |
| RAMB18E2 | 2 | 960 | 0.21% |
| URAM | 0 | 64 | 0.00% |

After integration into the five-lane [AI Trigger System
v3.2](https://github.com/NuDAQ/AI-Trigger-System/tree/v3.2), the system-level
results are:

| System performance | Result |
|---|---:|
| Target ADC input | 8 channels at 1 Gsa/s per channel |
| Processing capacity (conservative config.) | 8 channels at 1.26 Gsa/s per channel |
| Aggregate chunk throughput | 3.91 million 256-sample chunks/s |
| CNN lanes | 5, each at 200 MHz |
| Latency for each lane | 203.6 CNN cycles (1.018 us) |
| Routed timing | WNS 1.085 ns; TNS 0 ns; WHS 0.009 ns; THS 0 ns |

| System resource | Used | Available | Utilization |
|---|---:|---:|---:|
| CLB LUTs | 28,864 | 216,960 | 13.30% |
| Flip-flops | 18,847 | 433,920 | 4.34% |
| DSP48E2 | 20 | 1,824 | 1.10% |
| BRAM tiles | 26 | 480 | 5.42% |
| URAM | 6 | 64 | 9.38% |

The routed OOC vectorless power estimate is 1.301 W total (0.844 W dynamic and
0.458 W static). The DAQ implementation demonstrates low-power, high-throughput, full-bandwidth real-time triggering.

## License

This project is licensed under the Apache License 2.0. See [LICENSE](LICENSE).
