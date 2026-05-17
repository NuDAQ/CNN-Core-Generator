CXX ?= g++
CXXFLAGS ?= -std=c++14 -O2
SAMPLES ?= 8
ALLOW_MISMATCH ?= 0

REPO_ROOT := ..
BASELINE_ROOT := $(REPO_ROOT)/cnn_core_project
STREAMING_ROOT := .
BUILD_DIR := build
RUN_DIR := $(BUILD_DIR)/run
BASELINE_AP_TYPES := $(BUILD_DIR)/baseline_ap_types
STREAMING_AP_TYPES := $(BUILD_DIR)/streaming_ap_types
TB_SRC := tb/compare_runner.cpp

BASELINE_EXE := $(BUILD_DIR)/baseline_runner
STREAMING_EXE := $(BUILD_DIR)/streaming_runner
BASELINE_OUT := $(RUN_DIR)/baseline_results.log
STREAMING_OUT := $(RUN_DIR)/streaming_results.log

.PHONY: all compare compare-long run-streaming clean prepare prepare-compat

all: compare

prepare-compat:
	mkdir -p $(BUILD_DIR)
	rm -rf $(BASELINE_AP_TYPES) $(STREAMING_AP_TYPES)
	cp -R $(BASELINE_ROOT)/firmware/ap_types $(BASELINE_AP_TYPES)
	cp -R $(STREAMING_ROOT)/firmware/ap_types $(STREAMING_AP_TYPES)
	perl -0pi -e 's|// FIXME AP_AUTOCC cannot handle many standard headers, so declare instead of\n// include\.\n// \#include <complex>\nnamespace std \{\ntemplate<typename _Tp> class complex;\n\}\n|#include <complex>\n|g' $(BASELINE_AP_TYPES)/ap_int_special.h $(BASELINE_AP_TYPES)/ap_fixed_special.h $(STREAMING_AP_TYPES)/ap_int_special.h $(STREAMING_AP_TYPES)/ap_fixed_special.h

$(BASELINE_EXE): $(TB_SRC) $(BASELINE_ROOT)/firmware/cnn_core.cpp prepare-compat
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -I$(BASELINE_AP_TYPES) -I$(BASELINE_ROOT) -I$(BASELINE_ROOT)/firmware $< $(BASELINE_ROOT)/firmware/cnn_core.cpp -o $@

$(STREAMING_EXE): $(TB_SRC) $(STREAMING_ROOT)/firmware/cnn_core.cpp prepare-compat
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -I$(STREAMING_AP_TYPES) -I$(STREAMING_ROOT) -I$(STREAMING_ROOT)/firmware $< $(STREAMING_ROOT)/firmware/cnn_core.cpp -o $@

prepare:
	mkdir -p $(RUN_DIR)
	rm -rf $(RUN_DIR)/weights
	cp -R $(BASELINE_ROOT)/firmware/weights $(RUN_DIR)/weights

compare: $(BASELINE_EXE) $(STREAMING_EXE) prepare
	cd $(RUN_DIR) && ../baseline_runner baseline_results.log $(SAMPLES)
	cd $(RUN_DIR) && ../streaming_runner streaming_results.log $(SAMPLES)
	@if cmp -s $(BASELINE_OUT) $(STREAMING_OUT); then \
		echo "PASS: baseline and hls_streaming C++ outputs match exactly."; \
	elif [ "$(ALLOW_MISMATCH)" = "1" ]; then \
		echo "WARN: baseline and hls_streaming outputs differ; continuing because ALLOW_MISMATCH=1."; \
	else \
		echo "FAIL: baseline and hls_streaming outputs differ. Use ALLOW_MISMATCH=1 for intentional architecture/model changes."; \
		exit 1; \
	fi

compare-long:
	$(MAKE) compare SAMPLES=128

run-streaming: $(STREAMING_EXE) prepare
	cd $(RUN_DIR) && ../streaming_runner streaming_results.log $(SAMPLES)

clean:
	rm -rf $(BUILD_DIR)
