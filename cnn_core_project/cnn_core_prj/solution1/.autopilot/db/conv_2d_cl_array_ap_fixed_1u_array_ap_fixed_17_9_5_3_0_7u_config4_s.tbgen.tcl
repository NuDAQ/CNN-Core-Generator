set moduleName conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_17_9_5_3_0_7u_config4_s
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set C_modelName {conv_2d_cl<array<ap_fixed,1u>,array<ap_fixed<17,9,5,3,0>,7u>,config4>}
set C_modelType { void 0 }
set C_modelArgList {
	{ layer11_out int 12 regular {fifo 0 volatile }  }
	{ layer4_out int 119 regular {fifo 1 volatile }  }
}
set hasAXIMCache 0
set AXIMCacheInstList { }
set C_modelArgMapList {[ 
	{ "Name" : "layer11_out", "interface" : "fifo", "bitwidth" : 12, "direction" : "READONLY"} , 
 	{ "Name" : "layer4_out", "interface" : "fifo", "bitwidth" : 119, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 20
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ start_full_n sc_in sc_logic 1 signal -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ layer11_out_dout sc_in sc_lv 12 signal 0 } 
	{ layer11_out_num_data_valid sc_in sc_lv 11 signal 0 } 
	{ layer11_out_fifo_cap sc_in sc_lv 11 signal 0 } 
	{ layer11_out_empty_n sc_in sc_logic 1 signal 0 } 
	{ layer11_out_read sc_out sc_logic 1 signal 0 } 
	{ start_out sc_out sc_logic 1 signal -1 } 
	{ start_write sc_out sc_logic 1 signal -1 } 
	{ layer4_out_din sc_out sc_lv 119 signal 1 } 
	{ layer4_out_num_data_valid sc_in sc_lv 10 signal 1 } 
	{ layer4_out_fifo_cap sc_in sc_lv 10 signal 1 } 
	{ layer4_out_full_n sc_in sc_logic 1 signal 1 } 
	{ layer4_out_write sc_out sc_logic 1 signal 1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "start_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "start_full_n", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "layer11_out_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "layer11_out", "role": "dout" }} , 
 	{ "name": "layer11_out_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "layer11_out", "role": "num_data_valid" }} , 
 	{ "name": "layer11_out_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "layer11_out", "role": "fifo_cap" }} , 
 	{ "name": "layer11_out_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layer11_out", "role": "empty_n" }} , 
 	{ "name": "layer11_out_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layer11_out", "role": "read" }} , 
 	{ "name": "start_out", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "start_out", "role": "default" }} , 
 	{ "name": "start_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "start_write", "role": "default" }} , 
 	{ "name": "layer4_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":119, "type": "signal", "bundle":{"name": "layer4_out", "role": "din" }} , 
 	{ "name": "layer4_out_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "layer4_out", "role": "num_data_valid" }} , 
 	{ "name": "layer4_out_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "layer4_out", "role": "fifo_cap" }} , 
 	{ "name": "layer4_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layer4_out", "role": "full_n" }} , 
 	{ "name": "layer4_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layer4_out", "role": "write" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "28"],
		"CDFG" : "conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_17_9_5_3_0_7u_config4_s",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "1",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "3075", "EstimateLatencyMax" : "3075",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "layer11_out", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "1024", "DependentChanType" : "0",
				"BlockSignal" : [
					{"Name" : "layer11_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "layer4_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "336", "DependentChanType" : "0",
				"BlockSignal" : [
					{"Name" : "layer4_out_blk_n", "Type" : "RtlSignal"}],
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60", "Port" : "layer4_out", "Inst_start_state" : "2", "Inst_end_state" : "5"}]},
			{"Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_3", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60", "Port" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_3", "Inst_start_state" : "2", "Inst_end_state" : "5"}]},
			{"Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_2", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60", "Port" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_2", "Inst_start_state" : "2", "Inst_end_state" : "5"}]},
			{"Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_1", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60", "Port" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_1", "Inst_start_state" : "2", "Inst_end_state" : "5"}]},
			{"Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60", "Port" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data", "Inst_start_state" : "2", "Inst_end_state" : "5"}]},
			{"Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_4", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60", "Port" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_4", "Inst_start_state" : "2", "Inst_end_state" : "5"}]},
			{"Name" : "sX_1", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60", "Port" : "sX_1", "Inst_start_state" : "2", "Inst_end_state" : "5"}]},
			{"Name" : "pX_1", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60", "Port" : "pX_1", "Inst_start_state" : "2", "Inst_end_state" : "5"}]}],
		"SubInstanceBlock" : [
			{"SubInstance" : "grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60", "SubBlockPort" : ["layer4_out_blk_n"]}],
		"Loop" : [
			{"Name" : "ReadInputHeight_ReadInputWidth", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "3", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage1", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage1_subdone", "QuitState" : "ap_ST_fsm_pp0_stage1", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage1_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "1"}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60", "Parent" : "0", "Child" : ["2"],
		"CDFG" : "compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Aligned", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "3",
		"VariableLatency" : "0", "ExactLatency" : "3", "EstimateLatencyMin" : "3", "EstimateLatencyMax" : "3",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "1",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "in_elem_0_0_0_0_0_val", "Type" : "None", "Direction" : "I"},
			{"Name" : "layer4_out", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "layer4_out_blk_n", "Type" : "RtlPort"}]},
			{"Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_3", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76", "Port" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_3"}]},
			{"Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_2", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76", "Port" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_2"}]},
			{"Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_1", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76", "Port" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_1"}]},
			{"Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76", "Port" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data"}]},
			{"Name" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_4", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76", "Port" : "void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_4"}]},
			{"Name" : "sX_1", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "pX_1", "Type" : "OVld", "Direction" : "IO"}]},
	{"ID" : "2", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76", "Parent" : "1", "Child" : ["3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27"],
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
	{"ID" : "3", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_8ns_20_1_0_U2316", "Parent" : "2"},
	{"ID" : "4", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_7ns_19_1_0_U2317", "Parent" : "2"},
	{"ID" : "5", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_7s_19_1_0_U2318", "Parent" : "2"},
	{"ID" : "6", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_7ns_19_1_0_U2319", "Parent" : "2"},
	{"ID" : "7", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_7ns_19_1_0_U2320", "Parent" : "2"},
	{"ID" : "8", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_9ns_20_1_0_U2321", "Parent" : "2"},
	{"ID" : "9", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_8s_20_1_0_U2322", "Parent" : "2"},
	{"ID" : "10", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_8ns_20_1_0_U2323", "Parent" : "2"},
	{"ID" : "11", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_9ns_20_1_0_U2324", "Parent" : "2"},
	{"ID" : "12", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_8s_20_1_0_U2325", "Parent" : "2"},
	{"ID" : "13", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_8s_20_1_0_U2326", "Parent" : "2"},
	{"ID" : "14", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_9s_20_1_0_U2327", "Parent" : "2"},
	{"ID" : "15", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_8s_20_1_0_U2328", "Parent" : "2"},
	{"ID" : "16", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_8ns_20_1_0_U2329", "Parent" : "2"},
	{"ID" : "17", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_8s_20_1_0_U2330", "Parent" : "2"},
	{"ID" : "18", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_8s_20_1_0_U2331", "Parent" : "2"},
	{"ID" : "19", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_9ns_20_1_0_U2332", "Parent" : "2"},
	{"ID" : "20", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_6s_18_1_0_U2333", "Parent" : "2"},
	{"ID" : "21", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_8ns_20_1_0_U2334", "Parent" : "2"},
	{"ID" : "22", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_6s_18_1_0_U2335", "Parent" : "2"},
	{"ID" : "23", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_7ns_19_1_0_U2336", "Parent" : "2"},
	{"ID" : "24", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_8ns_20_1_0_U2337", "Parent" : "2"},
	{"ID" : "25", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_8ns_20_1_0_U2338", "Parent" : "2"},
	{"ID" : "26", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_7s_19_1_0_U2339", "Parent" : "2"},
	{"ID" : "27", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60.grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76.mul_12s_8s_20_1_0_U2340", "Parent" : "2"},
	{"ID" : "28", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.flow_control_loop_pipe_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_17_9_5_3_0_7u_config4_s {
		layer11_out {Type I LastRead 1 FirstWrite -1}
		layer4_out {Type O LastRead -1 FirstWrite 3}
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_3 {Type IO LastRead -1 FirstWrite -1}
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_2 {Type IO LastRead -1 FirstWrite -1}
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_1 {Type IO LastRead -1 FirstWrite -1}
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data {Type IO LastRead -1 FirstWrite -1}
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_4 {Type IO LastRead -1 FirstWrite -1}
		sX_1 {Type IO LastRead -1 FirstWrite -1}
		pX_1 {Type IO LastRead -1 FirstWrite -1}}
	compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s {
		in_elem_0_0_0_0_0_val {Type I LastRead 0 FirstWrite -1}
		layer4_out {Type O LastRead -1 FirstWrite 3}
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_3 {Type IO LastRead -1 FirstWrite -1}
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_2 {Type IO LastRead -1 FirstWrite -1}
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_1 {Type IO LastRead -1 FirstWrite -1}
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data {Type IO LastRead -1 FirstWrite -1}
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_4 {Type IO LastRead -1 FirstWrite -1}
		sX_1 {Type IO LastRead -1 FirstWrite -1}
		pX_1 {Type IO LastRead -1 FirstWrite -1}}
	dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s {
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_4 {Type I LastRead 0 FirstWrite -1}
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_3 {Type I LastRead 1 FirstWrite -1}
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_2 {Type I LastRead 0 FirstWrite -1}
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_1 {Type I LastRead 0 FirstWrite -1}
		void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "3075", "Max" : "3075"}
	, {"Name" : "Interval", "Min" : "3075", "Max" : "3075"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	layer11_out { ap_fifo {  { layer11_out_dout fifo_data_in 0 12 }  { layer11_out_num_data_valid fifo_status_num_data_valid 0 11 }  { layer11_out_fifo_cap fifo_update 0 11 }  { layer11_out_empty_n fifo_status 0 1 }  { layer11_out_read fifo_port_we 1 1 } } }
	layer4_out { ap_fifo {  { layer4_out_din fifo_data_in 1 119 }  { layer4_out_num_data_valid fifo_status_num_data_valid 0 10 }  { layer4_out_fifo_cap fifo_update 0 10 }  { layer4_out_full_n fifo_status 0 1 }  { layer4_out_write fifo_port_we 1 1 } } }
}
