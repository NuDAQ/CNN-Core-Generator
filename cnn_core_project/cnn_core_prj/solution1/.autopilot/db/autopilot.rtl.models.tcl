set SynModuleInfo {
  {SRCNAME repack_stream<array<ap_fixed,4u>,array<ap_fixed<12,6,5,3,0>,1u>,1024> MODELNAME repack_stream_array_ap_fixed_4u_array_ap_fixed_12_6_5_3_0_1u_1024_s RTLNAME cnn_core_repack_stream_array_ap_fixed_4u_array_ap_fixed_12_6_5_3_0_1u_1024_s
    SUBMODULES {
      {MODELNAME cnn_core_repack_stream_array_ap_fixed_4u_array_ap_fixed_12_6_5_3_0_1u_1024_s_in_data_Rbkb RTLNAME cnn_core_repack_stream_array_ap_fixed_4u_array_ap_fixed_12_6_5_3_0_1u_1024_s_in_data_Rbkb BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME cnn_core_regslice_both RTLNAME cnn_core_regslice_both BINDTYPE interface TYPE interface_regslice INSTNAME cnn_core_regslice_both_U}
      {MODELNAME cnn_core_flow_control_loop_pipe RTLNAME cnn_core_flow_control_loop_pipe BINDTYPE interface TYPE internal_upc_flow_control INSTNAME cnn_core_flow_control_loop_pipe_U}
    }
  }
  {SRCNAME {shift_line_buffer<array<ap_fixed<12, 6, 5, 3, 0>, 1u>, config3>} MODELNAME shift_line_buffer_array_ap_fixed_12_6_5_3_0_1u_config3_s RTLNAME cnn_core_shift_line_buffer_array_ap_fixed_12_6_5_3_0_1u_config3_s
    SUBMODULES {
      {MODELNAME cnn_core_shift_line_buffer_array_ap_fixed_12_6_5_3_0_1u_config3_s_void_conv_2d_buffer_cud RTLNAME cnn_core_shift_line_buffer_array_ap_fixed_12_6_5_3_0_1u_config3_s_void_conv_2d_buffer_cud BINDTYPE storage TYPE shiftreg IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME {dense_latency<ap_fixed<12, 6, 5, 3, 0>, ap_fixed<9, 5, 5, 3, 0>, config3_mult>} MODELNAME dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_9_5_5_3_0_config3_mult_s RTLNAME cnn_core_dense_latency_ap_fixed_12_6_5_3_0_ap_fixed_9_5_5_3_0_config3_mult_s
    SUBMODULES {
      {MODELNAME cnn_core_mul_12s_5ns_15_1_1 RTLNAME cnn_core_mul_12s_5ns_15_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME compute_output_buffer_2d<array,array<ap_fixed<9,5,5,3,0>,7u>,config3> MODELNAME compute_output_buffer_2d_array_array_ap_fixed_9_5_5_3_0_7u_config3_s RTLNAME cnn_core_compute_output_buffer_2d_array_array_ap_fixed_9_5_5_3_0_7u_config3_s}
  {SRCNAME conv_2d_cl<array<ap_fixed,1u>,array<ap_fixed<9,5,5,3,0>,7u>,config3> MODELNAME conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_9_5_5_3_0_7u_config3_s RTLNAME cnn_core_conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_9_5_5_3_0_7u_config3_s}
  {SRCNAME relu<array<ap_fixed,7u>,array<ap_fixed<16,6,5,3,0>,7u>,relu_config4> MODELNAME relu_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_relu_config4_s RTLNAME cnn_core_relu_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_relu_config4_s}
  {SRCNAME {shift_line_buffer<array<ap_fixed<16, 6, 5, 3, 0>, 7u>, config5>} MODELNAME shift_line_buffer_array_ap_fixed_16_6_5_3_0_7u_config5_s RTLNAME cnn_core_shift_line_buffer_array_ap_fixed_16_6_5_3_0_7u_config5_s
    SUBMODULES {
      {MODELNAME cnn_core_shift_line_buffer_array_ap_fixed_16_6_5_3_0_7u_config5_s_void_pooling2d_cl_stg8j RTLNAME cnn_core_shift_line_buffer_array_ap_fixed_16_6_5_3_0_7u_config5_s_void_pooling2d_cl_stg8j BINDTYPE storage TYPE shiftreg IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME pooling2d_cl<array<ap_fixed,7u>,array<ap_fixed<16,6,5,3,0>,7u>,config5> MODELNAME pooling2d_cl_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_config5_s RTLNAME cnn_core_pooling2d_cl_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_config5_s}
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
      {MODELNAME cnn_core_fifo_w12_d1024_A RTLNAME cnn_core_fifo_w12_d1024_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer8_out_U}
      {MODELNAME cnn_core_fifo_w63_d336_A RTLNAME cnn_core_fifo_w63_d336_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer3_out_U}
      {MODELNAME cnn_core_fifo_w112_d336_A RTLNAME cnn_core_fifo_w112_d336_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer4_out_U}
      {MODELNAME cnn_core_fifo_w112_d168_A RTLNAME cnn_core_fifo_w112_d168_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer5_out_U}
      {MODELNAME cnn_core_start_for_conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_9_5_5_3_0_7u_config3_U0 RTLNAME cnn_core_start_for_conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_9_5_5_3_0_7u_config3_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_9_5_5_3_0_7u_config3_U0_U}
      {MODELNAME cnn_core_start_for_relu_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_relu_config4_U0 RTLNAME cnn_core_start_for_relu_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_relu_config4_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_relu_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_relu_config4_U0_U}
      {MODELNAME cnn_core_start_for_pooling2d_cl_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_config5ncg RTLNAME cnn_core_start_for_pooling2d_cl_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_config5ncg BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_pooling2d_cl_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_config5ncg_U}
      {MODELNAME cnn_core_start_for_dense_array_ap_fixed_7u_array_ap_fixed_9_5_5_3_0_1u_config7_U0 RTLNAME cnn_core_start_for_dense_array_ap_fixed_7u_array_ap_fixed_9_5_5_3_0_1u_config7_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_dense_array_ap_fixed_7u_array_ap_fixed_9_5_5_3_0_1u_config7_U0_U}
    }
  }
}
