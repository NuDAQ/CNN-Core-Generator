set ModuleHierarchy {[{
"Name" : "cnn_core","ID" : "0","Type" : "dataflow",
"SubInsts" : [
	{"Name" : "first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_U0","ID" : "1","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReadInputHeightWide","ID" : "2","Type" : "pipeline"},]},
	{"Name" : "relu_array_ap_fixed_28u_array_ap_fixed_16_6_5_3_0_28u_relu_config4_U0","ID" : "3","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReLUActLoop","ID" : "4","Type" : "pipeline"},]},
	{"Name" : "maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config5_U0","ID" : "5","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "PoolWideMain","ID" : "6","Type" : "pipeline"},]},
	{"Name" : "dense_wide_stream_array_array_ap_fixed_16_6_5_3_0_1u_config7_U0","ID" : "7","Type" : "sequential",
		"SubInsts" : [
		{"Name" : "grp_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain_fu_47","ID" : "8","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "DenseWideMain","ID" : "9","Type" : "pipeline"},]},]},]
}]}