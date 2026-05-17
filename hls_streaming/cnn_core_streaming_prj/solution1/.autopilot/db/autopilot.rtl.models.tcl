set SynModuleInfo {
  {SRCNAME first_conv_4lane_temporal_wide_cl<array,array<ap_fixed,28u>,config3> MODELNAME first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_s RTLNAME cnn_core_first_conv_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config3_s
    SUBMODULES {
      {MODELNAME cnn_core_mul_12s_5ns_15_1_1 RTLNAME cnn_core_mul_12s_5ns_15_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME cnn_core_sparsemux_11_3_12_1_1 RTLNAME cnn_core_sparsemux_11_3_12_1_1 BINDTYPE op TYPE sparsemux IMPL auto}
      {MODELNAME cnn_core_regslice_both RTLNAME cnn_core_regslice_both BINDTYPE interface TYPE interface_regslice INSTNAME cnn_core_regslice_both_U}
      {MODELNAME cnn_core_flow_control_loop_pipe RTLNAME cnn_core_flow_control_loop_pipe BINDTYPE interface TYPE internal_upc_flow_control INSTNAME cnn_core_flow_control_loop_pipe_U}
    }
  }
  {SRCNAME relu<array<ap_fixed,28u>,array<ap_fixed<16,6,5,3,0>,28u>,relu_config4> MODELNAME relu_array_ap_fixed_28u_array_ap_fixed_16_6_5_3_0_28u_relu_config4_s RTLNAME cnn_core_relu_array_ap_fixed_28u_array_ap_fixed_16_6_5_3_0_28u_relu_config4_s}
  {SRCNAME maxpool2d_wide_nonoverlap_cl<array,array<ap_fixed,28u>,config5> MODELNAME maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config5_s RTLNAME cnn_core_maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config5_s}
  {SRCNAME dense_wide_stream<array,array<ap_fixed,1u>,config7>_Pipeline_DenseWideMain MODELNAME dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain RTLNAME cnn_core_dense_wide_stream_array_array_ap_fixed_1u_config7_Pipeline_DenseWideMain
    SUBMODULES {
      {MODELNAME cnn_core_sparsemux_2353_11_6_1_1 RTLNAME cnn_core_sparsemux_2353_11_6_1_1 BINDTYPE op TYPE sparsemux IMPL auto}
      {MODELNAME cnn_core_sparsemux_9_2_16_1_1 RTLNAME cnn_core_sparsemux_9_2_16_1_1 BINDTYPE op TYPE sparsemux IMPL auto}
      {MODELNAME cnn_core_mul_16s_6s_20_1_1 RTLNAME cnn_core_mul_16s_6s_20_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME cnn_core_flow_control_loop_pipe_sequential_init RTLNAME cnn_core_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME cnn_core_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME dense_wide_stream<array,array<ap_fixed<9,5,5,3,0>,1u>,config7> MODELNAME dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_s RTLNAME cnn_core_dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_s}
  {SRCNAME cnn_core MODELNAME cnn_core RTLNAME cnn_core IS_TOP 1
    SUBMODULES {
      {MODELNAME cnn_core_fifo_w252_d4_S RTLNAME cnn_core_fifo_w252_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME layer3x4_out_U}
      {MODELNAME cnn_core_fifo_w448_d4_S RTLNAME cnn_core_fifo_w448_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME layer4x4_out_U}
      {MODELNAME cnn_core_fifo_w448_d4_S RTLNAME cnn_core_fifo_w448_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME layer5x4_out_U}
      {MODELNAME cnn_core_start_for_relu_array_ap_fixed_28u_array_ap_fixed_16_6_5_3_0_28u_relu_config4_U0 RTLNAME cnn_core_start_for_relu_array_ap_fixed_28u_array_ap_fixed_16_6_5_3_0_28u_relu_config4_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_relu_array_ap_fixed_28u_array_ap_fixed_16_6_5_3_0_28u_relu_config4_U0_U}
      {MODELNAME cnn_core_start_for_maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config5_U0 RTLNAME cnn_core_start_for_maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config5_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config5_U0_U}
      {MODELNAME cnn_core_start_for_dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0 RTLNAME cnn_core_start_for_dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_dense_wide_stream_array_array_ap_fixed_9_5_5_3_0_1u_config7_U0_U}
    }
  }
}
