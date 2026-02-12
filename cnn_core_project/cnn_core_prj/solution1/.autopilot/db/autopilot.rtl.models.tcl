set SynModuleInfo {
  {SRCNAME transpose<array,array<ap_fixed,256u>,config2>_Pipeline_VITIS_LOOP_16_1 MODELNAME transpose_array_array_ap_fixed_256u_config2_Pipeline_VITIS_LOOP_16_1 RTLNAME cnn_core_transpose_array_array_ap_fixed_256u_config2_Pipeline_VITIS_LOOP_16_1
    SUBMODULES {
      {MODELNAME cnn_core_flow_control_loop_pipe_sequential_init RTLNAME cnn_core_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME cnn_core_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME transpose<array,array<ap_fixed,256u>,config2>_Pipeline_VITIS_LOOP_25_3 MODELNAME transpose_array_array_ap_fixed_256u_config2_Pipeline_VITIS_LOOP_25_3 RTLNAME cnn_core_transpose_array_array_ap_fixed_256u_config2_Pipeline_VITIS_LOOP_25_3
    SUBMODULES {
      {MODELNAME cnn_core_sparsemux_9_2_12_1_1 RTLNAME cnn_core_sparsemux_9_2_12_1_1 BINDTYPE op TYPE sparsemux IMPL auto}
    }
  }
  {SRCNAME transpose<array<ap_fixed,4u>,array<ap_fixed<12,6,5,3,0>,256u>,config2> MODELNAME transpose_array_ap_fixed_4u_array_ap_fixed_12_6_5_3_0_256u_config2_s RTLNAME cnn_core_transpose_array_ap_fixed_4u_array_ap_fixed_12_6_5_3_0_256u_config2_s
    SUBMODULES {
      {MODELNAME cnn_core_regslice_both RTLNAME cnn_core_regslice_both BINDTYPE interface TYPE interface_regslice INSTNAME cnn_core_regslice_both_U}
    }
  }
  {SRCNAME repack_stream<array,array<ap_fixed,1u>,1024>_Pipeline_VITIS_LOOP_254_4 MODELNAME repack_stream_array_array_ap_fixed_1u_1024_Pipeline_VITIS_LOOP_254_4 RTLNAME cnn_core_repack_stream_array_array_ap_fixed_1u_1024_Pipeline_VITIS_LOOP_254_4}
  {SRCNAME repack_stream<array<ap_fixed,256u>,array<ap_fixed<12,6,5,3,0>,1u>,1024> MODELNAME repack_stream_array_ap_fixed_256u_array_ap_fixed_12_6_5_3_0_1u_1024_s RTLNAME cnn_core_repack_stream_array_ap_fixed_256u_array_ap_fixed_12_6_5_3_0_1u_1024_s
    SUBMODULES {
      {MODELNAME cnn_core_repack_stream_array_ap_fixed_256u_array_ap_fixed_12_6_5_3_0_1u_1024_s_in_databkb RTLNAME cnn_core_repack_stream_array_ap_fixed_256u_array_ap_fixed_12_6_5_3_0_1u_1024_s_in_databkb BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME {dense_latency<ap_fixed<12, 6, 5, 3, 0>, ap_fixed<17, 9, 5, 3, 0>, config4_mult>} MODELNAME dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s RTLNAME cnn_core_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_17_9_5_3_0_config4_mult_s
    SUBMODULES {
      {MODELNAME cnn_core_mul_12s_8ns_20_1_0 RTLNAME cnn_core_mul_12s_8ns_20_1_0 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME cnn_core_mul_12s_7ns_19_1_0 RTLNAME cnn_core_mul_12s_7ns_19_1_0 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME cnn_core_mul_12s_7s_19_1_0 RTLNAME cnn_core_mul_12s_7s_19_1_0 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME cnn_core_mul_12s_9ns_20_1_0 RTLNAME cnn_core_mul_12s_9ns_20_1_0 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME cnn_core_mul_12s_8s_20_1_0 RTLNAME cnn_core_mul_12s_8s_20_1_0 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME cnn_core_mul_12s_9s_20_1_0 RTLNAME cnn_core_mul_12s_9s_20_1_0 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME cnn_core_mul_12s_6s_18_1_0 RTLNAME cnn_core_mul_12s_6s_18_1_0 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME compute_output_buffer_1d<array,array<ap_fixed<17,9,5,3,0>,7u>,config4> MODELNAME compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s RTLNAME cnn_core_compute_output_buffer_1d_array_array_ap_fixed_17_9_5_3_0_7u_config4_s}
  {SRCNAME conv_2d_cl<array<ap_fixed,1u>,array<ap_fixed<17,9,5,3,0>,7u>,config4> MODELNAME conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_17_9_5_3_0_7u_config4_s RTLNAME cnn_core_conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_17_9_5_3_0_7u_config4_s
    SUBMODULES {
      {MODELNAME cnn_core_flow_control_loop_pipe RTLNAME cnn_core_flow_control_loop_pipe BINDTYPE interface TYPE internal_upc_flow_control INSTNAME cnn_core_flow_control_loop_pipe_U}
    }
  }
  {SRCNAME relu<array<ap_fixed,7u>,array<ap_fixed<16,6,5,3,0>,7u>,relu_config5> MODELNAME relu_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_relu_config5_s RTLNAME cnn_core_relu_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_relu_config5_s}
  {SRCNAME {shift_line_buffer<array<ap_fixed<16, 6, 5, 3, 0>, 7u>, config6>} MODELNAME shift_line_buffer_array_ap_fixed_16_6_5_3_0_7u_config6_s RTLNAME cnn_core_shift_line_buffer_array_ap_fixed_16_6_5_3_0_7u_config6_s}
  {SRCNAME pooling2d_cl<array<ap_fixed,7u>,array<ap_fixed<16,6,5,3,0>,7u>,config6> MODELNAME pooling2d_cl_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_config6_s RTLNAME cnn_core_pooling2d_cl_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_config6_s}
  {SRCNAME repack_stream<array<ap_fixed,7u>,array<ap_fixed<16,6,5,3,0>,42u>,1176> MODELNAME repack_stream_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_42u_1176_s RTLNAME cnn_core_repack_stream_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_42u_1176_s}
  {SRCNAME repack_stream<array<ap_fixed,42u>,array<ap_fixed<16,6,5,3,0>,42u>,1176> MODELNAME repack_stream_array_ap_fixed_42u_array_ap_fixed_16_6_5_3_0_42u_1176_s RTLNAME cnn_core_repack_stream_array_ap_fixed_42u_array_ap_fixed_16_6_5_3_0_42u_1176_s}
  {SRCNAME dense<array,array<ap_fixed<17,9,5,3,0>,1u>,config10>_Pipeline_DataPrepare MODELNAME dense_array_array_ap_fixed_17_9_5_3_0_1u_config10_Pipeline_DataPrepare RTLNAME cnn_core_dense_array_array_ap_fixed_17_9_5_3_0_1u_config10_Pipeline_DataPrepare}
  {SRCNAME dense_latency_wrapper<ap_fixed,ap_fixed<17,9,5,3,0>,config10> MODELNAME dense_latency_wrapper_ap_fixed_ap_fixed_17_9_5_3_0_config10_s RTLNAME cnn_core_dense_latency_wrapper_ap_fixed_ap_fixed_17_9_5_3_0_config10_s
    SUBMODULES {
      {MODELNAME cnn_core_mul_16s_7ns_23_1_1 RTLNAME cnn_core_mul_16s_7ns_23_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME cnn_core_mul_16s_6ns_22_1_1 RTLNAME cnn_core_mul_16s_6ns_22_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME cnn_core_mul_16s_9ns_24_1_1 RTLNAME cnn_core_mul_16s_9ns_24_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME cnn_core_mul_16s_8ns_24_1_1 RTLNAME cnn_core_mul_16s_8ns_24_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME cnn_core_mul_16s_8s_24_1_1 RTLNAME cnn_core_mul_16s_8s_24_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME cnn_core_mul_16s_5s_21_1_1 RTLNAME cnn_core_mul_16s_5s_21_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME cnn_core_mul_16s_7s_23_1_1 RTLNAME cnn_core_mul_16s_7s_23_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME cnn_core_mul_16s_6s_22_1_1 RTLNAME cnn_core_mul_16s_6s_22_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME cnn_core_mul_16s_10ns_24_1_1 RTLNAME cnn_core_mul_16s_10ns_24_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME cnn_core_mul_16s_5ns_21_1_1 RTLNAME cnn_core_mul_16s_5ns_21_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME dense<array<ap_fixed,42u>,array<ap_fixed<17,9,5,3,0>,1u>,config10> MODELNAME dense_array_ap_fixed_42u_array_ap_fixed_17_9_5_3_0_1u_config10_s RTLNAME cnn_core_dense_array_ap_fixed_42u_array_ap_fixed_17_9_5_3_0_1u_config10_s}
  {SRCNAME cnn_core MODELNAME cnn_core RTLNAME cnn_core IS_TOP 1
    SUBMODULES {
      {MODELNAME cnn_core_fifo_w3072_d4_A RTLNAME cnn_core_fifo_w3072_d4_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer2_out_U}
      {MODELNAME cnn_core_fifo_w12_d1024_A RTLNAME cnn_core_fifo_w12_d1024_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer11_out_U}
      {MODELNAME cnn_core_fifo_w119_d336_A RTLNAME cnn_core_fifo_w119_d336_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer4_out_U}
      {MODELNAME cnn_core_fifo_w112_d336_A RTLNAME cnn_core_fifo_w112_d336_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer5_out_U}
      {MODELNAME cnn_core_fifo_w112_d168_A RTLNAME cnn_core_fifo_w112_d168_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer6_out_U}
      {MODELNAME cnn_core_fifo_w672_d28_A RTLNAME cnn_core_fifo_w672_d28_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer12_out_U}
      {MODELNAME cnn_core_fifo_w672_d28_A RTLNAME cnn_core_fifo_w672_d28_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer13_out_U}
      {MODELNAME cnn_core_start_for_repack_stream_array_ap_fixed_256u_array_ap_fixed_12_6_5_3_0_1u_1024cud RTLNAME cnn_core_start_for_repack_stream_array_ap_fixed_256u_array_ap_fixed_12_6_5_3_0_1u_1024cud BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_repack_stream_array_ap_fixed_256u_array_ap_fixed_12_6_5_3_0_1u_1024cud_U}
      {MODELNAME cnn_core_start_for_conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_17_9_5_3_0_7u_config4_U0 RTLNAME cnn_core_start_for_conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_17_9_5_3_0_7u_config4_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_17_9_5_3_0_7u_config4_U0_U}
      {MODELNAME cnn_core_start_for_relu_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_relu_config5_U0 RTLNAME cnn_core_start_for_relu_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_relu_config5_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_relu_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_relu_config5_U0_U}
      {MODELNAME cnn_core_start_for_pooling2d_cl_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_config6dEe RTLNAME cnn_core_start_for_pooling2d_cl_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_config6dEe BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_pooling2d_cl_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_config6dEe_U}
      {MODELNAME cnn_core_start_for_repack_stream_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_42u_1176_U0 RTLNAME cnn_core_start_for_repack_stream_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_42u_1176_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_repack_stream_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_42u_1176_U0_U}
      {MODELNAME cnn_core_start_for_repack_stream_array_ap_fixed_42u_array_ap_fixed_16_6_5_3_0_42u_1176eOg RTLNAME cnn_core_start_for_repack_stream_array_ap_fixed_42u_array_ap_fixed_16_6_5_3_0_42u_1176eOg BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_repack_stream_array_ap_fixed_42u_array_ap_fixed_16_6_5_3_0_42u_1176eOg_U}
      {MODELNAME cnn_core_start_for_dense_array_ap_fixed_42u_array_ap_fixed_17_9_5_3_0_1u_config10_U0 RTLNAME cnn_core_start_for_dense_array_ap_fixed_42u_array_ap_fixed_17_9_5_3_0_1u_config10_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_dense_array_ap_fixed_42u_array_ap_fixed_17_9_5_3_0_1u_config10_U0_U}
    }
  }
}
