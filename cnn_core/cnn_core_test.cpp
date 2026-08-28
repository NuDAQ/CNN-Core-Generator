#include <cstring>
#include <fstream>
#include <iostream>
#include <map>
#include <string>
#include <vector>

#include "firmware/cnn_core.h"
#include "firmware/nnet_utils/nnet_helpers.h"

namespace nnet {
bool trace_enabled = true;
std::map<std::string, void *> *trace_outputs = NULL;
size_t trace_type_size = sizeof(double);
} // namespace nnet

void pack_aria_test_input(
    const std::vector<float> &logical_input,
    hls::stream<waveform_x8_t> &packed_input
) {
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

int main() {
    std::ifstream input_file("tb_data/tb_input_features.dat");
#ifdef RTL_SIM
    const char *results_path = "tb_data/rtl_cosim_results.log";
#else
    const char *results_path = "tb_data/csim_results.log";
#endif
    std::ofstream results(results_path);
    std::string line;
    unsigned sample = 0;
    while (std::getline(input_file, line)) {
        std::vector<float> input;
        char *text = const_cast<char *>(line.c_str());
        for (char *token = std::strtok(text, " "); token != NULL; token = std::strtok(NULL, " ")) {
            input.push_back(std::atof(token));
        }
        if (input.size() != 1024) {
            std::cerr << "Expected 1024 input values, received " << input.size() << std::endl;
            return 2;
        }
        hls::stream<waveform_x8_t> waveform("waveform");
        hls::stream<result_t> layer9_out("layer9_out");
        pack_aria_test_input(input, waveform);
        cnn_core(waveform, layer9_out);
        nnet::print_result<result_t, 1>(layer9_out, results);
        sample++;
    }

    if (sample == 0) {
        for (unsigned default_sample = 0; default_sample < 3; default_sample++) {
            std::vector<float> default_input(1024, 0.0f);
            for (unsigned index = 0; index < default_input.size(); index++) {
                if (default_sample == 1) {
                    default_input[index] = 1.0f;
                } else if (default_sample == 2) {
                    const int code = static_cast<int>(index % 65) - 32;
                    default_input[index] = static_cast<float>(code) / 32.0f;
                }
            }
            hls::stream<waveform_x8_t> waveform("waveform");
            hls::stream<result_t> layer9_out("layer9_out");
            pack_aria_test_input(default_input, waveform);
            cnn_core(waveform, layer9_out);
            nnet::print_result<result_t, 1>(layer9_out, results);
        }
    }
    std::cout << "INFO: Saved inference results to file: " << results_path << std::endl;
    return 0;
}
