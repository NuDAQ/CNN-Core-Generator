#ifndef NNET_HGQ_STREAM_H_
#define NNET_HGQ_STREAM_H_

#include "hls_stream.h"
#include "nnet_common.h"
#include "nnet_types.h"

namespace nnet {

template <class data_T, class res_T, unsigned N_IN, class CAST_T>
void hgq_quantize_stream(hls::stream<data_T> &data_stream, hls::stream<res_T> &res_stream) {
    #pragma HLS INLINE off
    static_assert(data_T::size == res_T::size, "HGQ stream quantizer preserves packet width.");
    static_assert(N_IN % data_T::size == 0, "HGQ stream quantizer expects full stream packets.");

QuantizePackets:
    for (unsigned i_in = 0; i_in < N_IN / data_T::size; i_in++) {
        #pragma HLS PIPELINE
        data_T data_pack = data_stream.read();
        res_T res_pack;
        PRAGMA_DATA_PACK(res_pack)
    QuantizePack:
        for (int i_pack = 0; i_pack < data_T::size; i_pack++) {
            #pragma HLS UNROLL
            const unsigned index = i_in * data_T::size + i_pack;
            res_pack[i_pack] = CAST_T::template cast<typename data_T::value_type, typename res_T::value_type>(
                data_pack[i_pack], index);
        }
        res_stream.write(res_pack);
    }
}

struct q_conv2d_iq_cast {
    static unsigned char format_id(unsigned index) {
        #pragma HLS INLINE
        static const unsigned char formats[1024] = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 2, 3, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1,
        0, 3, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0,
        0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0,
        1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1,
        0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0,
        1, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 4, 2, 4, 4, 2,
        4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 5,
        5, 5, 5, 7, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
        5, 5, 5, 5, 7, 5, 5, 5, 7, 7, 7, 7, 5, 5, 5, 5, 5, 5, 7, 5, 5, 8, 7, 5, 5, 5, 5, 5, 5, 7, 5, 5,
        6, 5, 5, 6, 5, 6, 6, 5, 5, 5, 5, 6, 5, 5, 5, 6, 5, 5, 5, 6, 6, 5, 6, 6, 4, 2, 2, 2, 2, 2, 2, 2,
        2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 1, 1, 1, 2, 2, 2, 2, 1, 1, 2, 2, 2,
        1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0,
        3, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 3, 0, 3, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 3, 1, 0, 1, 1,
        0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 2, 1, 3, 0, 1, 1,
        1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 0, 1,
        0, 3, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1,
        2, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 3, 1,
        1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1,
        0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 0,
        1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 2, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0,
        1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0,
        1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0,
        0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0,
        1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 3, 2, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1,
        0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1,
        1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 3, 0, 1,
        1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
        0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9
        };
        #pragma HLS ARRAY_PARTITION variable=formats cyclic factor=4 dim=1
        return formats[index];
    }

    template <class in_T, class out_T>
    static out_T cast_by_format(in_T value, unsigned char format) {
        #pragma HLS INLINE
        switch (format) {
        case 0: return (out_T) ap_fixed<3,2,AP_RND,AP_SAT_SYM>(value);
        case 1: return (out_T) ap_fixed<4,2,AP_RND,AP_SAT_SYM>(value);
        case 2: return (out_T) ap_fixed<5,3,AP_RND,AP_SAT_SYM>(value);
        case 3: return (out_T) ap_fixed<4,3,AP_RND,AP_SAT_SYM>(value);
        case 4: return (out_T) ap_fixed<6,4,AP_RND,AP_SAT_SYM>(value);
        case 5: return (out_T) ap_fixed<7,4,AP_RND,AP_SAT_SYM>(value);
        case 6: return (out_T) ap_fixed<6,3,AP_RND,AP_SAT_SYM>(value);
        case 7: return (out_T) ap_fixed<8,4,AP_RND,AP_SAT_SYM>(value);
        case 8: return (out_T) ap_fixed<7,3,AP_RND,AP_SAT_SYM>(value);
        case 9: return (out_T) ap_fixed<1,1,AP_RND,AP_SAT_SYM>(value);
        default: return (out_T) value;
        }
    }

    template <class in_T, class out_T>
    static out_T cast(in_T value, unsigned index) {
        #pragma HLS INLINE
        if (index >= 1024) {
            return (out_T) value;
        }
        return cast_by_format<in_T, out_T>(value, format_id(index));
    }
};

struct q_dense_iq_cast {
    static unsigned char format_id(unsigned index) {
        #pragma HLS INLINE
        static const unsigned char formats[1176] = {
        0, 1, 1, 0, 0, 1, 1, 0, 2, 2, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 2, 1, 1, 0,
        0, 1, 1, 2, 2, 2, 0, 0, 1, 1, 0, 2, 2, 0, 0, 1, 1, 0, 2, 1, 0, 0, 1, 1, 2, 1, 1, 0, 0, 1, 1, 0,
        2, 1, 2, 0, 1, 1, 2, 2, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 2, 1, 1, 0, 0, 1, 1, 0, 2, 1, 0, 0,
        1, 1, 2, 0, 1, 0, 0, 1, 1, 2, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 2, 2, 1, 0, 0, 1, 1, 0, 1,
        1, 2, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 2, 1, 0, 2, 1, 1, 0, 1, 2, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1,
        1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 2, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 2, 1, 0, 0, 1, 2, 0, 1, 1,
        0, 0, 1, 1, 2, 2, 1, 0, 0, 1, 1, 2, 2, 1, 0, 0, 1, 1, 2, 2, 2, 0, 0, 1, 1, 2, 1, 1, 2, 0, 1, 1,
        2, 0, 0, 0, 0, 3, 4, 2, 4, 0, 0, 0, 4, 5, 4, 5, 0, 0, 0, 6, 1, 2, 0, 0, 0, 5, 1, 1, 4, 7, 7, 4,
        7, 1, 7, 4, 8, 7, 4, 7, 4, 7, 0, 7, 7, 4, 7, 4, 7, 0, 7, 7, 4, 7, 4, 7, 8, 7, 7, 9, 7, 7, 7, 8,
        7, 9, 9, 7, 7, 7, 8, 7, 7, 7, 7, 6, 7, 8, 7, 7, 7, 7, 7, 7, 8, 8, 7, 9, 7, 1, 8, 8, 8, 8, 7, 7,
        4, 8, 6, 8, 8, 7, 7, 1, 8, 9, 8, 8, 7, 7, 4, 8, 9, 6, 6, 8, 8, 8, 8, 9, 7, 6, 8, 8, 8, 7, 9, 7,
        6, 8, 8, 8, 7, 6, 4, 6, 8, 8, 8, 8, 9, 2, 1, 9, 7, 6, 4, 6, 2, 1, 9, 7, 6, 4, 9, 2, 1, 9, 6, 6,
        4, 9, 1, 1, 9, 6, 6, 4, 6, 2, 1, 6, 4, 4, 4, 6, 2, 1, 6, 4, 4, 5, 6, 2, 1, 6, 4, 4, 4, 6, 1, 1,
        6, 4, 4, 5, 4, 1, 1, 4, 2, 2, 2, 4, 1, 1, 4, 1, 0, 1, 4, 2, 2, 4, 2, 0, 1, 4, 1, 1, 4, 2, 1, 4,
        2, 1, 1, 2, 0, 1, 1, 2, 1, 2, 2, 0, 1, 1, 1, 1, 2, 2, 2, 1, 1, 2, 1, 1, 0, 0, 1, 1, 2, 1, 1, 2,
        0, 1, 1, 2, 2, 2, 0, 0, 1, 1, 2, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0,
        2, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 2, 1, 1, 2, 2, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0,
        1, 1, 2, 2, 2, 0, 0, 1, 1, 2, 2, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 2, 1, 0, 0, 1, 1, 0, 1,
        1, 0, 0, 1, 1, 0, 1, 1, 2, 2, 1, 4, 0, 2, 1, 0, 0, 1, 1, 2, 2, 1, 0, 0, 1, 1, 1, 2, 1, 0, 0, 1,
        1, 2, 1, 1, 0, 0, 1, 1, 0, 0, 2, 1, 0, 1, 1, 0, 1, 2, 0, 0, 1, 1, 2, 1, 1, 0, 0, 1, 1, 2, 1, 1,
        0, 0, 1, 1, 2, 1, 1, 0, 0, 1, 1, 2, 2, 1, 0, 0, 1, 4, 0, 2, 1, 0, 0, 1, 1, 2, 1, 1, 0, 0, 1, 1,
        2, 2, 1, 0, 0, 1, 1, 2, 1, 1, 2, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 2, 1, 0, 0, 1, 1, 0, 2, 1, 0,
        0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 2, 1, 1, 0, 0, 1, 1, 2, 1, 1, 2, 0, 1, 1, 0, 1, 2, 0, 0, 1, 1, 2,
        2, 2, 0, 0, 1, 1, 2, 2, 2, 2, 0, 1, 1, 0, 1, 1, 2, 0, 1, 4, 0, 1, 1, 0, 0, 1, 1, 2, 1, 1, 0, 0,
        1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 2, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 2, 1, 1, 1, 0, 1, 1, 0, 1,
        1, 0, 0, 1, 1, 2, 2, 1, 0, 0, 1, 1, 0, 2, 2, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1,
        1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 2, 1, 1, 0, 2, 1, 0, 0, 1, 4, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1,
        0, 0, 1, 1, 2, 0, 1, 0, 0, 1, 1, 2, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 2, 2, 0, 1, 1,
        2, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 2, 1, 0, 0, 1, 1, 0, 1, 1, 0,
        0, 1, 1, 0, 1, 2, 0, 0, 1, 1, 2, 1, 1, 2, 0, 1, 1, 1, 2, 1, 2, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0,
        1, 1, 0, 0, 1, 1, 2, 1, 1, 0, 0, 1, 1, 0, 2, 2, 0, 0, 1, 1, 2, 1, 1, 0, 0, 1, 1, 0, 2, 1, 2, 0,
        1, 1, 2, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 2, 1,
        1, 0, 0, 1, 1, 0, 2, 1, 0, 0, 1, 1, 2, 1, 1, 0, 0, 1, 1, 2, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1,
        1, 0, 2, 1, 0, 0, 1, 1, 0, 1, 1, 0, 2, 1, 1, 0, 2, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 2, 1, 1,
        2, 0, 1, 1, 2, 1, 1, 0, 0, 1, 1, 0, 1, 2, 0, 0, 1, 1, 2, 2, 1, 0, 0, 1, 1, 2, 1, 1, 0, 0, 1, 1,
        0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 2, 1, 1, 0, 0, 1, 1, 2, 1, 1, 0,
        0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 2, 1, 2, 2, 1, 1, 0, 1, 1, 0, 2, 1, 1
        };
        #pragma HLS ARRAY_PARTITION variable=formats cyclic factor=7 dim=1
        return formats[index];
    }

    template <class in_T, class out_T>
    static out_T cast_by_format(in_T value, unsigned char format) {
        #pragma HLS INLINE
        switch (format) {
        case 0: return (out_T) ap_fixed<1,1,AP_RND,AP_SAT_SYM>(value);
        case 1: return (out_T) ap_fixed<3,1,AP_RND,AP_SAT_SYM>(value);
        case 2: return (out_T) ap_fixed<2,1,AP_RND,AP_SAT_SYM>(value);
        case 3: return (out_T) ap_fixed<4,1,AP_RND,AP_SAT_SYM>(value);
        case 4: return (out_T) ap_fixed<4,2,AP_RND,AP_SAT_SYM>(value);
        case 5: return (out_T) ap_fixed<3,2,AP_RND,AP_SAT_SYM>(value);
        case 6: return (out_T) ap_fixed<5,2,AP_RND,AP_SAT_SYM>(value);
        case 7: return (out_T) ap_fixed<6,3,AP_RND,AP_SAT_SYM>(value);
        case 8: return (out_T) ap_fixed<7,3,AP_RND,AP_SAT_SYM>(value);
        case 9: return (out_T) ap_fixed<6,2,AP_RND,AP_SAT_SYM>(value);
        default: return (out_T) value;
        }
    }

    template <class in_T, class out_T>
    static out_T cast(in_T value, unsigned index) {
        #pragma HLS INLINE
        if (index >= 1176) {
            return (out_T) value;
        }
        return cast_by_format<in_T, out_T>(value, format_id(index));
    }
};

} // namespace nnet

#endif
