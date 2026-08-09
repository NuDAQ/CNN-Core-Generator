#include <cstring>
#include <fstream>
#include <iostream>
#include <map>
#include <string>
#include <vector>

#include "firmware/cnn_core_prj.h"
#include "firmware/nnet_utils/nnet_helpers.h"

namespace nnet {
bool trace_enabled = true;
std::map<std::string, void *> *trace_outputs = NULL;
size_t trace_type_size = sizeof(double);
} // namespace nnet

void pack_aria_test_input(
    const std::vector<float> &logical_input,
    hls::stream<input_layer_x2_t> &packed_input
) {
    for (unsigned pair = 0; pair < 128; pair++) {
        input_layer_x2_t word;
        for (unsigned row = 0; row < 2; row++) {
            for (unsigned channel = 0; channel < 4; channel++) {
                word[row * 4 + channel] = logical_input[(pair * 2 + row) * 4 + channel];
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
        if (input.size() != 256 * 4) {
            std::cerr << "Expected 1024 input values, received " << input.size() << std::endl;
            return 2;
        }
        hls::stream<input_layer_x2_t> input_layer("input_layer");
        hls::stream<result_t> layer9_out("layer9_out");
        pack_aria_test_input(input, input_layer);
        cnn_core_prj(input_layer, layer9_out);
        nnet::print_result<result_t, 1>(layer9_out, results);
        sample++;
    }

    if (sample == 0) {
        std::vector<float> zero_input(256 * 4, 0.0f);
        hls::stream<input_layer_x2_t> input_layer("input_layer");
        hls::stream<result_t> layer9_out("layer9_out");
        pack_aria_test_input(zero_input, input_layer);
        cnn_core_prj(input_layer, layer9_out);
        nnet::print_result<result_t, 1>(layer9_out, results);
    }
    std::cout << "INFO: Saved inference results to file: " << results_path << std::endl;
    return 0;
}
