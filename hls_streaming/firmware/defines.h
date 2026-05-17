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
typedef nnet::array<ap_fixed<12,6>, 4*1> input_t;
typedef nnet::array<ap_fixed<12,6>, 1*1> layer2_t;
typedef ap_fixed<16,6> model_default_t;
typedef nnet::array<ap_fixed<9,5>, 7*1> layer3_t;
typedef nnet::array<ap_fixed<9,5>, 7*4> layer3x4_t;
typedef ap_fixed<9,5> q_conv2d_weight_t;
typedef ap_fixed<9,5> q_conv2d_bias_t;
typedef nnet::array<ap_fixed<16,6>, 7*1> layer4_t;
typedef nnet::array<ap_fixed<16,6>, 7*4> layer4x4_t;
typedef ap_fixed<18,8> q_conv2d_relu_table_t;
typedef nnet::array<ap_fixed<16,6>, 7*1> layer5_t;
typedef nnet::array<ap_fixed<16,6>, 7*4> layer5x4_t;
typedef nnet::array<ap_fixed<9,5>, 1*1> result_t;
typedef ap_fixed<9,5> q_dense_weight_t;
typedef ap_fixed<9,5> q_dense_bias_t;
typedef ap_uint<1> layer7_index;

// hls-fpga-machine-learning insert emulator-defines


#endif
