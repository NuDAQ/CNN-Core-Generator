set moduleName dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s
set isTopModule 0
set isCombinational 0
set isDatapathOnly 1
set isPipelined 1
set pipeline_type function
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set C_modelName {dense_latency<ap_fixed<12, 6, 5, 3, 0>, ap_fixed<17, 9, 5, 3, 0>, config4_mult>}
set C_modelType { int 119 }
set C_modelArgList {
	{ void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_4 int 12 regular {pointer 0} {global 0}  }
	{ void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_3 int 12 regular {pointer 0} {global 0}  }
	{ void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_2 int 12 regular {pointer 0} {global 0}  }
	{ void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_1 int 12 regular {pointer 0} {global 0}  }
	{ void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data int 12 regular {pointer 0} {global 0}  }
}
set hasAXIMCache 0
set AXIMCacheInstList { }
set C_modelArgMapList {[ 
	{ "Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_4", "interface" : "wire", "bitwidth" : 12, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_3", "interface" : "wire", "bitwidth" : 12, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_2", "interface" : "wire", "bitwidth" : 12, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_1", "interface" : "wire", "bitwidth" : 12, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data", "interface" : "wire", "bitwidth" : 12, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "ap_return", "interface" : "wire", "bitwidth" : 119} ]}
# RTL Port declarations: 
set portNum 15
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_4 sc_in sc_lv 12 signal 0 } 
	{ void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_3 sc_in sc_lv 12 signal 1 } 
	{ void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_2 sc_in sc_lv 12 signal 2 } 
	{ void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_1 sc_in sc_lv 12 signal 3 } 
	{ void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data sc_in sc_lv 12 signal 4 } 
	{ ap_return_0 sc_out sc_lv 17 signal -1 } 
	{ ap_return_1 sc_out sc_lv 17 signal -1 } 
	{ ap_return_2 sc_out sc_lv 17 signal -1 } 
	{ ap_return_3 sc_out sc_lv 17 signal -1 } 
	{ ap_return_4 sc_out sc_lv 17 signal -1 } 
	{ ap_return_5 sc_out sc_lv 17 signal -1 } 
	{ ap_return_6 sc_out sc_lv 17 signal -1 } 
	{ ap_ce sc_in sc_logic 1 ce -1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_4", "direction": "in", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_4", "role": "default" }} , 
 	{ "name": "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_3", "direction": "in", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_3", "role": "default" }} , 
 	{ "name": "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_2", "direction": "in", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_2", "role": "default" }} , 
 	{ "name": "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_1", "direction": "in", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_1", "role": "default" }} , 
 	{ "name": "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data", "direction": "in", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data", "role": "default" }} , 
 	{ "name": "ap_return_0", "direction": "out", "datatype": "sc_lv", "bitwidth":17, "type": "signal", "bundle":{"name": "ap_return_0", "role": "default" }} , 
 	{ "name": "ap_return_1", "direction": "out", "datatype": "sc_lv", "bitwidth":17, "type": "signal", "bundle":{"name": "ap_return_1", "role": "default" }} , 
 	{ "name": "ap_return_2", "direction": "out", "datatype": "sc_lv", "bitwidth":17, "type": "signal", "bundle":{"name": "ap_return_2", "role": "default" }} , 
 	{ "name": "ap_return_3", "direction": "out", "datatype": "sc_lv", "bitwidth":17, "type": "signal", "bundle":{"name": "ap_return_3", "role": "default" }} , 
 	{ "name": "ap_return_4", "direction": "out", "datatype": "sc_lv", "bitwidth":17, "type": "signal", "bundle":{"name": "ap_return_4", "role": "default" }} , 
 	{ "name": "ap_return_5", "direction": "out", "datatype": "sc_lv", "bitwidth":17, "type": "signal", "bundle":{"name": "ap_return_5", "role": "default" }} , 
 	{ "name": "ap_return_6", "direction": "out", "datatype": "sc_lv", "bitwidth":17, "type": "signal", "bundle":{"name": "ap_return_6", "role": "default" }} , 
 	{ "name": "ap_ce", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "ce", "bundle":{"name": "ap_ce", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25"],
		"CDFG" : "dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "0", "ap_start" : "0", "ap_ready" : "0", "ap_done" : "0", "ap_continue" : "0", "ap_idle" : "0", "real_start" : "0",
		"Pipeline" : "Aligned", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "1",
		"VariableLatency" : "0", "ExactLatency" : "1", "EstimateLatencyMin" : "1", "EstimateLatencyMax" : "1",
		"Combinational" : "0",
		"Datapath" : "1",
		"ClockEnable" : "1",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_4", "Type" : "None", "Direction" : "I"},
			{"Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_3", "Type" : "None", "Direction" : "I"},
			{"Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_2", "Type" : "None", "Direction" : "I"},
			{"Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_1", "Type" : "None", "Direction" : "I"},
			{"Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_8ns_20_1_0_U2316", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_7ns_19_1_0_U2317", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_7s_19_1_0_U2318", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_7ns_19_1_0_U2319", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_7ns_19_1_0_U2320", "Parent" : "0"},
	{"ID" : "6", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_9ns_20_1_0_U2321", "Parent" : "0"},
	{"ID" : "7", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_8s_20_1_0_U2322", "Parent" : "0"},
	{"ID" : "8", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_8ns_20_1_0_U2323", "Parent" : "0"},
	{"ID" : "9", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_9ns_20_1_0_U2324", "Parent" : "0"},
	{"ID" : "10", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_8s_20_1_0_U2325", "Parent" : "0"},
	{"ID" : "11", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_8s_20_1_0_U2326", "Parent" : "0"},
	{"ID" : "12", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_9s_20_1_0_U2327", "Parent" : "0"},
	{"ID" : "13", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_8s_20_1_0_U2328", "Parent" : "0"},
	{"ID" : "14", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_8ns_20_1_0_U2329", "Parent" : "0"},
	{"ID" : "15", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_8s_20_1_0_U2330", "Parent" : "0"},
	{"ID" : "16", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_8s_20_1_0_U2331", "Parent" : "0"},
	{"ID" : "17", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_9ns_20_1_0_U2332", "Parent" : "0"},
	{"ID" : "18", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_6s_18_1_0_U2333", "Parent" : "0"},
	{"ID" : "19", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_8ns_20_1_0_U2334", "Parent" : "0"},
	{"ID" : "20", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_6s_18_1_0_U2335", "Parent" : "0"},
	{"ID" : "21", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_7ns_19_1_0_U2336", "Parent" : "0"},
	{"ID" : "22", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_8ns_20_1_0_U2337", "Parent" : "0"},
	{"ID" : "23", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_8ns_20_1_0_U2338", "Parent" : "0"},
	{"ID" : "24", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_7s_19_1_0_U2339", "Parent" : "0"},
	{"ID" : "25", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_12s_8s_20_1_0_U2340", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s {
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_4 {Type I LastRead 0 FirstWrite -1}
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_3 {Type I LastRead 1 FirstWrite -1}
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_2 {Type I LastRead 0 FirstWrite -1}
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_1 {Type I LastRead 0 FirstWrite -1}
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "1", "Max" : "1"}
	, {"Name" : "Interval", "Min" : "1", "Max" : "1"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_4 { ap_none {  { void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_4 in_data 0 12 } } }
	void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_3 { ap_none {  { void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_3 in_data 0 12 } } }
	void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_2 { ap_none {  { void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_2 in_data 0 12 } } }
	void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_1 { ap_none {  { void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_1 in_data 0 12 } } }
	void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data { ap_none {  { void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data in_data 0 12 } } }
}
