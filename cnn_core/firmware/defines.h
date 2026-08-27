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
typedef nnet::array<ap_fixed<10,5,AP_RND,AP_SAT_SYM,0>, 4*1> waveform_t;
typedef nnet::array<ap_fixed<10,5>, 1*1> ravel_repack_t;
typedef ap_fixed<16,6> q_conv2d_accum_t;
typedef nnet::array<ap_fixed<16,6>, 7*1> q_conv2d_t;
typedef ap_fixed<6,1> q_conv2d_weight_t;
typedef ap_fixed<5,1> q_conv2d_bias_t;
typedef nnet::array<ap_ufixed<15,5>, 7*1> q_conv2d_relu_t;
typedef ap_fixed<18,8> q_conv2d_relu_table_t;
typedef ap_ufixed<15,5> max_pooling2d_accum_t;
typedef nnet::array<ap_fixed<10,5,AP_RND,AP_SAT_SYM,0>, 7*1> max_pooling2d_t;
typedef ap_fixed<23,13> q_dense_accum_t;
typedef nnet::array<ap_fixed<23,13>, 1*1> result_t;
typedef ap_fixed<6,1> q_dense_weight_t;
typedef ap_fixed<1,-1> q_dense_bias_t;
typedef ap_uint<1> layer9_index;

// hls-fpga-machine-learning insert emulator-defines

// RAVEL Aria wide-stream types.
typedef nnet::array<ap_fixed<10,5,AP_RND,AP_SAT_SYM,0>, 8*4> waveform_x8_t;
typedef nnet::array<ap_fixed<16,6>, 28> q_conv2d_x4_t;
typedef nnet::array<ap_ufixed<15,5>, 28> q_conv2d_relu_x4_t;
typedef nnet::array<ap_fixed<10,5,AP_RND,AP_SAT_SYM,0>, 28> max_pooling2d_x4_t;

#endif
