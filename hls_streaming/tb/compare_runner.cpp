#include <fstream>
#include <iostream>
#include <map>
#include <string>
#include <vector>

#include "firmware/cnn_core.h"
#include "firmware/nnet_utils/nnet_helpers.h"

namespace nnet {
bool trace_enabled = false;
std::map<std::string, void *> *trace_outputs = nullptr;
size_t trace_type_size = sizeof(double);
} // namespace nnet

static std::vector<float> make_input(unsigned sample) {
    std::vector<float> values;
    values.reserve(256 * 4);

    for (unsigned i = 0; i < 256 * 4; ++i) {
        const int centered = static_cast<int>((i + 17 * sample) % 31) - 15;
        values.push_back(static_cast<float>(centered) / 8.0f);
    }

    return values;
}

int main(int argc, char **argv) {
    const std::string output_path = argc > 1 ? argv[1] : "results.log";
    const unsigned num_samples = argc > 2 ? static_cast<unsigned>(std::stoul(argv[2])) : 8;

    std::ofstream fout(output_path);
    if (!fout.is_open()) {
        std::cerr << "ERROR: Unable to open output file: " << output_path << std::endl;
        return 1;
    }

    for (unsigned sample = 0; sample < num_samples; ++sample) {
        hls::stream<input_t> input_layer("input_layer");
        hls::stream<result_t> layer7_out("layer7_out");

        const std::vector<float> input = make_input(sample);
        nnet::copy_data<float, input_t, 0, 256 * 4>(input, input_layer);

        cnn_core(input_layer, layer7_out);
        nnet::print_result<result_t, 1>(layer7_out, fout);
    }

    return 0;
}
