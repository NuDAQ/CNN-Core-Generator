`timescale 1 ns / 1 ps

module AESL_deadlock_kernel_monitor_top ( 
    input wire kernel_monitor_clock,
    input wire kernel_monitor_reset
);
wire [1:0] axis_block_sigs;
wire [7:0] inst_idle_sigs;
wire [4:0] inst_block_sigs;
wire kernel_block;

assign axis_block_sigs[0] = ~AESL_inst_cnn_core.repack_stream_array_ap_fixed_4u_array_ap_fixed_12_6_5_3_0_1u_1024_U0.input_layer_TDATA_blk_n;
assign axis_block_sigs[1] = ~AESL_inst_cnn_core.dense_array_ap_fixed_7u_array_ap_fixed_9_5_5_3_0_1u_config7_U0.layer7_out_TDATA_blk_n;

assign inst_idle_sigs[0] = AESL_inst_cnn_core.repack_stream_array_ap_fixed_4u_array_ap_fixed_12_6_5_3_0_1u_1024_U0.ap_idle;
assign inst_block_sigs[0] = (AESL_inst_cnn_core.repack_stream_array_ap_fixed_4u_array_ap_fixed_12_6_5_3_0_1u_1024_U0.ap_done & ~AESL_inst_cnn_core.repack_stream_array_ap_fixed_4u_array_ap_fixed_12_6_5_3_0_1u_1024_U0.ap_continue) | ~AESL_inst_cnn_core.repack_stream_array_ap_fixed_4u_array_ap_fixed_12_6_5_3_0_1u_1024_U0.layer8_out_blk_n;
assign inst_idle_sigs[1] = AESL_inst_cnn_core.conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_9_5_5_3_0_7u_config3_U0.ap_idle;
assign inst_block_sigs[1] = (AESL_inst_cnn_core.conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_9_5_5_3_0_7u_config3_U0.ap_done & ~AESL_inst_cnn_core.conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_9_5_5_3_0_7u_config3_U0.ap_continue) | ~AESL_inst_cnn_core.conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_9_5_5_3_0_7u_config3_U0.layer8_out_blk_n | ~AESL_inst_cnn_core.conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_9_5_5_3_0_7u_config3_U0.layer3_out_blk_n | ~AESL_inst_cnn_core.conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_9_5_5_3_0_7u_config3_U0.grp_compute_output_buffer_2d_array_array_ap_fixed_9_5_5_3_0_7u_config3_s_fu_70.layer3_out_blk_n;
assign inst_idle_sigs[2] = AESL_inst_cnn_core.relu_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_relu_config4_U0.ap_idle;
assign inst_block_sigs[2] = (AESL_inst_cnn_core.relu_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_relu_config4_U0.ap_done & ~AESL_inst_cnn_core.relu_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_relu_config4_U0.ap_continue) | ~AESL_inst_cnn_core.relu_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_relu_config4_U0.layer3_out_blk_n | ~AESL_inst_cnn_core.relu_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_relu_config4_U0.layer4_out_blk_n;
assign inst_idle_sigs[3] = AESL_inst_cnn_core.pooling2d_cl_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_config5_U0.ap_idle;
assign inst_block_sigs[3] = (AESL_inst_cnn_core.pooling2d_cl_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_config5_U0.ap_done & ~AESL_inst_cnn_core.pooling2d_cl_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_config5_U0.ap_continue) | ~AESL_inst_cnn_core.pooling2d_cl_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_config5_U0.layer4_out_blk_n | ~AESL_inst_cnn_core.pooling2d_cl_array_ap_fixed_7u_array_ap_fixed_16_6_5_3_0_7u_config5_U0.layer5_out_blk_n;
assign inst_idle_sigs[4] = AESL_inst_cnn_core.dense_array_ap_fixed_7u_array_ap_fixed_9_5_5_3_0_1u_config7_U0.ap_idle;
assign inst_block_sigs[4] = (AESL_inst_cnn_core.dense_array_ap_fixed_7u_array_ap_fixed_9_5_5_3_0_1u_config7_U0.ap_done & ~AESL_inst_cnn_core.dense_array_ap_fixed_7u_array_ap_fixed_9_5_5_3_0_1u_config7_U0.ap_continue) | ~AESL_inst_cnn_core.dense_array_ap_fixed_7u_array_ap_fixed_9_5_5_3_0_1u_config7_U0.grp_dense_array_array_ap_fixed_9_5_5_3_0_1u_config7_Pipeline_DataPrepare_fu_3197.layer5_out_blk_n;

assign inst_idle_sigs[5] = 1'b0;
assign inst_idle_sigs[6] = AESL_inst_cnn_core.repack_stream_array_ap_fixed_4u_array_ap_fixed_12_6_5_3_0_1u_1024_U0.ap_idle;
assign inst_idle_sigs[7] = AESL_inst_cnn_core.dense_array_ap_fixed_7u_array_ap_fixed_9_5_5_3_0_1u_config7_U0.ap_idle;

AESL_deadlock_idx0_monitor AESL_deadlock_idx0_monitor_U (
    .clock(kernel_monitor_clock),
    .reset(kernel_monitor_reset),
    .axis_block_sigs(axis_block_sigs),
    .inst_idle_sigs(inst_idle_sigs),
    .inst_block_sigs(inst_block_sigs),
    .block(kernel_block)
);


initial begin : trigger_axis_deadlock
reg block_delay;
    block_delay = 0;
    while(1) begin
        @(posedge kernel_monitor_clock);
    if (kernel_block == 1'b1 && block_delay == 1'b0)
        block_delay = kernel_block;
    end
end

endmodule
