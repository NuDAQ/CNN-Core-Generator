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
  {SRCNAME unpack_4lane_temporal_cl<array,array<ap_fixed<16,6,5,3,0>,7u>,config5> MODELNAME unpack_4lane_temporal_cl_array_array_ap_fixed_16_6_5_3_0_7u_config5_s RTLNAME cnn_core_unpack_4lane_temporal_cl_array_array_ap_fixed_16_6_5_3_0_7u_config5_s
    SUBMODULES {
      {MODELNAME cnn_core_sparsemux_9_2_16_1_1 RTLNAME cnn_core_sparsemux_9_2_16_1_1 BINDTYPE op TYPE sparsemux IMPL auto}
    }
  }
  {SRCNAME dense<array,array<ap_fixed<9,5,5,3,0>,1u>,config7>_Pipeline_DataPrepare MODELNAME dense_array_array_ap_fixed_9_5_5_3_0_1u_config7_Pipeline_DataPrepare RTLNAME cnn_core_dense_array_array_ap_fixed_9_5_5_3_0_1u_config7_Pipeline_DataPrepare
    SUBMODULES {
      {MODELNAME cnn_core_flow_control_loop_pipe_sequential_init RTLNAME cnn_core_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME cnn_core_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME dense_latency_wrapper<ap_fixed,ap_fixed<9,5,5,3,0>,config7> MODELNAME dense_latency_wrapper_ap_fixed_ap_fixed_9_5_5_3_0_config7_s RTLNAME cnn_core_dense_latency_wrapper_ap_fixed_ap_fixed_9_5_5_3_0_config7_s
    SUBMODULES {
      {MODELNAME cnn_core_mul_16s_6ns_19_1_1 RTLNAME cnn_core_mul_16s_6ns_19_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME cnn_core_mul_16s_5ns_19_1_1 RTLNAME cnn_core_mul_16s_5ns_19_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME dense<array<ap_fixed,7u>,array<ap_fixed<9,5,5,3,0>,1u>,config7> MODELNAME dense_array_ap_fixed_7u_array_ap_fixed_9_5_5_3_0_1u_config7_s RTLNAME cnn_core_dense_array_ap_fixed_7u_array_ap_fixed_9_5_5_3_0_1u_config7_s}
  {SRCNAME cnn_core MODELNAME cnn_core RTLNAME cnn_core IS_TOP 1
    SUBMODULES {
      {MODELNAME cnn_core_fifo_w252_d4_S RTLNAME cnn_core_fifo_w252_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME layer3x4_out_U}
      {MODELNAME cnn_core_fifo_w448_d4_S RTLNAME cnn_core_fifo_w448_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME layer4x4_out_U}
      {MODELNAME cnn_core_fifo_w448_d4_S RTLNAME cnn_core_fifo_w448_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME layer5x4_out_U}
      {MODELNAME cnn_core_fifo_w112_d168_A RTLNAME cnn_core_fifo_w112_d168_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer5_out_U}
      {MODELNAME cnn_core_start_for_relu_array_ap_fixed_28u_array_ap_fixed_16_6_5_3_0_28u_relu_config4_U0 RTLNAME cnn_core_start_for_relu_array_ap_fixed_28u_array_ap_fixed_16_6_5_3_0_28u_relu_config4_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_relu_array_ap_fixed_28u_array_ap_fixed_16_6_5_3_0_28u_relu_config4_U0_U}
      {MODELNAME cnn_core_start_for_maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config5_U0 RTLNAME cnn_core_start_for_maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config5_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config5_U0_U}
      {MODELNAME cnn_core_start_for_unpack_4lane_temporal_cl_array_array_ap_fixed_16_6_5_3_0_7u_config5bkb RTLNAME cnn_core_start_for_unpack_4lane_temporal_cl_array_array_ap_fixed_16_6_5_3_0_7u_config5bkb BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_unpack_4lane_temporal_cl_array_array_ap_fixed_16_6_5_3_0_7u_config5bkb_U}
      {MODELNAME cnn_core_start_for_dense_array_ap_fixed_7u_array_ap_fixed_9_5_5_3_0_1u_config7_U0 RTLNAME cnn_core_start_for_dense_array_ap_fixed_7u_array_ap_fixed_9_5_5_3_0_1u_config7_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_dense_array_ap_fixed_7u_array_ap_fixed_9_5_5_3_0_1u_config7_U0_U}
    }
  }
}
