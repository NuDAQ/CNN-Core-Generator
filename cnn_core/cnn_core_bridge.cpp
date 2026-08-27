#ifndef CNN_CORE_BRIDGE_H_
#define CNN_CORE_BRIDGE_H_

#include "firmware/cnn_core.h"
#include "firmware/nnet_utils/nnet_helpers.h"
#include <cstdlib>
#include <map>
#include <string>

namespace nnet {
bool trace_enabled = false;
std::map<std::string, void *> *trace_outputs = NULL;
size_t trace_type_size = sizeof(double);
} // namespace nnet

template <typename scalar_T>
void pack_aria_input(scalar_T *logical_input, hls::stream<waveform_x8_t> &packed_input) {
    for (unsigned word_index = 0; word_index < 32; word_index++) {
        waveform_x8_t word;
        for (unsigned row = 0; row < 8; row++) {
            for (unsigned channel = 0; channel < 4; channel++) {
                word[row * 4 + channel] = logical_input[(word_index * 8 + row) * 4 + channel];
            }
        }
        packed_input.write(word);
    }
}

extern "C" {

struct trace_data {
    const char *name;
    void *data;
};

void allocate_trace_storage(size_t element_size) {
    nnet::trace_enabled = true;
    nnet::trace_outputs = new std::map<std::string, void *>;
    nnet::trace_type_size = element_size;
}

void free_trace_storage() {
    if (nnet::trace_outputs == NULL) {
        return;
    }
    for (std::map<std::string, void *>::iterator item = nnet::trace_outputs->begin();
         item != nnet::trace_outputs->end(); item++) {
        free(item->second);
    }
    delete nnet::trace_outputs;
    nnet::trace_outputs = NULL;
    nnet::trace_enabled = false;
}

void collect_trace_output(struct trace_data *outputs) {
    int index = 0;
    for (std::map<std::string, void *>::iterator item = nnet::trace_outputs->begin();
         item != nnet::trace_outputs->end(); item++) {
        outputs[index].name = item->first.c_str();
        outputs[index].data = item->second;
        index++;
    }
}

void cnn_core_float(float *waveform, float *layer9_out) {
    hls::stream<waveform_x8_t> waveform_ap("waveform");
    pack_aria_input(waveform, waveform_ap);
    hls::stream<result_t> layer9_out_ap("layer9_out");
    cnn_core(waveform_ap, layer9_out_ap);
    nnet::convert_data<result_t, float, 1>(layer9_out_ap, layer9_out);
}

void cnn_core_double(double *waveform, double *layer9_out) {
    hls::stream<waveform_x8_t> waveform_ap("waveform");
    pack_aria_input(waveform, waveform_ap);
    hls::stream<result_t> layer9_out_ap("layer9_out");
    cnn_core(waveform_ap, layer9_out_ap);
    nnet::convert_data<result_t, double, 1>(layer9_out_ap, layer9_out);
}

} // extern "C"

#endif
