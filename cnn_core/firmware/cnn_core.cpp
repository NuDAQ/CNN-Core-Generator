#include <iostream>

#include "cnn_core.h"
#include "parameters.h"
#include "nnet_utils/nnet_aria.h"
#include "weights/w9_ravel_packed.h"


void cnn_core(
    hls::stream<waveform_x8_t> &waveform,
    hls::stream<result_t> &layer9_out
) {
    #pragma HLS INTERFACE axis port=waveform,layer9_out
    #pragma HLS DATAFLOW

#ifndef __SYNTHESIS__
    static bool loaded_weights = false;
    if (!loaded_weights) {
        nnet::load_weights_from_txt<q_conv2d_weight_t, 35>(w4, "w4.txt");
        nnet::load_weights_from_txt<q_conv2d_bias_t, 7>(b4, "b4.txt");

        nnet::load_weights_from_txt<q_dense_bias_t, 1>(b9, "b9.txt");
        loaded_weights = true;
    }
#endif

    hls::stream<max_pooling2d_x4_t> layer6_out_x4("layer6_out_x4");
    #pragma HLS STREAM variable=layer6_out_x4 depth=4
    #pragma HLS BIND_STORAGE variable=layer6_out_x4 type=fifo impl=srl


    #pragma HLS BIND_STORAGE variable=w9_ravel_packed type=rom_1p impl=bram


    nnet::phara_pool_aligned_hybrid_p8_cl<
        waveform_x8_t, q_conv2d_x4_t, q_conv2d_relu_x4_t,
        max_pooling2d_x4_t, config4, config6>(
        waveform, layer6_out_x4, w4, b4);

    nnet::dense_wide_stream<max_pooling2d_x4_t, result_t, config9>(
        layer6_out_x4, layer9_out, w9_ravel_packed, b9);
}
