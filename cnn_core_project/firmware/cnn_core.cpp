#include <iostream>

#include "cnn_core.h"
#include "parameters.h"


void cnn_core(
    hls::stream<input_t> &input_layer,
    hls::stream<result_t> &layer10_out
) {

    // hls-fpga-machine-learning insert IO
    #pragma HLS INTERFACE axis port=input_layer,layer10_out 
    #pragma HLS DATAFLOW

    // hls-fpga-machine-learning insert load weights
#ifndef __SYNTHESIS__
    static bool loaded_weights = false;
    if (!loaded_weights) {
        nnet::load_weights_from_txt<q_conv2d_weight_t, 35>(w4, "w4.txt");
        nnet::load_weights_from_txt<q_conv2d_bias_t, 7>(b4, "b4.txt");
        nnet::load_weights_from_txt<q_dense_weight_t, 1176>(w10, "w10.txt");
        nnet::load_weights_from_txt<q_dense_bias_t, 1>(b10, "b10.txt");
        loaded_weights = true;    }
#endif
    // ****************************************
    // NETWORK INSTANTIATION
    // ****************************************

    // hls-fpga-machine-learning insert layers

    hls::stream<layer2_t> layer2_out("layer2_out");
    #pragma HLS STREAM variable=layer2_out depth=4

    hls::stream<layer3_t> layer11_out("layer11_out");
    #pragma HLS STREAM variable=layer11_out depth=1024

    hls::stream<layer4_t> layer4_out("layer4_out");
    #pragma HLS STREAM variable=layer4_out depth=336

    hls::stream<layer5_t> layer5_out("layer5_out");
    #pragma HLS STREAM variable=layer5_out depth=336

    hls::stream<layer6_t> layer6_out("layer6_out");
    #pragma HLS STREAM variable=layer6_out depth=168

    hls::stream<layer7_t> layer12_out("layer12_out");
    #pragma HLS STREAM variable=layer12_out depth=28

    hls::stream<layer8_t> layer13_out("layer13_out");
    #pragma HLS STREAM variable=layer13_out depth=28

    auto& layer9_out = layer13_out;
    nnet::transpose<input_t, layer2_t, config2>(input_layer, layer2_out); // permute

    nnet::repack_stream<layer2_t, layer3_t, 1024>(layer2_out, layer11_out); // repack_reshape

    nnet::conv_2d_cl<layer3_t, layer4_t, config4>(layer11_out, layer4_out, w4, b4); // q_conv2d

    nnet::relu<layer4_t, layer5_t, relu_config5>(layer4_out, layer5_out); // q_conv2d_relu

    nnet::pooling2d_cl<layer5_t, layer6_t, config6>(layer5_out, layer6_out); // max_pooling2d

    nnet::repack_stream<layer6_t, layer7_t, 1176>(layer6_out, layer12_out); // repack_reshape_1

    nnet::repack_stream<layer7_t, layer8_t, 1176>(layer12_out, layer13_out); // repack_reshape_2

    nnet::dense<layer8_t, result_t, config10>(layer9_out, layer10_out, w10, b10); // q_dense

}

