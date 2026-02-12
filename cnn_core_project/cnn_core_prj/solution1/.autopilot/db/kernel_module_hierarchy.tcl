set ModuleHierarchy {[{
"Name" : "cnn_core","ID" : "0","Type" : "dataflow",
"SubInsts" : [
	{"Name" : "transpose_array_ap_fixed_4u_array_ap_fixed_12_6_5_3_0_256u_config2_U0","ID" : "1","Type" : "sequential",
		"SubInsts" : [
		{"Name" : "grp_transpose_array_array_ap_fixed_256u_config2_Pipeline_VITIS_LOOP_16_1_fu_4124","ID" : "2","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_16_1","ID" : "3","Type" : "pipeline"},]},
		{"Name" : "grp_transpose_array_array_ap_fixed_256u_config2_Pipeline_VITIS_LOOP_25_3_fu_5154","ID" : "4","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_25_3","ID" : "5","Type" : "pipeline"},]},]},
	{"Name" : "repack_stream_array_ap_fixed_256u_array_ap_fixed_12_6_5_3_0_1u_1024_U0","ID" : "6","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_245_3","ID" : "7","Type" : "no",
		"SubInsts" : [
		{"Name" : "grp_repack_stream_array_array_ap_fixed_1u_1024_Pipeline_VITIS_LOOP_254_4_fu_3639","ID" : "8","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_254_4","ID" : "9","Type" : "pipeline"},]},]},]},
	{"Name" : "conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_17_9_5_3_0_7u_config4_U0","ID" : "10","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReadInputHeight_ReadInputWidth","ID" : "11","Type" : "pipeline",
		"SubInsts" : [
		{"Name" : "grp_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s_fu_60","ID" : "12","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "grp_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s_fu_76","ID" : "13","Type" : "pipeline"},]},]},]},
	{"Name" : "relu_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_relu_config5_U0","ID" : "14","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReLUActLoop","ID" : "15","Type" : "pipeline"},]},
	{"Name" : "pooling2d_cl_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_config6_U0","ID" : "16","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReadInputHeight_ReadInputWidth","ID" : "17","Type" : "pipeline",
		"SubInsts" : [
		{"Name" : "call_ln52_shift_line_buffer_array_ap_fixed_16_6_5_3_0_7u_config6_s_fu_125","ID" : "18","Type" : "pipeline"},]},]},
	{"Name" : "repack_stream_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_42u_1176_U0","ID" : "19","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_269_6","ID" : "20","Type" : "pipeline"},]},
	{"Name" : "repack_stream_array_ap_fixed_42u_array_ap_fixed_16_6_5_3_0_42u_1176_U0","ID" : "21","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_229_1","ID" : "22","Type" : "pipeline"},]},
	{"Name" : "dense_array_ap_fixed_42u_array_ap_fixed_17_9_5_3_0_1u_config10_U0","ID" : "23","Type" : "sequential",
		"SubInsts" : [
		{"Name" : "grp_dense_array_array_ap_fixed_17_9_5_3_0_1u_config10_Pipeline_DataPrepare_fu_4685","ID" : "24","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "DataPrepare","ID" : "25","Type" : "pipeline"},]},
		{"Name" : "grp_dense_latency_wrapper_ap_fixed_ap_fixed_17_9_5_3_0_config10_s_fu_5853","ID" : "26","Type" : "pipeline"},]},]
}]}