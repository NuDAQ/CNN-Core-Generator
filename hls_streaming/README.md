# hls_streaming

This directory starts as an unmodified copy of the hls4ml C++ firmware in
`../cnn_core_project/firmware`.

The current intent is:

1. Keep `../cnn_core_project/firmware` as the hls4ml chunk baseline.
2. Keep `firmware/` here identical at first.
3. Use `tb/compare_runner.cpp` and `make compare` to compile both source trees,
   run the same deterministic inputs, and compare their outputs exactly.
4. Modify this directory later for the streaming ADC trigger pipeline.

For macOS, `make compare` creates temporary patched copies of the Xilinx
`ap_types` headers under `build/` to avoid a Clang/libc++ `std::complex`
declaration conflict. The source trees under `../cnn_core_project/firmware`
and `firmware/` are not modified by that compatibility step.
