#include <iostream>

#include "cnn_core.h"
#include "parameters.h"


void cnn_core(
    input_layer_t input_layer[256*4],
    result_t layer9_out[1]
) {

    // hls-fpga-machine-learning insert IO
    #pragma HLS ARRAY_RESHAPE variable=input_layer complete dim=0
    #pragma HLS ARRAY_PARTITION variable=layer9_out complete dim=0
    #pragma HLS INTERFACE ap_vld port=input_layer,layer9_out 
    #pragma HLS DATAFLOW

    // hls-fpga-machine-learning insert load weights
#ifndef __SYNTHESIS__
    static bool loaded_weights = false;
    if (!loaded_weights) {
        nnet::load_weights_from_txt<q_conv2d_weight_t, 35>(w4, "w4.txt");
        nnet::load_weights_from_txt<q_conv2d_bias_t, 7>(b4, "b4.txt");
        nnet::load_weights_from_txt<q_dense_weight_t, 1176>(w9, "w9.txt");
        nnet::load_weights_from_txt<q_dense_bias_t, 1>(b9, "b9.txt");
        loaded_weights = true;    }
#endif
    // ****************************************
    // NETWORK INSTANTIATION
    // ****************************************

    // hls-fpga-machine-learning insert layers

    auto& layer2_out = input_layer;
    q_conv2d_iq_t layer3_out[256*4*1];
    #pragma HLS ARRAY_PARTITION variable=layer3_out complete dim=0

    q_conv2d_t layer4_out[84*4*7];
    #pragma HLS ARRAY_PARTITION variable=layer4_out complete dim=0

    q_conv2d_relu_t layer5_out[84*4*7];
    #pragma HLS ARRAY_PARTITION variable=layer5_out complete dim=0

    max_pooling2d_t layer6_out[42*4*7];
    #pragma HLS ARRAY_PARTITION variable=layer6_out complete dim=0

    auto& layer7_out = layer6_out;
    q_dense_iq_t layer8_out[1176];
    #pragma HLS ARRAY_PARTITION variable=layer8_out complete dim=0

    nnet::q_conv2d_iq<input_layer_t, q_conv2d_iq_t>(layer2_out, layer3_out); // q_conv2d_iq

    nnet::conv_2d_cl<q_conv2d_iq_t, q_conv2d_t, config4>(layer3_out, layer4_out, w4, b4); // q_conv2d

    nnet::relu<q_conv2d_t, q_conv2d_relu_t, relu_config5>(layer4_out, layer5_out); // q_conv2d_relu

    nnet::pooling2d_cl<q_conv2d_relu_t, max_pooling2d_t, config6>(layer5_out, layer6_out); // max_pooling2d

    nnet::q_dense_iq<max_pooling2d_t, q_dense_iq_t>(layer7_out, layer8_out); // q_dense_iq

    nnet::dense<q_dense_iq_t, result_t, config9>(layer8_out, layer9_out, w9, b9); // q_dense

}

