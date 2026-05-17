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

    data_value_t row_window[CONFIG_T::filt_height][CONFIG_T::in_width];
    #pragma HLS ARRAY_PARTITION variable=row_window complete dim=0

ReadInputHeight:
    for (unsigned i_ih = 0; i_ih < CONFIG_T::in_height; i_ih++) {
        #pragma HLS PIPELINE II=1

        data_T in_pack = data.read();

    ShiftRows:
        for (unsigned k = 0; k < CONFIG_T::filt_height - 1; k++) {
            #pragma HLS UNROLL
        ShiftWidth:
            for (unsigned i_iw = 0; i_iw < CONFIG_T::in_width; i_iw++) {
                #pragma HLS UNROLL
                row_window[k][i_iw] = row_window[k + 1][i_iw];
            }
        }

    InsertRow:
        for (unsigned i_iw = 0; i_iw < CONFIG_T::in_width; i_iw++) {
            #pragma HLS UNROLL
            row_window[CONFIG_T::filt_height - 1][i_iw] = in_pack[i_iw];
        }

        const bool have_full_window = i_ih >= CONFIG_T::filt_height - 1;
        const bool on_stride =
            have_full_window && ((i_ih - (CONFIG_T::filt_height - 1)) % CONFIG_T::stride_height) == 0;

        if (have_full_window && on_stride) {
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
                    kernel_data[k] = row_window[k][i_iw];
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
    }
}

} // namespace nnet

#endif
