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

    hls::stream<layer3x4_t> layer3x4_out("layer3x4_out");
    #pragma HLS STREAM variable=layer3x4_out depth=4

    hls::stream<layer4x4_t> layer4x4_out("layer4x4_out");
    #pragma HLS STREAM variable=layer4x4_out depth=4
    #pragma HLS BIND_STORAGE variable=layer4x4_out type=fifo impl=srl

    hls::stream<layer5x4_t> layer5x4_out("layer5x4_out");
    #pragma HLS STREAM variable=layer5x4_out depth=4
    #pragma HLS BIND_STORAGE variable=layer5x4_out type=fifo impl=srl

    nnet::first_conv_4lane_temporal_wide_cl<input_t, layer3x4_t, config3>(input_layer, layer3x4_out, w3, b3); // repack_reshape + q_conv2d

    nnet::relu<layer3x4_t, layer4x4_t, relu_config4>(layer3x4_out, layer4x4_out); // q_conv2d_relu

    nnet::maxpool2d_wide_nonoverlap_cl<layer4x4_t, layer5x4_t, config5>(layer4x4_out, layer5x4_out); // max_pooling2d

    nnet::dense_wide_stream<layer5x4_t, result_t, config7>(layer5x4_out, layer7_out, w7, b7); // q_dense

}
