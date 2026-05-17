#include <iostream>

#include "cnn_core.h"
#include "parameters.h"


void cnn_core(
    hls::stream<input_t> &input_layer,
    hls::stream<result_t> &layer7_out
) {

    // hls-fpga-machine-learning insert IO
    #pragma HLS INTERFACE axis port=input_layer,layer7_out 
    #pragma HLS DATAFLOW

    // hls-fpga-machine-learning insert load weights
#ifndef __SYNTHESIS__
    static bool loaded_weights = false;
    if (!loaded_weights) {
        nnet::load_weights_from_txt<q_conv2d_weight_t, 35>(w3, "w3.txt");
        nnet::load_weights_from_txt<q_conv2d_bias_t, 7>(b3, "b3.txt");
        nnet::load_weights_from_txt<q_dense_weight_t, 1176>(w7, "w7.txt");
        nnet::load_weights_from_txt<q_dense_bias_t, 1>(b7, "b7.txt");
        loaded_weights = true;    }
#endif
    // ****************************************
    // NETWORK INSTANTIATION
    // ****************************************

    // hls-fpga-machine-learning insert layers

    hls::stream<layer3_t> layer3_out("layer3_out");
    #pragma HLS STREAM variable=layer3_out depth=336

    hls::stream<layer4_t> layer4_out("layer4_out");
    #pragma HLS STREAM variable=layer4_out depth=336

    hls::stream<layer5_t> layer5_out("layer5_out");
    #pragma HLS STREAM variable=layer5_out depth=168

    auto& layer6_out = layer5_out;

    nnet::first_conv_4lane_temporal_cl<input_t, layer3_t, config3>(input_layer, layer3_out, w3, b3); // repack_reshape + q_conv2d

    nnet::relu<layer3_t, layer4_t, relu_config4>(layer3_out, layer4_out); // q_conv2d_relu

    nnet::maxpool2d_nonoverlap_cl<layer4_t, layer5_t, config5>(layer4_out, layer5_out); // max_pooling2d

    nnet::dense<layer5_t, result_t, config7>(layer6_out, layer7_out, w7, b7); // q_dense

}
