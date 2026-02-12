# This script segment is generated automatically by AutoPilot

set name cnn_core_mul_12s_8ns_20_1_0
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


set name cnn_core_mul_12s_7ns_19_1_0
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


set name cnn_core_mul_12s_7s_19_1_0
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


set name cnn_core_mul_12s_9ns_20_1_0
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


set name cnn_core_mul_12s_8s_20_1_0
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


set name cnn_core_mul_12s_9s_20_1_0
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


set name cnn_core_mul_12s_6s_18_1_0
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2348 \
    name void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_4 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_4 \
    op interface \
    ports { void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_4 { I 12 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2349 \
    name void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_3 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_3 \
    op interface \
    ports { void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_3 { I 12 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2350 \
    name void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_2 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_2 \
    op interface \
    ports { void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_2 { I 12 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2351 \
    name void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_1 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_1 \
    op interface \
    ports { void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data_1 { I 12 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2352 \
    name void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data \
    op interface \
    ports { void_compute_output_buffer_1d_array_const_stream_weight_t_bias_t_kernel_data { I 12 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_return \
    type ap_return \
    reset_level 1 \
    sync_rst true \
    corename ap_return \
    op interface \
    ports { ap_return { O 1 vector } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -2 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -3 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_rst \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_ce
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_ce] == "cg_default_interface_gen_ce"} {
eval "cg_default_interface_gen_ce { \
    id -4 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_ce \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


