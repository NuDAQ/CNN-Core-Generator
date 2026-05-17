set ModuleHierarchy {[{
"Name" : "cnn_core","ID" : "0","Type" : "dataflow",
"SubInsts" : [
	{"Name" : "first_conv_4lane_temporal_cl_array_array_ap_fixed_9_5_5_3_0_7u_config3_U0","ID" : "1","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReadInputHeight","ID" : "2","Type" : "pipeline"},]},
	{"Name" : "relu_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_relu_config4_U0","ID" : "3","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReLUActLoop","ID" : "4","Type" : "pipeline"},]},
	{"Name" : "pooling2d_cl_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_config5_U0","ID" : "5","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReadInputHeight_ReadInputWidth","ID" : "6","Type" : "pipeline",
		"SubInsts" : [
		{"Name" : "call_ln52_shift_line_buffer_array_ap_fixed_16_6_5_3_0_7u_config5_s_fu_150","ID" : "7","Type" : "pipeline"},]},]},
	{"Name" : "dense_array_ap_fixed_7u_array_ap_fixed_9_5_5_3_0_1u_config7_U0","ID" : "8","Type" : "sequential",
		"SubInsts" : [
		{"Name" : "grp_dense_array_array_ap_fixed_9_5_5_3_0_1u_config7_Pipeline_DataPrepare_fu_3197","ID" : "9","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "DataPrepare","ID" : "10","Type" : "pipeline"},]},
		{"Name" : "grp_dense_latency_wrapper_ap_fixed_ap_fixed_9_5_5_3_0_config7_s_fu_3993","ID" : "11","Type" : "pipeline"},]},]
}]}