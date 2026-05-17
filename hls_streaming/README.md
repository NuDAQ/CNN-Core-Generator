# hls_streaming

This directory starts as an unmodified copy of the hls4ml C++ firmware in
`../cnn_core_project/firmware`.

The current intent is:

1. Keep `../cnn_core_project/firmware` as the hls4ml chunk baseline.
2. Keep `firmware/` here identical at first.
3. Use `tb/compare_runner.cpp` and `make compare` to compile both source trees,
   run the same deterministic inputs, and compare their outputs exactly.
4. Modify this directory later for the streaming ADC trigger pipeline.

On macOS, plain Clang/libc++ may fail to compile the Xilinx `ap_fixed` headers
because of a `std::complex` declaration conflict. Run this comparison under
Vitis HLS or a Linux/GNU toolchain when possible.
