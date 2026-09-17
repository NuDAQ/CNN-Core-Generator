#ifndef RAVEL_BRIDGES_H_
#define RAVEL_BRIDGES_H_
#include "hls_stream.h"
namespace ravel {
template<class IN, class OUT, unsigned COUNT, unsigned LANES>
void repack(hls::stream<IN>& input, hls::stream<OUT>& output) {
    typedef typename IN::value_type input_value;
    typedef typename OUT::value_type output_value;
    static_assert(input_value::width == output_value::width, "Bridge must preserve scalar bits");
    IN incoming;
    OUT outgoing;
    #pragma HLS ARRAY_PARTITION variable=incoming complete dim=0
    #pragma HLS ARRAY_PARTITION variable=outgoing complete dim=0
    static_assert(LANES > 0 && IN::size % LANES == 0 && OUT::size % LANES == 0, "Invalid bridge lane schedule");
BridgeCodes:
    for (unsigned i = 0; i < COUNT; i += LANES) {
        #pragma HLS PIPELINE II=1
        if (i % IN::size == 0) incoming = input.read();
        if (i % OUT::size == 0) {
            for (unsigned lane = 0; lane < OUT::size; ++lane) {
                #pragma HLS UNROLL
                outgoing[lane] = 0;
            }
        }
        for (unsigned lane = 0; lane < LANES; ++lane) {
            #pragma HLS UNROLL
            if (i + lane < COUNT)
                outgoing[(i + lane) % OUT::size].range(input_value::width - 1, 0) = incoming[(i + lane) % IN::size].range(input_value::width - 1, 0);
        }
        if ((i + LANES) % OUT::size == 0 || i + LANES >= COUNT) output.write(outgoing);
    }
}
}
#endif
