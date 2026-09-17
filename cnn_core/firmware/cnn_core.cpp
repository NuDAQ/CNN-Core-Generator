#include "cnn_core.h"
#include "parameters.h"
#include "nnet_utils/nnet_aria.h"
#include "nnet_utils/ravel_bridges.h"
#include "weights/w12_ravel_packed.h"
#include "nnet_utils/ravel_windows.h"
#include "nnet_utils/ravel_affine.h"
void cnn_core(hls::stream<waveform_x8_t> &waveform, hls::stream<result_t> &layer12_out) {
    #pragma HLS INTERFACE axis port=waveform,layer12_out
    #pragma HLS DATAFLOW
#ifndef __SYNTHESIS__
    static bool loaded = false;
    if (!loaded) {
        nnet::load_weights_from_txt<q_conv2d_bias_t, 12>(b3, "b3.txt");
        nnet::load_weights_from_txt<q_conv2d_weight_t, 60>(w3, "w3.txt");
        nnet::load_weights_from_txt<q_conv2d_1_bias_t, 12>(b7, "b7.txt");
        nnet::load_weights_from_txt<q_conv2d_1_weight_t, 720>(w7, "w7.txt");
        nnet::load_weights_from_txt<q_dense_bias_t, 1>(b12, "b12.txt");
        nnet::load_weights_from_txt<q_dense_weight_t, 288>(w12, "w12.txt");
        loaded = true;
    }
#endif
    hls::stream<max_pooling2d_x4_t> layer5_out_x4("layer5_out_x4");
    #pragma HLS STREAM variable=layer5_out_x4 depth=4
    hls::stream<ravel_conv2d_1_window_t> layer7_out("layer7_out");
    #pragma HLS STREAM variable=layer7_out depth=4
    hls::stream<ravel_relu_1_window_t> layer8_out("layer8_out");
    #pragma HLS STREAM variable=layer8_out depth=4
    hls::stream<ravel_max_pool2d_1_window_t> layer9_out("layer9_out");
    #pragma HLS STREAM variable=layer9_out depth=4
    nnet::phara_pool_aligned_hybrid_p8_cl<waveform_x8_t, q_conv2d_x4_t, q_conv2d_relu_x4_t, max_pooling2d_x4_t, config3, config5>(waveform, layer5_out_x4, w3, b3);
    // RAVEL_OBSERVE max_pool2d_0:out0 layer5_out_x4 2016
    ravel::shared_conv<max_pooling2d_x4_t, ravel_conv2d_1_window_t, config7, 4, ravel_matrix_conv2d_1, 2>(layer5_out_x4, layer7_out);
    // RAVEL_OBSERVE conv2d_1:out0 layer7_out 624
    nnet::relu<ravel_conv2d_1_window_t, ravel_relu_1_window_t, relu_config8>(layer7_out, layer8_out);
    // RAVEL_OBSERVE relu_1:out0 layer8_out 624
    ravel::scheduled_pool<ravel_relu_1_window_t, ravel_max_pool2d_1_window_t, config9, 4>(layer8_out, layer9_out);
    // RAVEL_OBSERVE max_pool2d_1:out0 layer9_out 288
    // RAVEL_OBSERVE reshape_0:out0 layer9_out 288
    nnet::dense_wide_stream<ravel_max_pool2d_1_window_t, result_t, config12>(layer9_out, layer12_out, w12_ravel_packed, b12);
    // RAVEL_OBSERVE dense_0:out0 layer12_out 1
}
