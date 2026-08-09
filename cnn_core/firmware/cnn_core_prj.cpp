#include <iostream>

#include "cnn_core_prj.h"
#include "parameters.h"
#include "nnet_utils/nnet_aria.h"

void cnn_core_prj(
    hls::stream<input_layer_x2_t> &input_layer,
    hls::stream<result_t> &layer9_out
) {
    #pragma HLS INTERFACE axis port=input_layer,layer9_out
    #pragma HLS DATAFLOW

#ifndef __SYNTHESIS__
    static bool loaded_weights = false;
    if (!loaded_weights) {
        nnet::load_weights_from_txt<q_conv2d_weight_t, 35>(w4, "w4.txt");
        nnet::load_weights_from_txt<q_conv2d_bias_t, 7>(b4, "b4.txt");
        nnet::load_weights_from_txt<q_dense_weight_t, 1176>(w9, "w9.txt");
        nnet::load_weights_from_txt<q_dense_bias_t, 1>(b9, "b9.txt");
        loaded_weights = true;
    }
#endif

    hls::stream<q_conv2d_x4_t> layer4_out_x4("layer4_out_x4");
    #pragma HLS STREAM variable=layer4_out_x4 depth=4
    #pragma HLS BIND_STORAGE variable=layer4_out_x4 type=fifo impl=srl

    hls::stream<q_conv2d_relu_x4_t> layer5_out_x4("layer5_out_x4");
    #pragma HLS STREAM variable=layer5_out_x4 depth=4
    #pragma HLS BIND_STORAGE variable=layer5_out_x4 type=fifo impl=srl

    hls::stream<max_pooling2d_x4_t> layer6_out_x4("layer6_out_x4");
    #pragma HLS STREAM variable=layer6_out_x4 depth=4
    #pragma HLS BIND_STORAGE variable=layer6_out_x4 type=fifo impl=srl

    nnet::first_conv_2row_4lane_temporal_wide_cl<input_layer_x2_t, q_conv2d_x4_t, config4>(
        input_layer, layer4_out_x4, w4, b4);
    nnet::relu<q_conv2d_x4_t, q_conv2d_relu_x4_t, relu_config5>(
        layer4_out_x4, layer5_out_x4);
    nnet::maxpool2d_wide_nonoverlap_cl<q_conv2d_relu_x4_t, max_pooling2d_x4_t, config6>(
        layer5_out_x4, layer6_out_x4);
    nnet::dense_wide_stream<max_pooling2d_x4_t, result_t, config9>(
        layer6_out_x4, layer9_out, w9, b9);
}
