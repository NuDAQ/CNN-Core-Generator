#ifndef DEFINES_H_
#define DEFINES_H_

#include "ap_fixed.h"
#include "ap_int.h"
#include "nnet_utils/nnet_types.h"
#include <array>
#include <cstddef>
#include <cstdio>
#include <tuple>
#include <tuple>


// hls-fpga-machine-learning insert numbers

// hls-fpga-machine-learning insert layer-precision
typedef ap_fixed<9,4,AP_TRN,AP_SAT,0> input_layer_t;
typedef ap_fixed<8,4> q_conv2d_iq_t;
typedef ap_fixed<15,6> q_conv2d_accum_t;
typedef ap_fixed<15,6> q_conv2d_t;
typedef ap_fixed<6,1> q_conv2d_weight_t;
typedef ap_fixed<5,1> q_conv2d_bias_t;
typedef ap_ufixed<14,5> q_conv2d_relu_t;
typedef ap_fixed<18,8> q_conv2d_relu_table_t;
typedef ap_ufixed<14,5> max_pooling2d_accum_t;
typedef ap_ufixed<10,5> max_pooling2d_t;
typedef ap_fixed<7,3> q_dense_iq_t;
typedef ap_fixed<17,9> q_dense_accum_t;
typedef ap_fixed<17,9> result_t;
typedef ap_fixed<7,2> q_dense_weight_t;
typedef ap_fixed<3,0> q_dense_bias_t;
typedef ap_uint<1> layer9_index;

// hls-fpga-machine-learning insert emulator-defines


#endif
