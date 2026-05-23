#ifndef CNN_CORE_H_
#define CNN_CORE_H_

#include "ap_fixed.h"
#include "ap_int.h"
#include "hls_stream.h"

#include "defines.h"


// Prototype of top level function for C-synthesis
void cnn_core(
    input_layer_t input_layer[256*4],
    result_t layer9_out[1]
);

// hls-fpga-machine-learning insert emulator-defines


#endif
