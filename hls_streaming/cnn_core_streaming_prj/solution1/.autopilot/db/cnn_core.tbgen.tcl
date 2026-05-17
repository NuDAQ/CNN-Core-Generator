set moduleName cnn_core
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type dataflow
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set C_modelName {cnn_core}
set C_modelType { void 0 }
set C_modelArgList {
	{ input_layer int 64 regular {axi_s 0 volatile  { input_layer Data } }  }
	{ layer7_out int 16 regular {axi_s 1 volatile  { layer7_out Data } }  }
}
set hasAXIMCache 0
set AXIMCacheInstList { }
set C_modelArgMapList {[ 
	{ "Name" : "input_layer", "interface" : "axis", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "layer7_out", "interface" : "axis", "bitwidth" : 16, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 12
set portList { 
	{ input_layer_TDATA sc_in sc_lv 64 signal 0 } 
	{ layer7_out_TDATA sc_out sc_lv 16 signal 1 } 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ input_layer_TVALID sc_in sc_logic 1 invld 0 } 
	{ input_layer_TREADY sc_out sc_logic 1 inacc 0 } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ layer7_out_TVALID sc_out sc_logic 1 outvld 1 } 
	{ layer7_out_TREADY sc_in sc_logic 1 outacc 1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
}
set NewPortList {[ 
	{ "name": "input_layer_TDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "input_layer", "role": "TDATA" }} , 
 	{ "name": "layer7_out_TDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "layer7_out", "role": "TDATA" }} , 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst_n", "role": "default" }} , 
 	{ "name": "input_layer_TVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "input_layer", "role": "TVALID" }} , 
 	{ "name": "input_layer_TREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "inacc", "bundle":{"name": "input_layer", "role": "TREADY" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "layer7_out_TVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "layer7_out", "role": "TVALID" }} , 
 	{ "name": "layer7_out_TREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "outacc", "bundle":{"name": "layer7_out", "role": "TREADY" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "28", "30", "32", "57", "58", "59", "60", "61", "62"],
		"CDFG" : "cnn_core",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "263", "EstimateLatencyMax" : "263",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"InputProcess" : [
			{"ID" : "1", "Name" : "first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0"}],
		"OutputProcess" : [
			{"ID" : "32", "Name" : "dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0"}],
		"Port" : [
			{"Name" : "input_layer", "Type" : "Axis", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0", "Port" : "input_layer"}]},
			{"Name" : "layer7_out", "Type" : "Axis", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "32", "SubInstance" : "dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0", "Port" : "layer7_out"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0", "Parent" : "0", "Child" : ["2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27"],
		"CDFG" : "first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_s",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "1",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "259", "EstimateLatencyMax" : "259",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "input_layer", "Type" : "Axis", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "input_layer_TDATA_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "layer3x4_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["28"], "DependentChan" : "57", "DependentChanDepth" : "4", "DependentChanType" : "0",
				"BlockSignal" : [
					{"Name" : "layer3x4_out_blk_n", "Type" : "RtlSignal"}]}],
		"Loop" : [
			{"Name" : "ReadInputHeightWide", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter2", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter2", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "1"}}]},
	{"ID" : "2", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.mul_12s_5ns_15_1_1_U1", "Parent" : "1"},
	{"ID" : "3", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.mul_12s_5ns_15_1_1_U2", "Parent" : "1"},
	{"ID" : "4", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.mul_12s_5ns_15_1_1_U3", "Parent" : "1"},
	{"ID" : "5", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.mul_12s_5ns_15_1_1_U4", "Parent" : "1"},
	{"ID" : "6", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U5", "Parent" : "1"},
	{"ID" : "7", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U6", "Parent" : "1"},
	{"ID" : "8", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U7", "Parent" : "1"},
	{"ID" : "9", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U8", "Parent" : "1"},
	{"ID" : "10", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U9", "Parent" : "1"},
	{"ID" : "11", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U10", "Parent" : "1"},
	{"ID" : "12", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U11", "Parent" : "1"},
	{"ID" : "13", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U12", "Parent" : "1"},
	{"ID" : "14", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U13", "Parent" : "1"},
	{"ID" : "15", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U14", "Parent" : "1"},
	{"ID" : "16", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U15", "Parent" : "1"},
	{"ID" : "17", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U16", "Parent" : "1"},
	{"ID" : "18", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U17", "Parent" : "1"},
	{"ID" : "19", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U18", "Parent" : "1"},
	{"ID" : "20", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U19", "Parent" : "1"},
	{"ID" : "21", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U20", "Parent" : "1"},
	{"ID" : "22", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U21", "Parent" : "1"},
	{"ID" : "23", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U22", "Parent" : "1"},
	{"ID" : "24", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U23", "Parent" : "1"},
	{"ID" : "25", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.sparsemux_11_3_12_1_1_U24", "Parent" : "1"},
	{"ID" : "26", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.flow_control_loop_pipe_U", "Parent" : "1"},
	{"ID" : "27", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0.regslice_both_input_layer_U", "Parent" : "1"},
	{"ID" : "28", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.relu_array_ap_fixed_28u_array_ap_fixed_16_6_5_3_0_28u_relu_config4_U0", "Parent" : "0", "Child" : ["29"],
		"CDFG" : "relu_array_ap_fixed_28u_array_ap_fixed_16_6_5_3_0_28u_relu_config4_s",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "1",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "87", "EstimateLatencyMax" : "87",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"StartSource" : "1",
		"StartFifo" : "start_for_relu_array_ap_fixed_28u_array_ap_fixed_16_6_5_3_0_28u_relu_config4_U0_U",
		"Port" : [
			{"Name" : "layer3x4_out", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["1"], "DependentChan" : "57", "DependentChanDepth" : "4", "DependentChanType" : "0",
				"BlockSignal" : [
					{"Name" : "layer3x4_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "layer4x4_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["30"], "DependentChan" : "58", "DependentChanDepth" : "4", "DependentChanType" : "0",
				"BlockSignal" : [
					{"Name" : "layer4x4_out_blk_n", "Type" : "RtlSignal"}]}],
		"Loop" : [
			{"Name" : "ReLUActLoop", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter2", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter2", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "1"}}]},
	{"ID" : "29", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.relu_array_ap_fixed_28u_array_ap_fixed_16_6_5_3_0_28u_relu_config4_U0.flow_control_loop_pipe_U", "Parent" : "28"},
	{"ID" : "30", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config5_U0", "Parent" : "0", "Child" : ["31"],
		"CDFG" : "maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config5_s",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "1",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "87", "EstimateLatencyMax" : "87",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"StartSource" : "28",
		"StartFifo" : "start_for_maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config5_U0_U",
		"Port" : [
			{"Name" : "layer4x4_out", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["28"], "DependentChan" : "58", "DependentChanDepth" : "4", "DependentChanType" : "0",
				"BlockSignal" : [
					{"Name" : "layer4x4_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "layer5x4_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["32"], "DependentChan" : "59", "DependentChanDepth" : "4", "DependentChanType" : "0",
				"BlockSignal" : [
					{"Name" : "layer5x4_out_blk_n", "Type" : "RtlSignal"}]}],
		"Loop" : [
			{"Name" : "PoolWideMain", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter2", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter2", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "1"}}]},
	{"ID" : "31", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config5_U0.flow_control_loop_pipe_U", "Parent" : "30"},
	{"ID" : "32", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0", "Parent" : "0", "Child" : ["33", "56"],
		"CDFG" : "dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_s",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "176", "EstimateLatencyMax" : "176",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"StartSource" : "30",
		"StartFifo" : "start_for_dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0_U",
		"Port" : [
			{"Name" : "layer5x4_out", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["30"], "DependentChan" : "59", "DependentChanDepth" : "4", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "33", "SubInstance" : "grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53", "Port" : "layer5x4_out", "Inst_start_state" : "1", "Inst_end_state" : "2"}]},
			{"Name" : "layer7_out", "Type" : "Axis", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "layer7_out_TDATA_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "33", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53", "Parent" : "32", "Child" : ["34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55"],
		"CDFG" : "dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "173", "EstimateLatencyMax" : "173",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "layer5x4_out", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "layer5x4_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "acc_out", "Type" : "Vld", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "DenseWideMain", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter4", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter4", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "34", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.sparsemux_2353_11_6_1_1_U34", "Parent" : "33"},
	{"ID" : "35", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.sparsemux_2353_11_6_1_1_U35", "Parent" : "33"},
	{"ID" : "36", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.sparsemux_2353_11_6_1_1_U36", "Parent" : "33"},
	{"ID" : "37", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.sparsemux_2353_11_6_1_1_U37", "Parent" : "33"},
	{"ID" : "38", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.sparsemux_2353_11_6_1_1_U38", "Parent" : "33"},
	{"ID" : "39", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.sparsemux_2353_11_6_1_1_U39", "Parent" : "33"},
	{"ID" : "40", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.sparsemux_2353_11_6_1_1_U40", "Parent" : "33"},
	{"ID" : "41", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.sparsemux_9_2_16_1_1_U41", "Parent" : "33"},
	{"ID" : "42", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.mul_16s_6s_20_1_1_U42", "Parent" : "33"},
	{"ID" : "43", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.sparsemux_9_2_16_1_1_U43", "Parent" : "33"},
	{"ID" : "44", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.mul_16s_6s_20_1_1_U44", "Parent" : "33"},
	{"ID" : "45", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.sparsemux_9_2_16_1_1_U45", "Parent" : "33"},
	{"ID" : "46", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.mul_16s_6s_20_1_1_U46", "Parent" : "33"},
	{"ID" : "47", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.sparsemux_9_2_16_1_1_U47", "Parent" : "33"},
	{"ID" : "48", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.mul_16s_6s_20_1_1_U48", "Parent" : "33"},
	{"ID" : "49", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.sparsemux_9_2_16_1_1_U49", "Parent" : "33"},
	{"ID" : "50", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.mul_16s_6s_20_1_1_U50", "Parent" : "33"},
	{"ID" : "51", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.sparsemux_9_2_16_1_1_U51", "Parent" : "33"},
	{"ID" : "52", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.mul_16s_6s_20_1_1_U52", "Parent" : "33"},
	{"ID" : "53", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.sparsemux_9_2_16_1_1_U53", "Parent" : "33"},
	{"ID" : "54", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.mul_16s_6s_20_1_1_U54", "Parent" : "33"},
	{"ID" : "55", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_53.flow_control_loop_pipe_sequential_init_U", "Parent" : "33"},
	{"ID" : "56", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0.regslice_both_layer7_out_U", "Parent" : "32"},
	{"ID" : "57", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.layer3x4_out_U", "Parent" : "0"},
	{"ID" : "58", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.layer4x4_out_U", "Parent" : "0"},
	{"ID" : "59", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.layer5x4_out_U", "Parent" : "0"},
	{"ID" : "60", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.start_for_relu_array_ap_fixed_28u_array_ap_fixed_16_6_5_3_0_28u_relu_config4_U0_U", "Parent" : "0"},
	{"ID" : "61", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.start_for_maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config5_U0_U", "Parent" : "0"},
	{"ID" : "62", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.start_for_dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	cnn_core {
		input_layer {Type I LastRead 0 FirstWrite -1}
		layer7_out {Type O LastRead -1 FirstWrite 2}}
	first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_s {
		input_layer {Type I LastRead 0 FirstWrite -1}
		layer3x4_out {Type O LastRead -1 FirstWrite 2}}
	relu_array_ap_fixed_28u_array_ap_fixed_16_6_5_3_0_28u_relu_config4_s {
		layer3x4_out {Type I LastRead 1 FirstWrite -1}
		layer4x4_out {Type O LastRead -1 FirstWrite 2}}
	maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config5_s {
		layer4x4_out {Type I LastRead 1 FirstWrite -1}
		layer5x4_out {Type O LastRead -1 FirstWrite 2}}
	dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_s {
		layer5x4_out {Type I LastRead 2 FirstWrite -1}
		layer7_out {Type O LastRead -1 FirstWrite 2}}
	dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain {
		layer5x4_out {Type I LastRead 2 FirstWrite -1}
		acc_out {Type O LastRead -1 FirstWrite 4}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "263", "Max" : "263"}
	, {"Name" : "Interval", "Min" : "260", "Max" : "260"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	input_layer { axis {  { input_layer_TDATA in_data 0 64 }  { input_layer_TVALID in_vld 0 1 }  { input_layer_TREADY in_acc 1 1 } } }
	layer7_out { axis {  { layer7_out_TDATA out_data 1 16 }  { layer7_out_TVALID out_vld 1 1 }  { layer7_out_TREADY out_acc 0 1 } } }
}

set maxi_interface_dict [dict create]

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
