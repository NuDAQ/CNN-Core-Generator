# CNN-Core
A CNN Core Generator and Code on ARIANNA Trigger System

## Dependency
```
pip install -r requirements.txt
```

## Bender
```
bender update
```

## Compile
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

Then compile. Make sure you have Vitis HLS installed and properly set up in your environment.
```
cd cnn_core_project
vitis_hls -f build_prj.tcl
```

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
