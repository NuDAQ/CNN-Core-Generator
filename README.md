# CNN-Core
A CNN Core Generator and Code on ARIANNA Trigger System

## Dependencies
```
pip install -r requirements.txt
```

The conversion and build flow requires a working Vitis HLS installation. The current project targets:

```
xcku5p-ffvb676-2-e
```

## Model Conversion

The conversion entry point is:

```
python scripts/convert_homogeneous.py
```

This script loads the HGQ/Keras model from `models/hgq_config_beta7_gamma6_p1_cl_best_v3.keras`, extracts the homogeneous quantization settings, rebuilds the network with standard Keras layers, and converts it to an hls4ml Vitis project under `cnn_core_project/`.

The generated design uses `io_stream` and applies per-layer fixed-point precision to the convolution and dense layers. The test data in `data/` is also used to compare the Keras output against the compiled HLS model.

Main outputs:

```
cnn_core_project/keras_model.keras
cnn_core_project/hls4ml_config.yml
cnn_core_project/firmware/
cnn_core_project/tb_data/
```

## Bender
```
bender update
```

## Vitis HLS Build

Edit `cnn_core_project/build_opt.tcl`

```
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

Recommended full local check:

```
csim       1
synth      1
cosim      1
validation 1
export     1
vsynth     1
fifo_opt   1
```

Then run:

```
cd cnn_core_project
vitis_hls -f build_prj.tcl
```

The `vsynth` step runs `vivado_synth.tcl`, which performs Vivado synthesis and optimization on the generated RTL. It does not run full place-and-route implementation.

## Reports

Check the HLS synthesis report for latency, initiation interval, and HLS resource estimates:

```
cnn_core_project/cnn_core_prj/solution1/syn/report/cnn_core_csynth.rpt
```

Check the Vivado synthesis utilization report for post-synthesis resource usage:

```
cnn_core_project/vivado_synth.rpt
```

Typical metrics to record:

```
Latency cycles
Initiation interval
Estimated clock period
LUT / FF / DSP / BRAM usage
```

For post-implementation timing and utilization, run a separate Vivado implementation flow with `place_design` and `route_design`, then collect `report_timing_summary` and `report_utilization`.

## Always check the large files before pushing.
```
git rev-list --objects --all \
| git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
| sed -n 's/^blob //p' \
| sort --numeric-sort --key=2 --reverse \
| head -n 10 \
| cut -c 1-12,41- \
| numfmt --field=2 --to=iec-i --suffix=B --padding=7
```

## Release
Use it to update `Bender.yml` before release.
```
bash ./scripts/generate_bender_sources.sh
```

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
