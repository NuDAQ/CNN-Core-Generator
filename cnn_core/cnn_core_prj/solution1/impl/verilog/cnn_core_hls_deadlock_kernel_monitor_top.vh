
wire kernel_monitor_reset;
wire kernel_monitor_clock;
wire kernel_monitor_report;
assign kernel_monitor_reset = ~ap_rst_n;
assign kernel_monitor_clock = ap_clk;
assign kernel_monitor_report = 1'b0;
wire [1:0] axis_block_sigs;
wire [6:0] inst_idle_sigs;
wire [3:0] inst_block_sigs;
wire kernel_block;

assign axis_block_sigs[0] = ~first_conv_2row_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config4_U0.input_layer_TDATA_blk_n;
assign axis_block_sigs[1] = ~dense_wide_stream_array_array_ap_fixed_22_11_5_3_0_1u_config9_U0.layer9_out_TDATA_blk_n;

assign inst_idle_sigs[0] = first_conv_2row_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config4_U0.ap_idle;
assign inst_block_sigs[0] = (first_conv_2row_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config4_U0.ap_done & ~first_conv_2row_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config4_U0.ap_continue) | ~first_conv_2row_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config4_U0.layer4_out_x4_blk_n;
assign inst_idle_sigs[1] = relu_array_ap_fixed_28u_array_ap_ufixed_15_5_5_3_0_28u_relu_config5_U0.ap_idle;
assign inst_block_sigs[1] = (relu_array_ap_fixed_28u_array_ap_ufixed_15_5_5_3_0_28u_relu_config5_U0.ap_done & ~relu_array_ap_fixed_28u_array_ap_ufixed_15_5_5_3_0_28u_relu_config5_U0.ap_continue) | ~relu_array_ap_fixed_28u_array_ap_ufixed_15_5_5_3_0_28u_relu_config5_U0.layer4_out_x4_blk_n | ~relu_array_ap_fixed_28u_array_ap_ufixed_15_5_5_3_0_28u_relu_config5_U0.layer5_out_x4_blk_n;
assign inst_idle_sigs[2] = maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config6_U0.ap_idle;
assign inst_block_sigs[2] = (maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config6_U0.ap_done & ~maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config6_U0.ap_continue) | ~maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config6_U0.layer5_out_x4_blk_n | ~maxpool2d_wide_nonoverlap_cl_array_array_ap_fixed_28u_config6_U0.layer6_out_x4_blk_n;
assign inst_idle_sigs[3] = dense_wide_stream_array_array_ap_fixed_22_11_5_3_0_1u_config9_U0.ap_idle;
assign inst_block_sigs[3] = (dense_wide_stream_array_array_ap_fixed_22_11_5_3_0_1u_config9_U0.ap_done & ~dense_wide_stream_array_array_ap_fixed_22_11_5_3_0_1u_config9_U0.ap_continue) | ~dense_wide_stream_array_array_ap_fixed_22_11_5_3_0_1u_config9_U0.grp_dense_wide_stream_array_array_ap_fixed_1u_config9_Pipeline_DenseValues_fu_47.layer6_out_x4_blk_n;

assign inst_idle_sigs[4] = 1'b0;
assign inst_idle_sigs[5] = first_conv_2row_4lane_temporal_wide_cl_array_array_ap_fixed_28u_config4_U0.ap_idle;
assign inst_idle_sigs[6] = dense_wide_stream_array_array_ap_fixed_22_11_5_3_0_1u_config9_U0.ap_idle;

cnn_core_hls_deadlock_idx0_monitor cnn_core_hls_deadlock_idx0_monitor_U (
    .clock(kernel_monitor_clock),
    .reset(kernel_monitor_reset),
    .axis_block_sigs(axis_block_sigs),
    .inst_idle_sigs(inst_idle_sigs),
    .inst_block_sigs(inst_block_sigs),
    .block(kernel_block)
);


always @ (kernel_block or kernel_monitor_reset) begin
    if (kernel_block == 1'b1 && kernel_monitor_reset == 1'b0) begin
        find_kernel_block = 1'b1;
    end
    else begin
        find_kernel_block = 1'b0;
    end
end
