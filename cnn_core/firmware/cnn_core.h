#ifndef CNN_CORE_H_
#define CNN_CORE_H_

#include "ap_fixed.h"
#include "ap_int.h"
#include "hls_stream.h"

#include "defines.h"

void cnn_core(
    hls::stream<waveform_x8_t> &waveform,
    hls::stream<result_t> &layer9_out
);

#endif
