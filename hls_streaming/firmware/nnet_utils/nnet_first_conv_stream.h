#ifndef NNET_FIRST_CONV_STREAM_H_
#define NNET_FIRST_CONV_STREAM_H_

#include "hls_stream.h"
#include "nnet_common.h"
#include "nnet_dense.h"

namespace nnet {

template <class data_T, class res_T, typename CONFIG_T>
void first_conv_4lane_temporal_cl(
    hls::stream<data_T> &data, hls::stream<res_T> &res,
    typename CONFIG_T::weight_t weights[CONFIG_T::filt_height * CONFIG_T::filt_width * CONFIG_T::n_chan * CONFIG_T::n_filt],
    typename CONFIG_T::bias_t biases[CONFIG_T::n_filt]) {
    static_assert(CONFIG_T::n_chan == 1, "first_conv_4lane_temporal_cl expects n_chan == 1");
    static_assert(CONFIG_T::filt_width == 1, "first_conv_4lane_temporal_cl expects filt_width == 1");
    static_assert(CONFIG_T::stride_width == 1, "first_conv_4lane_temporal_cl expects stride_width == 1");
    static_assert(CONFIG_T::in_width == data_T::size, "input pack width must match CONFIG_T::in_width");
    static_assert(CONFIG_T::n_filt == res_T::size, "output pack width must match CONFIG_T::n_filt");

    typedef typename data_T::value_type data_value_t;
    typedef typename res_T::value_type res_value_t;

    // Ring buffer: each iteration writes one slot; no shift, no loop-carried RAW dependency.
    data_value_t row_buf[CONFIG_T::filt_height][CONFIG_T::in_width];
    #pragma HLS ARRAY_PARTITION variable=row_buf complete dim=0

    // Use plain unsigned for array indices to avoid HLS ap_uint bit-extension warnings.
    // wptr: next slot to write (oldest slot after full window).
    // stride_cnt: replaces % stride_height, eliminates synthesized urem divider.
    unsigned wptr = 0;
    unsigned stride_cnt = 0;

ReadInputHeight:
    for (unsigned i_ih = 0; i_ih < CONFIG_T::in_height; i_ih++) {
        #pragma HLS PIPELINE II=1
        #pragma HLS DEPENDENCE variable=row_buf inter false

        data_T in_pack = data.read();

    InsertRow:
        for (unsigned i_iw = 0; i_iw < CONFIG_T::in_width; i_iw++) {
            #pragma HLS UNROLL
            row_buf[wptr][i_iw] = in_pack[i_iw];
        }

        // oldest points to the slot just after wptr (the oldest row in the window).
        unsigned oldest = (wptr == CONFIG_T::filt_height - 1) ? 0u : wptr + 1;

        const bool have_full_window = i_ih >= CONFIG_T::filt_height - 1;
        const bool on_stride = have_full_window && (stride_cnt == 0);

        if (on_stride) {
        WriteOutputWidth:
            for (unsigned i_iw = 0; i_iw < CONFIG_T::in_width; i_iw++) {
                #pragma HLS PIPELINE II=1

                data_value_t kernel_data[CONFIG_T::filt_height * CONFIG_T::filt_width * CONFIG_T::n_chan];
                #pragma HLS ARRAY_PARTITION variable=kernel_data complete

                res_value_t res_out[CONFIG_T::n_filt];
                #pragma HLS ARRAY_PARTITION variable=res_out complete

                res_T res_pack;
                PRAGMA_DATA_PACK(res_pack)

            CopyKernel:
                for (unsigned k = 0; k < CONFIG_T::filt_height; k++) {
                    #pragma HLS UNROLL
                    // Circular read: oldest row is kernel row 0, newest is filt_height-1.
                    unsigned ridx = (oldest + k < CONFIG_T::filt_height)
                                    ? oldest + k
                                    : oldest + k - CONFIG_T::filt_height;
                    kernel_data[k] = row_buf[ridx][i_iw];
                }

                CONFIG_T::mult_config::template kernel<data_value_t, res_value_t, typename CONFIG_T::mult_config>::dense(
                    kernel_data, res_out, weights, biases);

            PackOutput:
                for (unsigned i_f = 0; i_f < CONFIG_T::n_filt; i_f++) {
                    #pragma HLS UNROLL
                    res_pack[i_f] = res_out[i_f];
                }

                res.write(res_pack);
            }
        }

        // Advance ring pointer to the oldest slot (next write overwrites oldest data).
        wptr = oldest;
        if (have_full_window) {
            stride_cnt = (stride_cnt == CONFIG_T::stride_height - 1) ? 0u : stride_cnt + 1;
        }
    }
}

template <class data_T, class res_T, typename CONFIG_T>
void first_conv_4lane_temporal_wide_cl(
    hls::stream<data_T> &data, hls::stream<res_T> &res,
    typename CONFIG_T::weight_t weights[CONFIG_T::filt_height * CONFIG_T::filt_width * CONFIG_T::n_chan * CONFIG_T::n_filt],
    typename CONFIG_T::bias_t biases[CONFIG_T::n_filt]) {
    static_assert(CONFIG_T::n_chan == 1, "first_conv_4lane_temporal_wide_cl expects n_chan == 1");
    static_assert(CONFIG_T::filt_width == 1, "first_conv_4lane_temporal_wide_cl expects filt_width == 1");
    static_assert(CONFIG_T::stride_width == 1, "first_conv_4lane_temporal_wide_cl expects stride_width == 1");
    static_assert(CONFIG_T::in_width == data_T::size, "input pack width must match CONFIG_T::in_width");
    static_assert(CONFIG_T::n_filt * CONFIG_T::out_width == res_T::size,
                  "wide output must pack all width positions and filters");

    typedef typename data_T::value_type data_value_t;
    typedef typename res_T::value_type res_value_t;

    data_value_t row_buf[CONFIG_T::filt_height][CONFIG_T::in_width];
    #pragma HLS ARRAY_PARTITION variable=row_buf complete dim=0

    unsigned wptr = 0;
    unsigned stride_cnt = 0;

ReadInputHeightWide:
    for (unsigned i_ih = 0; i_ih < CONFIG_T::in_height; i_ih++) {
        #pragma HLS PIPELINE II=1
        #pragma HLS DEPENDENCE variable=row_buf inter false

        data_T in_pack = data.read();

    InsertRowWide:
        for (unsigned i_iw = 0; i_iw < CONFIG_T::in_width; i_iw++) {
            #pragma HLS UNROLL
            row_buf[wptr][i_iw] = in_pack[i_iw];
        }

        unsigned oldest = (wptr == CONFIG_T::filt_height - 1) ? 0u : wptr + 1;

        const bool have_full_window = i_ih >= CONFIG_T::filt_height - 1;
        const bool on_stride = have_full_window && (stride_cnt == 0);

        if (on_stride) {
            res_T res_pack;
            PRAGMA_DATA_PACK(res_pack)

        WriteOutputWidthWide:
            for (unsigned i_iw = 0; i_iw < CONFIG_T::out_width; i_iw++) {
                #pragma HLS UNROLL

                data_value_t kernel_data[CONFIG_T::filt_height * CONFIG_T::filt_width * CONFIG_T::n_chan];
                #pragma HLS ARRAY_PARTITION variable=kernel_data complete

                res_value_t res_out[CONFIG_T::n_filt];
                #pragma HLS ARRAY_PARTITION variable=res_out complete

            CopyKernelWide:
                for (unsigned k = 0; k < CONFIG_T::filt_height; k++) {
                    #pragma HLS UNROLL
                    unsigned ridx = (oldest + k < CONFIG_T::filt_height)
                                    ? oldest + k
                                    : oldest + k - CONFIG_T::filt_height;
                    kernel_data[k] = row_buf[ridx][i_iw];
                }

                CONFIG_T::mult_config::template kernel<data_value_t, res_value_t, typename CONFIG_T::mult_config>::dense(
                    kernel_data, res_out, weights, biases);

            PackWideOutput:
                for (unsigned i_f = 0; i_f < CONFIG_T::n_filt; i_f++) {
                    #pragma HLS UNROLL
                    res_pack[i_iw * CONFIG_T::n_filt + i_f] = res_out[i_f];
                }
            }

            res.write(res_pack);
        }

        wptr = oldest;
        if (have_full_window) {
            stride_cnt = (stride_cnt == CONFIG_T::stride_height - 1) ? 0u : stride_cnt + 1;
        }
    }
}

template <class data_T, class res_T, typename CONFIG_T>
void unpack_4lane_temporal_cl(hls::stream<data_T> &data, hls::stream<res_T> &res) {
    static_assert(CONFIG_T::n_filt == res_T::size, "narrow output must pack one width position of filters");
    static_assert(CONFIG_T::out_width * CONFIG_T::n_filt == data_T::size,
                  "wide input must pack all width positions and filters");

UnpackOutputHeight:
    for (unsigned i_oh = 0; i_oh < CONFIG_T::out_height; i_oh++) {
        data_T in_pack = data.read();

    UnpackOutputWidth:
        for (unsigned i_iw = 0; i_iw < CONFIG_T::out_width; i_iw++) {
            #pragma HLS PIPELINE II=1

            res_T out_pack;
            PRAGMA_DATA_PACK(out_pack)

        UnpackFilters:
            for (unsigned i_f = 0; i_f < CONFIG_T::n_filt; i_f++) {
                #pragma HLS UNROLL
                out_pack[i_f] = in_pack[i_iw * CONFIG_T::n_filt + i_f];
            }

            res.write(out_pack);
        }
    }
}

} // namespace nnet

#endif
