set moduleName shift_line_buffer_array_ap_fixed_16_6_5_3_0_7u_config6_s
set isTopModule 0
set isCombinational 1
set isDatapathOnly 0
set isPipelined 0
set pipeline_type function
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set C_modelName {shift_line_buffer<array<ap_fixed<16, 6, 5, 3, 0>, 7u>, config6>}
set C_modelType { void 0 }
set C_modelArgList {
	{ p_read int 16 regular  }
	{ p_read1 int 16 regular  }
	{ p_read2 int 16 regular  }
	{ p_read3 int 16 regular  }
	{ p_read4 int 16 regular  }
	{ p_read5 int 16 regular  }
	{ p_read6 int 16 regular  }
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_2 int 16 regular {pointer 2} {global 2}  }
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_9 int 16 regular {pointer 1} {global 1}  }
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_1 int 16 regular {pointer 2} {global 2}  }
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_8 int 16 regular {pointer 1} {global 1}  }
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel int 16 regular {pointer 2} {global 2}  }
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_7 int 16 regular {pointer 1} {global 1}  }
	{ p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_3 int 16 regular {pointer 2} {global 2}  }
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_6 int 16 regular {pointer 1} {global 1}  }
	{ p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_2 int 16 regular {pointer 2} {global 2}  }
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_5 int 16 regular {pointer 1} {global 1}  }
	{ p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_1 int 16 regular {pointer 2} {global 2}  }
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_4 int 16 regular {pointer 1} {global 1}  }
	{ p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap int 16 regular {pointer 2} {global 2}  }
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_3 int 16 regular {pointer 1} {global 1}  }
}
set hasAXIMCache 0
set AXIMCacheInstList { }
set C_modelArgMapList {[ 
	{ "Name" : "p_read", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "p_read1", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "p_read2", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "p_read3", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "p_read4", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "p_read5", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "p_read6", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_2", "interface" : "wire", "bitwidth" : 16, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_9", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_1", "interface" : "wire", "bitwidth" : 16, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_8", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel", "interface" : "wire", "bitwidth" : 16, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_7", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_3", "interface" : "wire", "bitwidth" : 16, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_6", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_2", "interface" : "wire", "bitwidth" : 16, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_5", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_1", "interface" : "wire", "bitwidth" : 16, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_4", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap", "interface" : "wire", "bitwidth" : 16, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_3", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 43
set portList { 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ p_read sc_in sc_lv 16 signal 0 } 
	{ p_read1 sc_in sc_lv 16 signal 1 } 
	{ p_read2 sc_in sc_lv 16 signal 2 } 
	{ p_read3 sc_in sc_lv 16 signal 3 } 
	{ p_read4 sc_in sc_lv 16 signal 4 } 
	{ p_read5 sc_in sc_lv 16 signal 5 } 
	{ p_read6 sc_in sc_lv 16 signal 6 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_2_i sc_in sc_lv 16 signal 7 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_2_o sc_out sc_lv 16 signal 7 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_2_o_ap_vld sc_out sc_logic 1 outvld 7 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_9 sc_out sc_lv 16 signal 8 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_9_ap_vld sc_out sc_logic 1 outvld 8 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_1_i sc_in sc_lv 16 signal 9 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_1_o sc_out sc_lv 16 signal 9 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_1_o_ap_vld sc_out sc_logic 1 outvld 9 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_8 sc_out sc_lv 16 signal 10 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_8_ap_vld sc_out sc_logic 1 outvld 10 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_i sc_in sc_lv 16 signal 11 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_o sc_out sc_lv 16 signal 11 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_o_ap_vld sc_out sc_logic 1 outvld 11 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_7 sc_out sc_lv 16 signal 12 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_7_ap_vld sc_out sc_logic 1 outvld 12 } 
	{ p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_3_i sc_in sc_lv 16 signal 13 } 
	{ p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_3_o sc_out sc_lv 16 signal 13 } 
	{ p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_3_o_ap_vld sc_out sc_logic 1 outvld 13 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_6 sc_out sc_lv 16 signal 14 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_6_ap_vld sc_out sc_logic 1 outvld 14 } 
	{ p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_2_i sc_in sc_lv 16 signal 15 } 
	{ p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_2_o sc_out sc_lv 16 signal 15 } 
	{ p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_2_o_ap_vld sc_out sc_logic 1 outvld 15 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_5 sc_out sc_lv 16 signal 16 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_5_ap_vld sc_out sc_logic 1 outvld 16 } 
	{ p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_1_i sc_in sc_lv 16 signal 17 } 
	{ p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_1_o sc_out sc_lv 16 signal 17 } 
	{ p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_1_o_ap_vld sc_out sc_logic 1 outvld 17 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_4 sc_out sc_lv 16 signal 18 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_4_ap_vld sc_out sc_logic 1 outvld 18 } 
	{ p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_i sc_in sc_lv 16 signal 19 } 
	{ p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_o sc_out sc_lv 16 signal 19 } 
	{ p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_o_ap_vld sc_out sc_logic 1 outvld 19 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_3 sc_out sc_lv 16 signal 20 } 
	{ void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_3_ap_vld sc_out sc_logic 1 outvld 20 } 
}
set NewPortList {[ 
	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "p_read", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "p_read", "role": "default" }} , 
 	{ "name": "p_read1", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "p_read1", "role": "default" }} , 
 	{ "name": "p_read2", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "p_read2", "role": "default" }} , 
 	{ "name": "p_read3", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "p_read3", "role": "default" }} , 
 	{ "name": "p_read4", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "p_read4", "role": "default" }} , 
 	{ "name": "p_read5", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "p_read5", "role": "default" }} , 
 	{ "name": "p_read6", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "p_read6", "role": "default" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_2_i", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_2", "role": "i" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_2_o", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_2", "role": "o" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_2_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_2", "role": "o_ap_vld" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_9", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_9", "role": "default" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_9_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_9", "role": "ap_vld" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_1_i", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_1", "role": "i" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_1_o", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_1", "role": "o" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_1_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_1", "role": "o_ap_vld" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_8", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_8", "role": "default" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_8_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_8", "role": "ap_vld" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_i", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel", "role": "i" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_o", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel", "role": "o" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel", "role": "o_ap_vld" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_7", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_7", "role": "default" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_7_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_7", "role": "ap_vld" }} , 
 	{ "name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_3_i", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_3", "role": "i" }} , 
 	{ "name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_3_o", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_3", "role": "o" }} , 
 	{ "name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_3_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_3", "role": "o_ap_vld" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_6", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_6", "role": "default" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_6_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_6", "role": "ap_vld" }} , 
 	{ "name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_2_i", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_2", "role": "i" }} , 
 	{ "name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_2_o", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_2", "role": "o" }} , 
 	{ "name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_2_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_2", "role": "o_ap_vld" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_5", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_5", "role": "default" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_5_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_5", "role": "ap_vld" }} , 
 	{ "name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_1_i", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_1", "role": "i" }} , 
 	{ "name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_1_o", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_1", "role": "o" }} , 
 	{ "name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_1_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_1", "role": "o_ap_vld" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_4", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_4", "role": "default" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_4_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_4", "role": "ap_vld" }} , 
 	{ "name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_i", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap", "role": "i" }} , 
 	{ "name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_o", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap", "role": "o" }} , 
 	{ "name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap", "role": "o_ap_vld" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_3", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_3", "role": "default" }} , 
 	{ "name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_3_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_3", "role": "ap_vld" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "",
		"CDFG" : "shift_line_buffer_array_ap_fixed_16_6_5_3_0_7u_config6_s",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "0", "ap_start" : "0", "ap_ready" : "1", "ap_done" : "0", "ap_continue" : "0", "ap_idle" : "0", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "1",
		"VariableLatency" : "0", "ExactLatency" : "0", "EstimateLatencyMin" : "0", "EstimateLatencyMax" : "0",
		"Combinational" : "1",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "p_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read1", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read2", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read3", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read4", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read5", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_read6", "Type" : "None", "Direction" : "I"},
			{"Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_2", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_9", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_1", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_8", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_7", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_3", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_6", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_2", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_5", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_1", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_4", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_3", "Type" : "Vld", "Direction" : "O"}]}]}


set ArgLastReadFirstWriteLatency {
	shift_line_buffer_array_ap_fixed_16_6_5_3_0_7u_config6_s {
		p_read {Type I LastRead 0 FirstWrite -1}
		p_read1 {Type I LastRead 0 FirstWrite -1}
		p_read2 {Type I LastRead 0 FirstWrite -1}
		p_read3 {Type I LastRead 0 FirstWrite -1}
		p_read4 {Type I LastRead 0 FirstWrite -1}
		p_read5 {Type I LastRead 0 FirstWrite -1}
		p_read6 {Type I LastRead 0 FirstWrite -1}
		void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_2 {Type IO LastRead 0 FirstWrite 0}
		void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_9 {Type O LastRead -1 FirstWrite 0}
		void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_1 {Type IO LastRead 0 FirstWrite 0}
		void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_8 {Type O LastRead -1 FirstWrite 0}
		void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel {Type IO LastRead 0 FirstWrite 0}
		void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_7 {Type O LastRead -1 FirstWrite 0}
		p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_3 {Type IO LastRead 0 FirstWrite 0}
		void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_6 {Type O LastRead -1 FirstWrite 0}
		p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_2 {Type IO LastRead 0 FirstWrite 0}
		void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_5 {Type O LastRead -1 FirstWrite 0}
		p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_1 {Type IO LastRead 0 FirstWrite 0}
		void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_4 {Type O LastRead -1 FirstWrite 0}
		p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap {Type IO LastRead 0 FirstWrite 0}
		void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_3 {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "0", "Max" : "0"}
	, {"Name" : "Interval", "Min" : "1", "Max" : "1"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	p_read { ap_none {  { p_read in_data 0 16 } } }
	p_read1 { ap_none {  { p_read1 in_data 0 16 } } }
	p_read2 { ap_none {  { p_read2 in_data 0 16 } } }
	p_read3 { ap_none {  { p_read3 in_data 0 16 } } }
	p_read4 { ap_none {  { p_read4 in_data 0 16 } } }
	p_read5 { ap_none {  { p_read5 in_data 0 16 } } }
	p_read6 { ap_none {  { p_read6 in_data 0 16 } } }
	void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_2 { ap_ovld {  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_2_i in_data 0 16 }  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_2_o out_data 1 16 }  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_2_o_ap_vld out_vld 1 1 } } }
	void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_9 { ap_vld {  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_9 out_data 1 16 }  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_9_ap_vld out_vld 1 1 } } }
	void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_1 { ap_ovld {  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_1_i in_data 0 16 }  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_1_o out_data 1 16 }  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_1_o_ap_vld out_vld 1 1 } } }
	void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_8 { ap_vld {  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_8 out_data 1 16 }  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_8_ap_vld out_vld 1 1 } } }
	void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel { ap_ovld {  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_i in_data 0 16 }  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_o out_data 1 16 }  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_o_ap_vld out_vld 1 1 } } }
	void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_7 { ap_vld {  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_7 out_data 1 16 }  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_7_ap_vld out_vld 1 1 } } }
	p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_3 { ap_ovld {  { p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_3_i in_data 0 16 }  { p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_3_o out_data 1 16 }  { p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_3_o_ap_vld out_vld 1 1 } } }
	void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_6 { ap_vld {  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_6 out_data 1 16 }  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_6_ap_vld out_vld 1 1 } } }
	p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_2 { ap_ovld {  { p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_2_i in_data 0 16 }  { p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_2_o out_data 1 16 }  { p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_2_o_ap_vld out_vld 1 1 } } }
	void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_5 { ap_vld {  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_5 out_data 1 16 }  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_5_ap_vld out_vld 1 1 } } }
	p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_1 { ap_ovld {  { p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_1_i in_data 0 16 }  { p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_1_o out_data 1 16 }  { p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_1_o_ap_vld out_vld 1 1 } } }
	void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_4 { ap_vld {  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_4 out_data 1 16 }  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_4_ap_vld out_vld 1 1 } } }
	p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap { ap_ovld {  { p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_i in_data 0 16 }  { p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_o out_data 1 16 }  { p_ZZN4nnet22compute_pool_buffer_2dINS_5arrayI8ap_fixedILi16ELi6EL9ap_q_mode5EL9ap_o_ap_vld out_vld 1 1 } } }
	void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_3 { ap_vld {  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_3 out_data 1 16 }  { void_compute_pool_buffer_2d_array_const_ap_shift_reg_n_filt_stream_kernel_3_ap_vld out_vld 1 1 } } }
}
