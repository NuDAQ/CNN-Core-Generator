CXX ?= g++
CXXFLAGS ?= -std=c++14 -O2

REPO_ROOT := ..
BASELINE_ROOT := $(REPO_ROOT)/cnn_core_project
STREAMING_ROOT := .
BUILD_DIR := build
RUN_DIR := $(BUILD_DIR)/run
TB_SRC := tb/compare_runner.cpp

BASELINE_EXE := $(BUILD_DIR)/baseline_runner
STREAMING_EXE := $(BUILD_DIR)/streaming_runner
BASELINE_OUT := $(RUN_DIR)/baseline_results.log
STREAMING_OUT := $(RUN_DIR)/streaming_results.log

.PHONY: all compare clean prepare

all: compare

$(BASELINE_EXE): $(TB_SRC) $(BASELINE_ROOT)/firmware/cnn_core.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -I$(BASELINE_ROOT) -I$(BASELINE_ROOT)/firmware -I$(BASELINE_ROOT)/firmware/ap_types $^ -o $@

$(STREAMING_EXE): $(TB_SRC) $(STREAMING_ROOT)/firmware/cnn_core.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -I$(STREAMING_ROOT) -I$(STREAMING_ROOT)/firmware -I$(STREAMING_ROOT)/firmware/ap_types $^ -o $@

prepare:
	mkdir -p $(RUN_DIR)
	cp $(BASELINE_ROOT)/firmware/weights/*.txt $(RUN_DIR)/

compare: $(BASELINE_EXE) $(STREAMING_EXE) prepare
	cd $(RUN_DIR) && ../baseline_runner baseline_results.log 8
	cd $(RUN_DIR) && ../streaming_runner streaming_results.log 8
	cmp -s $(BASELINE_OUT) $(STREAMING_OUT)
	@echo "PASS: baseline and hls_streaming C++ outputs match exactly."

clean:
	rm -rf $(BUILD_DIR)
