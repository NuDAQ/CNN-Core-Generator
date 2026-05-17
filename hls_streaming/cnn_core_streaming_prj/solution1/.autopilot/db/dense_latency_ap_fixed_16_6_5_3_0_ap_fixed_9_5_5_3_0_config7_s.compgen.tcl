# This script segment is generated automatically by AutoPilot

set name cnn_core_mul_16s_5ns_19_1_1
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


set name cnn_core_mul_16s_6ns_19_1_1
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
    id 850 \
    name data_1_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1_val \
    op interface \
    ports { data_1_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 851 \
    name data_2_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_2_val \
    op interface \
    ports { data_2_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 852 \
    name data_5_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_5_val \
    op interface \
    ports { data_5_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 853 \
    name data_6_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_6_val \
    op interface \
    ports { data_6_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 854 \
    name data_8_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_8_val \
    op interface \
    ports { data_8_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 855 \
    name data_9_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_9_val \
    op interface \
    ports { data_9_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 856 \
    name data_12_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_12_val \
    op interface \
    ports { data_12_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 857 \
    name data_13_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_13_val \
    op interface \
    ports { data_13_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 858 \
    name data_15_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_15_val \
    op interface \
    ports { data_15_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 859 \
    name data_16_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_16_val \
    op interface \
    ports { data_16_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 860 \
    name data_19_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_19_val \
    op interface \
    ports { data_19_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 861 \
    name data_20_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_20_val \
    op interface \
    ports { data_20_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 862 \
    name data_22_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_22_val \
    op interface \
    ports { data_22_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 863 \
    name data_23_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_23_val \
    op interface \
    ports { data_23_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 864 \
    name data_26_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_26_val \
    op interface \
    ports { data_26_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 865 \
    name data_27_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_27_val \
    op interface \
    ports { data_27_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 866 \
    name data_29_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_29_val \
    op interface \
    ports { data_29_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 867 \
    name data_30_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_30_val \
    op interface \
    ports { data_30_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 868 \
    name data_33_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_33_val \
    op interface \
    ports { data_33_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 869 \
    name data_34_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_34_val \
    op interface \
    ports { data_34_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 870 \
    name data_36_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_36_val \
    op interface \
    ports { data_36_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 871 \
    name data_37_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_37_val \
    op interface \
    ports { data_37_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 872 \
    name data_40_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_40_val \
    op interface \
    ports { data_40_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 873 \
    name data_41_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_41_val \
    op interface \
    ports { data_41_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 874 \
    name data_43_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_43_val \
    op interface \
    ports { data_43_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 875 \
    name data_44_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_44_val \
    op interface \
    ports { data_44_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 876 \
    name data_47_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_47_val \
    op interface \
    ports { data_47_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 877 \
    name data_48_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_48_val \
    op interface \
    ports { data_48_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 878 \
    name data_50_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_50_val \
    op interface \
    ports { data_50_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 879 \
    name data_51_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_51_val \
    op interface \
    ports { data_51_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 880 \
    name data_52_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_52_val \
    op interface \
    ports { data_52_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 881 \
    name data_54_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_54_val \
    op interface \
    ports { data_54_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 882 \
    name data_55_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_55_val \
    op interface \
    ports { data_55_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 883 \
    name data_56_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_56_val \
    op interface \
    ports { data_56_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 884 \
    name data_57_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_57_val \
    op interface \
    ports { data_57_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 885 \
    name data_58_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_58_val \
    op interface \
    ports { data_58_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 886 \
    name data_61_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_61_val \
    op interface \
    ports { data_61_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 887 \
    name data_62_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_62_val \
    op interface \
    ports { data_62_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 888 \
    name data_64_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_64_val \
    op interface \
    ports { data_64_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 889 \
    name data_65_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_65_val \
    op interface \
    ports { data_65_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 890 \
    name data_68_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_68_val \
    op interface \
    ports { data_68_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 891 \
    name data_69_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_69_val \
    op interface \
    ports { data_69_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 892 \
    name data_70_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_70_val \
    op interface \
    ports { data_70_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 893 \
    name data_71_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_71_val \
    op interface \
    ports { data_71_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 894 \
    name data_72_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_72_val \
    op interface \
    ports { data_72_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 895 \
    name data_75_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_75_val \
    op interface \
    ports { data_75_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 896 \
    name data_76_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_76_val \
    op interface \
    ports { data_76_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 897 \
    name data_78_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_78_val \
    op interface \
    ports { data_78_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 898 \
    name data_79_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_79_val \
    op interface \
    ports { data_79_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 899 \
    name data_82_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_82_val \
    op interface \
    ports { data_82_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 900 \
    name data_83_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_83_val \
    op interface \
    ports { data_83_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 901 \
    name data_85_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_85_val \
    op interface \
    ports { data_85_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 902 \
    name data_86_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_86_val \
    op interface \
    ports { data_86_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 903 \
    name data_89_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_89_val \
    op interface \
    ports { data_89_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 904 \
    name data_90_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_90_val \
    op interface \
    ports { data_90_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 905 \
    name data_92_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_92_val \
    op interface \
    ports { data_92_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 906 \
    name data_93_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_93_val \
    op interface \
    ports { data_93_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 907 \
    name data_96_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_96_val \
    op interface \
    ports { data_96_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 908 \
    name data_97_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_97_val \
    op interface \
    ports { data_97_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 909 \
    name data_99_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_99_val \
    op interface \
    ports { data_99_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 910 \
    name data_100_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_100_val \
    op interface \
    ports { data_100_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 911 \
    name data_103_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_103_val \
    op interface \
    ports { data_103_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 912 \
    name data_104_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_104_val \
    op interface \
    ports { data_104_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 913 \
    name data_105_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_105_val \
    op interface \
    ports { data_105_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 914 \
    name data_106_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_106_val \
    op interface \
    ports { data_106_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 915 \
    name data_107_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_107_val \
    op interface \
    ports { data_107_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 916 \
    name data_110_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_110_val \
    op interface \
    ports { data_110_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 917 \
    name data_111_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_111_val \
    op interface \
    ports { data_111_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 918 \
    name data_113_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_113_val \
    op interface \
    ports { data_113_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 919 \
    name data_114_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_114_val \
    op interface \
    ports { data_114_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 920 \
    name data_115_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_115_val \
    op interface \
    ports { data_115_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 921 \
    name data_117_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_117_val \
    op interface \
    ports { data_117_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 922 \
    name data_118_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_118_val \
    op interface \
    ports { data_118_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 923 \
    name data_119_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_119_val \
    op interface \
    ports { data_119_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 924 \
    name data_120_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_120_val \
    op interface \
    ports { data_120_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 925 \
    name data_121_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_121_val \
    op interface \
    ports { data_121_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 926 \
    name data_123_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_123_val \
    op interface \
    ports { data_123_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 927 \
    name data_124_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_124_val \
    op interface \
    ports { data_124_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 928 \
    name data_125_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_125_val \
    op interface \
    ports { data_125_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 929 \
    name data_127_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_127_val \
    op interface \
    ports { data_127_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 930 \
    name data_128_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_128_val \
    op interface \
    ports { data_128_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 931 \
    name data_131_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_131_val \
    op interface \
    ports { data_131_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 932 \
    name data_132_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_132_val \
    op interface \
    ports { data_132_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 933 \
    name data_134_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_134_val \
    op interface \
    ports { data_134_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 934 \
    name data_135_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_135_val \
    op interface \
    ports { data_135_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 935 \
    name data_138_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_138_val \
    op interface \
    ports { data_138_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 936 \
    name data_139_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_139_val \
    op interface \
    ports { data_139_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 937 \
    name data_141_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_141_val \
    op interface \
    ports { data_141_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 938 \
    name data_142_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_142_val \
    op interface \
    ports { data_142_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 939 \
    name data_144_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_144_val \
    op interface \
    ports { data_144_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 940 \
    name data_145_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_145_val \
    op interface \
    ports { data_145_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 941 \
    name data_146_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_146_val \
    op interface \
    ports { data_146_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 942 \
    name data_148_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_148_val \
    op interface \
    ports { data_148_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 943 \
    name data_149_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_149_val \
    op interface \
    ports { data_149_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 944 \
    name data_152_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_152_val \
    op interface \
    ports { data_152_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 945 \
    name data_153_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_153_val \
    op interface \
    ports { data_153_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 946 \
    name data_155_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_155_val \
    op interface \
    ports { data_155_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 947 \
    name data_156_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_156_val \
    op interface \
    ports { data_156_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 948 \
    name data_159_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_159_val \
    op interface \
    ports { data_159_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 949 \
    name data_160_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_160_val \
    op interface \
    ports { data_160_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 950 \
    name data_162_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_162_val \
    op interface \
    ports { data_162_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 951 \
    name data_163_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_163_val \
    op interface \
    ports { data_163_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 952 \
    name data_166_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_166_val \
    op interface \
    ports { data_166_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 953 \
    name data_167_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_167_val \
    op interface \
    ports { data_167_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 954 \
    name data_169_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_169_val \
    op interface \
    ports { data_169_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 955 \
    name data_170_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_170_val \
    op interface \
    ports { data_170_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 956 \
    name data_171_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_171_val \
    op interface \
    ports { data_171_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 957 \
    name data_173_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_173_val \
    op interface \
    ports { data_173_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 958 \
    name data_174_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_174_val \
    op interface \
    ports { data_174_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 959 \
    name data_176_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_176_val \
    op interface \
    ports { data_176_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 960 \
    name data_177_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_177_val \
    op interface \
    ports { data_177_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 961 \
    name data_180_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_180_val \
    op interface \
    ports { data_180_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 962 \
    name data_181_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_181_val \
    op interface \
    ports { data_181_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 963 \
    name data_183_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_183_val \
    op interface \
    ports { data_183_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 964 \
    name data_184_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_184_val \
    op interface \
    ports { data_184_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 965 \
    name data_187_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_187_val \
    op interface \
    ports { data_187_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 966 \
    name data_188_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_188_val \
    op interface \
    ports { data_188_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 967 \
    name data_190_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_190_val \
    op interface \
    ports { data_190_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 968 \
    name data_191_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_191_val \
    op interface \
    ports { data_191_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 969 \
    name data_194_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_194_val \
    op interface \
    ports { data_194_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 970 \
    name data_195_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_195_val \
    op interface \
    ports { data_195_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 971 \
    name data_197_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_197_val \
    op interface \
    ports { data_197_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 972 \
    name data_198_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_198_val \
    op interface \
    ports { data_198_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 973 \
    name data_201_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_201_val \
    op interface \
    ports { data_201_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 974 \
    name data_202_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_202_val \
    op interface \
    ports { data_202_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 975 \
    name data_204_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_204_val \
    op interface \
    ports { data_204_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 976 \
    name data_205_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_205_val \
    op interface \
    ports { data_205_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 977 \
    name data_208_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_208_val \
    op interface \
    ports { data_208_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 978 \
    name data_209_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_209_val \
    op interface \
    ports { data_209_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 979 \
    name data_211_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_211_val \
    op interface \
    ports { data_211_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 980 \
    name data_212_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_212_val \
    op interface \
    ports { data_212_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 981 \
    name data_215_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_215_val \
    op interface \
    ports { data_215_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 982 \
    name data_216_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_216_val \
    op interface \
    ports { data_216_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 983 \
    name data_217_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_217_val \
    op interface \
    ports { data_217_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 984 \
    name data_218_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_218_val \
    op interface \
    ports { data_218_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 985 \
    name data_219_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_219_val \
    op interface \
    ports { data_219_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 986 \
    name data_222_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_222_val \
    op interface \
    ports { data_222_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 987 \
    name data_223_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_223_val \
    op interface \
    ports { data_223_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 988 \
    name data_224_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_224_val \
    op interface \
    ports { data_224_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 989 \
    name data_226_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_226_val \
    op interface \
    ports { data_226_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 990 \
    name data_229_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_229_val \
    op interface \
    ports { data_229_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 991 \
    name data_230_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_230_val \
    op interface \
    ports { data_230_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 992 \
    name data_231_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_231_val \
    op interface \
    ports { data_231_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 993 \
    name data_232_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_232_val \
    op interface \
    ports { data_232_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 994 \
    name data_236_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_236_val \
    op interface \
    ports { data_236_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 995 \
    name data_237_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_237_val \
    op interface \
    ports { data_237_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 996 \
    name data_238_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_238_val \
    op interface \
    ports { data_238_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 997 \
    name data_239_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_239_val \
    op interface \
    ports { data_239_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 998 \
    name data_240_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_240_val \
    op interface \
    ports { data_240_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 999 \
    name data_243_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_243_val \
    op interface \
    ports { data_243_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1000 \
    name data_244_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_244_val \
    op interface \
    ports { data_244_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1001 \
    name data_247_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_247_val \
    op interface \
    ports { data_247_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1002 \
    name data_249_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_249_val \
    op interface \
    ports { data_249_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1003 \
    name data_250_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_250_val \
    op interface \
    ports { data_250_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1004 \
    name data_251_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_251_val \
    op interface \
    ports { data_251_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1005 \
    name data_252_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_252_val \
    op interface \
    ports { data_252_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1006 \
    name data_253_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_253_val \
    op interface \
    ports { data_253_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1007 \
    name data_254_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_254_val \
    op interface \
    ports { data_254_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1008 \
    name data_255_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_255_val \
    op interface \
    ports { data_255_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1009 \
    name data_256_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_256_val \
    op interface \
    ports { data_256_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1010 \
    name data_257_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_257_val \
    op interface \
    ports { data_257_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1011 \
    name data_258_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_258_val \
    op interface \
    ports { data_258_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1012 \
    name data_259_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_259_val \
    op interface \
    ports { data_259_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1013 \
    name data_260_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_260_val \
    op interface \
    ports { data_260_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1014 \
    name data_261_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_261_val \
    op interface \
    ports { data_261_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1015 \
    name data_262_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_262_val \
    op interface \
    ports { data_262_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1016 \
    name data_263_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_263_val \
    op interface \
    ports { data_263_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1017 \
    name data_264_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_264_val \
    op interface \
    ports { data_264_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1018 \
    name data_265_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_265_val \
    op interface \
    ports { data_265_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1019 \
    name data_267_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_267_val \
    op interface \
    ports { data_267_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1020 \
    name data_268_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_268_val \
    op interface \
    ports { data_268_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1021 \
    name data_269_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_269_val \
    op interface \
    ports { data_269_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1022 \
    name data_270_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_270_val \
    op interface \
    ports { data_270_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1023 \
    name data_271_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_271_val \
    op interface \
    ports { data_271_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1024 \
    name data_272_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_272_val \
    op interface \
    ports { data_272_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1025 \
    name data_274_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_274_val \
    op interface \
    ports { data_274_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1026 \
    name data_275_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_275_val \
    op interface \
    ports { data_275_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1027 \
    name data_276_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_276_val \
    op interface \
    ports { data_276_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1028 \
    name data_277_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_277_val \
    op interface \
    ports { data_277_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1029 \
    name data_278_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_278_val \
    op interface \
    ports { data_278_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1030 \
    name data_279_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_279_val \
    op interface \
    ports { data_279_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1031 \
    name data_280_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_280_val \
    op interface \
    ports { data_280_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1032 \
    name data_281_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_281_val \
    op interface \
    ports { data_281_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1033 \
    name data_282_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_282_val \
    op interface \
    ports { data_282_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1034 \
    name data_283_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_283_val \
    op interface \
    ports { data_283_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1035 \
    name data_284_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_284_val \
    op interface \
    ports { data_284_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1036 \
    name data_285_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_285_val \
    op interface \
    ports { data_285_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1037 \
    name data_286_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_286_val \
    op interface \
    ports { data_286_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1038 \
    name data_287_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_287_val \
    op interface \
    ports { data_287_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1039 \
    name data_288_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_288_val \
    op interface \
    ports { data_288_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1040 \
    name data_289_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_289_val \
    op interface \
    ports { data_289_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1041 \
    name data_290_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_290_val \
    op interface \
    ports { data_290_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1042 \
    name data_291_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_291_val \
    op interface \
    ports { data_291_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1043 \
    name data_292_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_292_val \
    op interface \
    ports { data_292_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1044 \
    name data_293_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_293_val \
    op interface \
    ports { data_293_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1045 \
    name data_294_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_294_val \
    op interface \
    ports { data_294_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1046 \
    name data_295_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_295_val \
    op interface \
    ports { data_295_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1047 \
    name data_296_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_296_val \
    op interface \
    ports { data_296_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1048 \
    name data_297_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_297_val \
    op interface \
    ports { data_297_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1049 \
    name data_298_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_298_val \
    op interface \
    ports { data_298_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1050 \
    name data_299_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_299_val \
    op interface \
    ports { data_299_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1051 \
    name data_300_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_300_val \
    op interface \
    ports { data_300_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1052 \
    name data_301_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_301_val \
    op interface \
    ports { data_301_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1053 \
    name data_302_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_302_val \
    op interface \
    ports { data_302_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1054 \
    name data_303_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_303_val \
    op interface \
    ports { data_303_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1055 \
    name data_304_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_304_val \
    op interface \
    ports { data_304_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1056 \
    name data_305_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_305_val \
    op interface \
    ports { data_305_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1057 \
    name data_306_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_306_val \
    op interface \
    ports { data_306_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1058 \
    name data_307_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_307_val \
    op interface \
    ports { data_307_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1059 \
    name data_308_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_308_val \
    op interface \
    ports { data_308_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1060 \
    name data_309_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_309_val \
    op interface \
    ports { data_309_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1061 \
    name data_310_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_310_val \
    op interface \
    ports { data_310_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1062 \
    name data_311_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_311_val \
    op interface \
    ports { data_311_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1063 \
    name data_312_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_312_val \
    op interface \
    ports { data_312_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1064 \
    name data_313_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_313_val \
    op interface \
    ports { data_313_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1065 \
    name data_314_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_314_val \
    op interface \
    ports { data_314_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1066 \
    name data_315_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_315_val \
    op interface \
    ports { data_315_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1067 \
    name data_316_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_316_val \
    op interface \
    ports { data_316_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1068 \
    name data_317_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_317_val \
    op interface \
    ports { data_317_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1069 \
    name data_318_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_318_val \
    op interface \
    ports { data_318_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1070 \
    name data_319_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_319_val \
    op interface \
    ports { data_319_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1071 \
    name data_320_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_320_val \
    op interface \
    ports { data_320_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1072 \
    name data_321_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_321_val \
    op interface \
    ports { data_321_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1073 \
    name data_322_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_322_val \
    op interface \
    ports { data_322_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1074 \
    name data_323_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_323_val \
    op interface \
    ports { data_323_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1075 \
    name data_324_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_324_val \
    op interface \
    ports { data_324_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1076 \
    name data_325_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_325_val \
    op interface \
    ports { data_325_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1077 \
    name data_326_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_326_val \
    op interface \
    ports { data_326_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1078 \
    name data_327_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_327_val \
    op interface \
    ports { data_327_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1079 \
    name data_328_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_328_val \
    op interface \
    ports { data_328_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1080 \
    name data_329_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_329_val \
    op interface \
    ports { data_329_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1081 \
    name data_330_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_330_val \
    op interface \
    ports { data_330_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1082 \
    name data_331_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_331_val \
    op interface \
    ports { data_331_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1083 \
    name data_332_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_332_val \
    op interface \
    ports { data_332_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1084 \
    name data_333_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_333_val \
    op interface \
    ports { data_333_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1085 \
    name data_334_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_334_val \
    op interface \
    ports { data_334_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1086 \
    name data_335_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_335_val \
    op interface \
    ports { data_335_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1087 \
    name data_336_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_336_val \
    op interface \
    ports { data_336_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1088 \
    name data_337_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_337_val \
    op interface \
    ports { data_337_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1089 \
    name data_338_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_338_val \
    op interface \
    ports { data_338_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1090 \
    name data_339_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_339_val \
    op interface \
    ports { data_339_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1091 \
    name data_340_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_340_val \
    op interface \
    ports { data_340_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1092 \
    name data_341_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_341_val \
    op interface \
    ports { data_341_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1093 \
    name data_342_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_342_val \
    op interface \
    ports { data_342_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1094 \
    name data_343_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_343_val \
    op interface \
    ports { data_343_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1095 \
    name data_344_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_344_val \
    op interface \
    ports { data_344_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1096 \
    name data_345_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_345_val \
    op interface \
    ports { data_345_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1097 \
    name data_346_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_346_val \
    op interface \
    ports { data_346_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1098 \
    name data_347_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_347_val \
    op interface \
    ports { data_347_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1099 \
    name data_348_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_348_val \
    op interface \
    ports { data_348_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1100 \
    name data_349_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_349_val \
    op interface \
    ports { data_349_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1101 \
    name data_350_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_350_val \
    op interface \
    ports { data_350_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1102 \
    name data_351_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_351_val \
    op interface \
    ports { data_351_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1103 \
    name data_352_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_352_val \
    op interface \
    ports { data_352_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1104 \
    name data_353_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_353_val \
    op interface \
    ports { data_353_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1105 \
    name data_354_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_354_val \
    op interface \
    ports { data_354_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1106 \
    name data_355_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_355_val \
    op interface \
    ports { data_355_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1107 \
    name data_356_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_356_val \
    op interface \
    ports { data_356_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1108 \
    name data_357_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_357_val \
    op interface \
    ports { data_357_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1109 \
    name data_358_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_358_val \
    op interface \
    ports { data_358_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1110 \
    name data_359_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_359_val \
    op interface \
    ports { data_359_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1111 \
    name data_360_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_360_val \
    op interface \
    ports { data_360_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1112 \
    name data_361_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_361_val \
    op interface \
    ports { data_361_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1113 \
    name data_362_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_362_val \
    op interface \
    ports { data_362_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1114 \
    name data_363_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_363_val \
    op interface \
    ports { data_363_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1115 \
    name data_364_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_364_val \
    op interface \
    ports { data_364_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1116 \
    name data_365_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_365_val \
    op interface \
    ports { data_365_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1117 \
    name data_366_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_366_val \
    op interface \
    ports { data_366_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1118 \
    name data_367_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_367_val \
    op interface \
    ports { data_367_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1119 \
    name data_368_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_368_val \
    op interface \
    ports { data_368_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1120 \
    name data_369_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_369_val \
    op interface \
    ports { data_369_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1121 \
    name data_370_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_370_val \
    op interface \
    ports { data_370_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1122 \
    name data_371_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_371_val \
    op interface \
    ports { data_371_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1123 \
    name data_372_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_372_val \
    op interface \
    ports { data_372_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1124 \
    name data_373_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_373_val \
    op interface \
    ports { data_373_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1125 \
    name data_374_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_374_val \
    op interface \
    ports { data_374_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1126 \
    name data_375_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_375_val \
    op interface \
    ports { data_375_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1127 \
    name data_376_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_376_val \
    op interface \
    ports { data_376_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1128 \
    name data_377_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_377_val \
    op interface \
    ports { data_377_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1129 \
    name data_378_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_378_val \
    op interface \
    ports { data_378_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1130 \
    name data_380_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_380_val \
    op interface \
    ports { data_380_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1131 \
    name data_381_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_381_val \
    op interface \
    ports { data_381_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1132 \
    name data_382_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_382_val \
    op interface \
    ports { data_382_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1133 \
    name data_383_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_383_val \
    op interface \
    ports { data_383_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1134 \
    name data_384_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_384_val \
    op interface \
    ports { data_384_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1135 \
    name data_385_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_385_val \
    op interface \
    ports { data_385_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1136 \
    name data_386_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_386_val \
    op interface \
    ports { data_386_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1137 \
    name data_387_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_387_val \
    op interface \
    ports { data_387_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1138 \
    name data_388_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_388_val \
    op interface \
    ports { data_388_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1139 \
    name data_389_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_389_val \
    op interface \
    ports { data_389_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1140 \
    name data_390_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_390_val \
    op interface \
    ports { data_390_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1141 \
    name data_392_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_392_val \
    op interface \
    ports { data_392_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1142 \
    name data_393_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_393_val \
    op interface \
    ports { data_393_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1143 \
    name data_394_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_394_val \
    op interface \
    ports { data_394_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1144 \
    name data_395_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_395_val \
    op interface \
    ports { data_395_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1145 \
    name data_396_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_396_val \
    op interface \
    ports { data_396_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1146 \
    name data_398_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_398_val \
    op interface \
    ports { data_398_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1147 \
    name data_399_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_399_val \
    op interface \
    ports { data_399_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1148 \
    name data_400_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_400_val \
    op interface \
    ports { data_400_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1149 \
    name data_401_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_401_val \
    op interface \
    ports { data_401_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1150 \
    name data_402_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_402_val \
    op interface \
    ports { data_402_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1151 \
    name data_403_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_403_val \
    op interface \
    ports { data_403_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1152 \
    name data_405_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_405_val \
    op interface \
    ports { data_405_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1153 \
    name data_406_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_406_val \
    op interface \
    ports { data_406_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1154 \
    name data_407_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_407_val \
    op interface \
    ports { data_407_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1155 \
    name data_408_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_408_val \
    op interface \
    ports { data_408_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1156 \
    name data_409_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_409_val \
    op interface \
    ports { data_409_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1157 \
    name data_410_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_410_val \
    op interface \
    ports { data_410_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1158 \
    name data_412_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_412_val \
    op interface \
    ports { data_412_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1159 \
    name data_413_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_413_val \
    op interface \
    ports { data_413_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1160 \
    name data_414_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_414_val \
    op interface \
    ports { data_414_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1161 \
    name data_415_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_415_val \
    op interface \
    ports { data_415_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1162 \
    name data_416_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_416_val \
    op interface \
    ports { data_416_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1163 \
    name data_417_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_417_val \
    op interface \
    ports { data_417_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1164 \
    name data_419_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_419_val \
    op interface \
    ports { data_419_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1165 \
    name data_420_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_420_val \
    op interface \
    ports { data_420_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1166 \
    name data_421_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_421_val \
    op interface \
    ports { data_421_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1167 \
    name data_422_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_422_val \
    op interface \
    ports { data_422_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1168 \
    name data_423_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_423_val \
    op interface \
    ports { data_423_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1169 \
    name data_425_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_425_val \
    op interface \
    ports { data_425_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1170 \
    name data_426_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_426_val \
    op interface \
    ports { data_426_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1171 \
    name data_427_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_427_val \
    op interface \
    ports { data_427_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1172 \
    name data_428_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_428_val \
    op interface \
    ports { data_428_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1173 \
    name data_429_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_429_val \
    op interface \
    ports { data_429_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1174 \
    name data_430_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_430_val \
    op interface \
    ports { data_430_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1175 \
    name data_433_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_433_val \
    op interface \
    ports { data_433_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1176 \
    name data_434_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_434_val \
    op interface \
    ports { data_434_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1177 \
    name data_435_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_435_val \
    op interface \
    ports { data_435_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1178 \
    name data_436_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_436_val \
    op interface \
    ports { data_436_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1179 \
    name data_437_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_437_val \
    op interface \
    ports { data_437_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1180 \
    name data_440_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_440_val \
    op interface \
    ports { data_440_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1181 \
    name data_441_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_441_val \
    op interface \
    ports { data_441_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1182 \
    name data_442_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_442_val \
    op interface \
    ports { data_442_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1183 \
    name data_443_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_443_val \
    op interface \
    ports { data_443_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1184 \
    name data_444_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_444_val \
    op interface \
    ports { data_444_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1185 \
    name data_446_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_446_val \
    op interface \
    ports { data_446_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1186 \
    name data_447_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_447_val \
    op interface \
    ports { data_447_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1187 \
    name data_449_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_449_val \
    op interface \
    ports { data_449_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1188 \
    name data_450_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_450_val \
    op interface \
    ports { data_450_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1189 \
    name data_451_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_451_val \
    op interface \
    ports { data_451_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1190 \
    name data_453_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_453_val \
    op interface \
    ports { data_453_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1191 \
    name data_454_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_454_val \
    op interface \
    ports { data_454_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1192 \
    name data_456_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_456_val \
    op interface \
    ports { data_456_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1193 \
    name data_457_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_457_val \
    op interface \
    ports { data_457_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1194 \
    name data_458_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_458_val \
    op interface \
    ports { data_458_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1195 \
    name data_460_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_460_val \
    op interface \
    ports { data_460_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1196 \
    name data_461_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_461_val \
    op interface \
    ports { data_461_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1197 \
    name data_462_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_462_val \
    op interface \
    ports { data_462_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1198 \
    name data_463_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_463_val \
    op interface \
    ports { data_463_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1199 \
    name data_464_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_464_val \
    op interface \
    ports { data_464_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1200 \
    name data_467_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_467_val \
    op interface \
    ports { data_467_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1201 \
    name data_468_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_468_val \
    op interface \
    ports { data_468_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1202 \
    name data_469_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_469_val \
    op interface \
    ports { data_469_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1203 \
    name data_470_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_470_val \
    op interface \
    ports { data_470_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1204 \
    name data_471_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_471_val \
    op interface \
    ports { data_471_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1205 \
    name data_474_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_474_val \
    op interface \
    ports { data_474_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1206 \
    name data_475_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_475_val \
    op interface \
    ports { data_475_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1207 \
    name data_477_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_477_val \
    op interface \
    ports { data_477_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1208 \
    name data_478_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_478_val \
    op interface \
    ports { data_478_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1209 \
    name data_481_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_481_val \
    op interface \
    ports { data_481_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1210 \
    name data_482_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_482_val \
    op interface \
    ports { data_482_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1211 \
    name data_484_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_484_val \
    op interface \
    ports { data_484_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1212 \
    name data_485_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_485_val \
    op interface \
    ports { data_485_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1213 \
    name data_488_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_488_val \
    op interface \
    ports { data_488_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1214 \
    name data_489_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_489_val \
    op interface \
    ports { data_489_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1215 \
    name data_491_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_491_val \
    op interface \
    ports { data_491_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1216 \
    name data_492_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_492_val \
    op interface \
    ports { data_492_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1217 \
    name data_495_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_495_val \
    op interface \
    ports { data_495_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1218 \
    name data_496_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_496_val \
    op interface \
    ports { data_496_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1219 \
    name data_498_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_498_val \
    op interface \
    ports { data_498_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1220 \
    name data_499_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_499_val \
    op interface \
    ports { data_499_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1221 \
    name data_502_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_502_val \
    op interface \
    ports { data_502_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1222 \
    name data_503_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_503_val \
    op interface \
    ports { data_503_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1223 \
    name data_505_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_505_val \
    op interface \
    ports { data_505_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1224 \
    name data_506_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_506_val \
    op interface \
    ports { data_506_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1225 \
    name data_509_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_509_val \
    op interface \
    ports { data_509_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1226 \
    name data_510_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_510_val \
    op interface \
    ports { data_510_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1227 \
    name data_512_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_512_val \
    op interface \
    ports { data_512_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1228 \
    name data_513_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_513_val \
    op interface \
    ports { data_513_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1229 \
    name data_516_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_516_val \
    op interface \
    ports { data_516_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1230 \
    name data_517_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_517_val \
    op interface \
    ports { data_517_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1231 \
    name data_519_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_519_val \
    op interface \
    ports { data_519_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1232 \
    name data_520_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_520_val \
    op interface \
    ports { data_520_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1233 \
    name data_523_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_523_val \
    op interface \
    ports { data_523_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1234 \
    name data_524_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_524_val \
    op interface \
    ports { data_524_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1235 \
    name data_525_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_525_val \
    op interface \
    ports { data_525_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1236 \
    name data_526_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_526_val \
    op interface \
    ports { data_526_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1237 \
    name data_527_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_527_val \
    op interface \
    ports { data_527_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1238 \
    name data_529_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_529_val \
    op interface \
    ports { data_529_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1239 \
    name data_530_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_530_val \
    op interface \
    ports { data_530_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1240 \
    name data_531_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_531_val \
    op interface \
    ports { data_531_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1241 \
    name data_533_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_533_val \
    op interface \
    ports { data_533_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1242 \
    name data_534_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_534_val \
    op interface \
    ports { data_534_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1243 \
    name data_537_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_537_val \
    op interface \
    ports { data_537_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1244 \
    name data_538_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_538_val \
    op interface \
    ports { data_538_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1245 \
    name data_540_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_540_val \
    op interface \
    ports { data_540_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1246 \
    name data_541_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_541_val \
    op interface \
    ports { data_541_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1247 \
    name data_544_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_544_val \
    op interface \
    ports { data_544_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1248 \
    name data_545_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_545_val \
    op interface \
    ports { data_545_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1249 \
    name data_546_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_546_val \
    op interface \
    ports { data_546_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1250 \
    name data_547_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_547_val \
    op interface \
    ports { data_547_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1251 \
    name data_548_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_548_val \
    op interface \
    ports { data_548_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1252 \
    name data_550_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_550_val \
    op interface \
    ports { data_550_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1253 \
    name data_551_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_551_val \
    op interface \
    ports { data_551_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1254 \
    name data_552_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_552_val \
    op interface \
    ports { data_552_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1255 \
    name data_553_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_553_val \
    op interface \
    ports { data_553_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1256 \
    name data_554_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_554_val \
    op interface \
    ports { data_554_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1257 \
    name data_555_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_555_val \
    op interface \
    ports { data_555_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1258 \
    name data_558_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_558_val \
    op interface \
    ports { data_558_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1259 \
    name data_559_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_559_val \
    op interface \
    ports { data_559_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1260 \
    name data_561_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_561_val \
    op interface \
    ports { data_561_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1261 \
    name data_562_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_562_val \
    op interface \
    ports { data_562_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1262 \
    name data_565_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_565_val \
    op interface \
    ports { data_565_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1263 \
    name data_566_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_566_val \
    op interface \
    ports { data_566_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1264 \
    name data_568_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_568_val \
    op interface \
    ports { data_568_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1265 \
    name data_569_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_569_val \
    op interface \
    ports { data_569_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1266 \
    name data_572_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_572_val \
    op interface \
    ports { data_572_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1267 \
    name data_573_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_573_val \
    op interface \
    ports { data_573_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1268 \
    name data_575_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_575_val \
    op interface \
    ports { data_575_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1269 \
    name data_576_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_576_val \
    op interface \
    ports { data_576_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1270 \
    name data_579_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_579_val \
    op interface \
    ports { data_579_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1271 \
    name data_580_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_580_val \
    op interface \
    ports { data_580_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1272 \
    name data_582_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_582_val \
    op interface \
    ports { data_582_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1273 \
    name data_583_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_583_val \
    op interface \
    ports { data_583_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1274 \
    name data_584_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_584_val \
    op interface \
    ports { data_584_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1275 \
    name data_585_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_585_val \
    op interface \
    ports { data_585_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1276 \
    name data_586_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_586_val \
    op interface \
    ports { data_586_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1277 \
    name data_587_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_587_val \
    op interface \
    ports { data_587_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1278 \
    name data_589_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_589_val \
    op interface \
    ports { data_589_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1279 \
    name data_590_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_590_val \
    op interface \
    ports { data_590_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1280 \
    name data_593_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_593_val \
    op interface \
    ports { data_593_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1281 \
    name data_594_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_594_val \
    op interface \
    ports { data_594_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1282 \
    name data_595_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_595_val \
    op interface \
    ports { data_595_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1283 \
    name data_596_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_596_val \
    op interface \
    ports { data_596_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1284 \
    name data_597_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_597_val \
    op interface \
    ports { data_597_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1285 \
    name data_600_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_600_val \
    op interface \
    ports { data_600_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1286 \
    name data_601_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_601_val \
    op interface \
    ports { data_601_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1287 \
    name data_602_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_602_val \
    op interface \
    ports { data_602_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1288 \
    name data_603_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_603_val \
    op interface \
    ports { data_603_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1289 \
    name data_604_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_604_val \
    op interface \
    ports { data_604_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1290 \
    name data_607_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_607_val \
    op interface \
    ports { data_607_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1291 \
    name data_608_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_608_val \
    op interface \
    ports { data_608_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1292 \
    name data_610_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_610_val \
    op interface \
    ports { data_610_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1293 \
    name data_611_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_611_val \
    op interface \
    ports { data_611_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1294 \
    name data_613_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_613_val \
    op interface \
    ports { data_613_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1295 \
    name data_614_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_614_val \
    op interface \
    ports { data_614_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1296 \
    name data_615_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_615_val \
    op interface \
    ports { data_615_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1297 \
    name data_617_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_617_val \
    op interface \
    ports { data_617_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1298 \
    name data_618_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_618_val \
    op interface \
    ports { data_618_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1299 \
    name data_619_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_619_val \
    op interface \
    ports { data_619_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1300 \
    name data_621_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_621_val \
    op interface \
    ports { data_621_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1301 \
    name data_622_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_622_val \
    op interface \
    ports { data_622_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1302 \
    name data_624_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_624_val \
    op interface \
    ports { data_624_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1303 \
    name data_625_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_625_val \
    op interface \
    ports { data_625_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1304 \
    name data_628_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_628_val \
    op interface \
    ports { data_628_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1305 \
    name data_629_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_629_val \
    op interface \
    ports { data_629_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1306 \
    name data_631_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_631_val \
    op interface \
    ports { data_631_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1307 \
    name data_632_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_632_val \
    op interface \
    ports { data_632_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1308 \
    name data_635_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_635_val \
    op interface \
    ports { data_635_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1309 \
    name data_636_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_636_val \
    op interface \
    ports { data_636_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1310 \
    name data_638_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_638_val \
    op interface \
    ports { data_638_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1311 \
    name data_639_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_639_val \
    op interface \
    ports { data_639_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1312 \
    name data_642_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_642_val \
    op interface \
    ports { data_642_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1313 \
    name data_643_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_643_val \
    op interface \
    ports { data_643_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1314 \
    name data_645_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_645_val \
    op interface \
    ports { data_645_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1315 \
    name data_646_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_646_val \
    op interface \
    ports { data_646_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1316 \
    name data_649_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_649_val \
    op interface \
    ports { data_649_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1317 \
    name data_650_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_650_val \
    op interface \
    ports { data_650_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1318 \
    name data_652_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_652_val \
    op interface \
    ports { data_652_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1319 \
    name data_653_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_653_val \
    op interface \
    ports { data_653_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1320 \
    name data_656_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_656_val \
    op interface \
    ports { data_656_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1321 \
    name data_657_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_657_val \
    op interface \
    ports { data_657_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1322 \
    name data_659_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_659_val \
    op interface \
    ports { data_659_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1323 \
    name data_660_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_660_val \
    op interface \
    ports { data_660_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1324 \
    name data_663_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_663_val \
    op interface \
    ports { data_663_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1325 \
    name data_664_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_664_val \
    op interface \
    ports { data_664_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1326 \
    name data_666_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_666_val \
    op interface \
    ports { data_666_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1327 \
    name data_667_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_667_val \
    op interface \
    ports { data_667_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1328 \
    name data_670_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_670_val \
    op interface \
    ports { data_670_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1329 \
    name data_671_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_671_val \
    op interface \
    ports { data_671_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1330 \
    name data_672_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_672_val \
    op interface \
    ports { data_672_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1331 \
    name data_673_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_673_val \
    op interface \
    ports { data_673_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1332 \
    name data_674_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_674_val \
    op interface \
    ports { data_674_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1333 \
    name data_677_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_677_val \
    op interface \
    ports { data_677_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1334 \
    name data_678_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_678_val \
    op interface \
    ports { data_678_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1335 \
    name data_680_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_680_val \
    op interface \
    ports { data_680_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1336 \
    name data_681_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_681_val \
    op interface \
    ports { data_681_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1337 \
    name data_682_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_682_val \
    op interface \
    ports { data_682_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1338 \
    name data_684_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_684_val \
    op interface \
    ports { data_684_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1339 \
    name data_685_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_685_val \
    op interface \
    ports { data_685_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1340 \
    name data_686_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_686_val \
    op interface \
    ports { data_686_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1341 \
    name data_687_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_687_val \
    op interface \
    ports { data_687_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1342 \
    name data_688_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_688_val \
    op interface \
    ports { data_688_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1343 \
    name data_691_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_691_val \
    op interface \
    ports { data_691_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1344 \
    name data_692_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_692_val \
    op interface \
    ports { data_692_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1345 \
    name data_694_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_694_val \
    op interface \
    ports { data_694_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1346 \
    name data_695_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_695_val \
    op interface \
    ports { data_695_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1347 \
    name data_698_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_698_val \
    op interface \
    ports { data_698_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1348 \
    name data_699_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_699_val \
    op interface \
    ports { data_699_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1349 \
    name data_701_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_701_val \
    op interface \
    ports { data_701_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1350 \
    name data_702_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_702_val \
    op interface \
    ports { data_702_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1351 \
    name data_703_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_703_val \
    op interface \
    ports { data_703_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1352 \
    name data_705_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_705_val \
    op interface \
    ports { data_705_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1353 \
    name data_706_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_706_val \
    op interface \
    ports { data_706_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1354 \
    name data_708_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_708_val \
    op interface \
    ports { data_708_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1355 \
    name data_709_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_709_val \
    op interface \
    ports { data_709_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1356 \
    name data_712_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_712_val \
    op interface \
    ports { data_712_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1357 \
    name data_713_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_713_val \
    op interface \
    ports { data_713_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1358 \
    name data_714_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_714_val \
    op interface \
    ports { data_714_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1359 \
    name data_715_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_715_val \
    op interface \
    ports { data_715_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1360 \
    name data_716_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_716_val \
    op interface \
    ports { data_716_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1361 \
    name data_719_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_719_val \
    op interface \
    ports { data_719_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1362 \
    name data_720_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_720_val \
    op interface \
    ports { data_720_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1363 \
    name data_722_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_722_val \
    op interface \
    ports { data_722_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1364 \
    name data_723_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_723_val \
    op interface \
    ports { data_723_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1365 \
    name data_726_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_726_val \
    op interface \
    ports { data_726_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1366 \
    name data_727_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_727_val \
    op interface \
    ports { data_727_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1367 \
    name data_729_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_729_val \
    op interface \
    ports { data_729_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1368 \
    name data_730_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_730_val \
    op interface \
    ports { data_730_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1369 \
    name data_733_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_733_val \
    op interface \
    ports { data_733_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1370 \
    name data_734_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_734_val \
    op interface \
    ports { data_734_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1371 \
    name data_735_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_735_val \
    op interface \
    ports { data_735_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1372 \
    name data_736_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_736_val \
    op interface \
    ports { data_736_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1373 \
    name data_737_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_737_val \
    op interface \
    ports { data_737_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1374 \
    name data_740_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_740_val \
    op interface \
    ports { data_740_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1375 \
    name data_741_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_741_val \
    op interface \
    ports { data_741_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1376 \
    name data_743_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_743_val \
    op interface \
    ports { data_743_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1377 \
    name data_744_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_744_val \
    op interface \
    ports { data_744_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1378 \
    name data_747_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_747_val \
    op interface \
    ports { data_747_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1379 \
    name data_748_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_748_val \
    op interface \
    ports { data_748_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1380 \
    name data_750_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_750_val \
    op interface \
    ports { data_750_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1381 \
    name data_751_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_751_val \
    op interface \
    ports { data_751_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1382 \
    name data_754_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_754_val \
    op interface \
    ports { data_754_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1383 \
    name data_755_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_755_val \
    op interface \
    ports { data_755_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1384 \
    name data_757_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_757_val \
    op interface \
    ports { data_757_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1385 \
    name data_758_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_758_val \
    op interface \
    ports { data_758_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1386 \
    name data_761_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_761_val \
    op interface \
    ports { data_761_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1387 \
    name data_762_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_762_val \
    op interface \
    ports { data_762_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1388 \
    name data_764_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_764_val \
    op interface \
    ports { data_764_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1389 \
    name data_765_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_765_val \
    op interface \
    ports { data_765_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1390 \
    name data_766_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_766_val \
    op interface \
    ports { data_766_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1391 \
    name data_768_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_768_val \
    op interface \
    ports { data_768_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1392 \
    name data_769_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_769_val \
    op interface \
    ports { data_769_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1393 \
    name data_771_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_771_val \
    op interface \
    ports { data_771_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1394 \
    name data_772_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_772_val \
    op interface \
    ports { data_772_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1395 \
    name data_775_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_775_val \
    op interface \
    ports { data_775_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1396 \
    name data_776_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_776_val \
    op interface \
    ports { data_776_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1397 \
    name data_778_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_778_val \
    op interface \
    ports { data_778_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1398 \
    name data_779_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_779_val \
    op interface \
    ports { data_779_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1399 \
    name data_782_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_782_val \
    op interface \
    ports { data_782_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1400 \
    name data_783_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_783_val \
    op interface \
    ports { data_783_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1401 \
    name data_785_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_785_val \
    op interface \
    ports { data_785_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1402 \
    name data_786_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_786_val \
    op interface \
    ports { data_786_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1403 \
    name data_789_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_789_val \
    op interface \
    ports { data_789_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1404 \
    name data_790_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_790_val \
    op interface \
    ports { data_790_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1405 \
    name data_792_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_792_val \
    op interface \
    ports { data_792_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1406 \
    name data_793_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_793_val \
    op interface \
    ports { data_793_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1407 \
    name data_796_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_796_val \
    op interface \
    ports { data_796_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1408 \
    name data_797_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_797_val \
    op interface \
    ports { data_797_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1409 \
    name data_799_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_799_val \
    op interface \
    ports { data_799_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1410 \
    name data_800_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_800_val \
    op interface \
    ports { data_800_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1411 \
    name data_803_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_803_val \
    op interface \
    ports { data_803_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1412 \
    name data_804_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_804_val \
    op interface \
    ports { data_804_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1413 \
    name data_806_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_806_val \
    op interface \
    ports { data_806_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1414 \
    name data_807_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_807_val \
    op interface \
    ports { data_807_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1415 \
    name data_810_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_810_val \
    op interface \
    ports { data_810_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1416 \
    name data_811_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_811_val \
    op interface \
    ports { data_811_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1417 \
    name data_813_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_813_val \
    op interface \
    ports { data_813_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1418 \
    name data_814_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_814_val \
    op interface \
    ports { data_814_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1419 \
    name data_817_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_817_val \
    op interface \
    ports { data_817_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1420 \
    name data_818_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_818_val \
    op interface \
    ports { data_818_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1421 \
    name data_820_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_820_val \
    op interface \
    ports { data_820_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1422 \
    name data_821_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_821_val \
    op interface \
    ports { data_821_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1423 \
    name data_824_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_824_val \
    op interface \
    ports { data_824_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1424 \
    name data_825_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_825_val \
    op interface \
    ports { data_825_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1425 \
    name data_827_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_827_val \
    op interface \
    ports { data_827_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1426 \
    name data_828_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_828_val \
    op interface \
    ports { data_828_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1427 \
    name data_830_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_830_val \
    op interface \
    ports { data_830_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1428 \
    name data_831_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_831_val \
    op interface \
    ports { data_831_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1429 \
    name data_832_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_832_val \
    op interface \
    ports { data_832_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1430 \
    name data_834_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_834_val \
    op interface \
    ports { data_834_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1431 \
    name data_835_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_835_val \
    op interface \
    ports { data_835_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1432 \
    name data_838_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_838_val \
    op interface \
    ports { data_838_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1433 \
    name data_839_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_839_val \
    op interface \
    ports { data_839_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1434 \
    name data_841_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_841_val \
    op interface \
    ports { data_841_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1435 \
    name data_842_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_842_val \
    op interface \
    ports { data_842_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1436 \
    name data_845_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_845_val \
    op interface \
    ports { data_845_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1437 \
    name data_846_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_846_val \
    op interface \
    ports { data_846_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1438 \
    name data_848_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_848_val \
    op interface \
    ports { data_848_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1439 \
    name data_849_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_849_val \
    op interface \
    ports { data_849_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1440 \
    name data_852_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_852_val \
    op interface \
    ports { data_852_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1441 \
    name data_853_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_853_val \
    op interface \
    ports { data_853_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1442 \
    name data_855_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_855_val \
    op interface \
    ports { data_855_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1443 \
    name data_856_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_856_val \
    op interface \
    ports { data_856_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1444 \
    name data_859_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_859_val \
    op interface \
    ports { data_859_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1445 \
    name data_860_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_860_val \
    op interface \
    ports { data_860_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1446 \
    name data_862_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_862_val \
    op interface \
    ports { data_862_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1447 \
    name data_863_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_863_val \
    op interface \
    ports { data_863_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1448 \
    name data_866_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_866_val \
    op interface \
    ports { data_866_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1449 \
    name data_867_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_867_val \
    op interface \
    ports { data_867_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1450 \
    name data_869_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_869_val \
    op interface \
    ports { data_869_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1451 \
    name data_870_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_870_val \
    op interface \
    ports { data_870_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1452 \
    name data_871_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_871_val \
    op interface \
    ports { data_871_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1453 \
    name data_873_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_873_val \
    op interface \
    ports { data_873_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1454 \
    name data_874_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_874_val \
    op interface \
    ports { data_874_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1455 \
    name data_876_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_876_val \
    op interface \
    ports { data_876_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1456 \
    name data_877_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_877_val \
    op interface \
    ports { data_877_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1457 \
    name data_880_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_880_val \
    op interface \
    ports { data_880_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1458 \
    name data_881_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_881_val \
    op interface \
    ports { data_881_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1459 \
    name data_883_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_883_val \
    op interface \
    ports { data_883_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1460 \
    name data_884_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_884_val \
    op interface \
    ports { data_884_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1461 \
    name data_887_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_887_val \
    op interface \
    ports { data_887_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1462 \
    name data_888_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_888_val \
    op interface \
    ports { data_888_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1463 \
    name data_890_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_890_val \
    op interface \
    ports { data_890_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1464 \
    name data_891_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_891_val \
    op interface \
    ports { data_891_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1465 \
    name data_894_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_894_val \
    op interface \
    ports { data_894_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1466 \
    name data_895_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_895_val \
    op interface \
    ports { data_895_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1467 \
    name data_897_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_897_val \
    op interface \
    ports { data_897_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1468 \
    name data_898_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_898_val \
    op interface \
    ports { data_898_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1469 \
    name data_901_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_901_val \
    op interface \
    ports { data_901_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1470 \
    name data_902_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_902_val \
    op interface \
    ports { data_902_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1471 \
    name data_904_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_904_val \
    op interface \
    ports { data_904_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1472 \
    name data_905_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_905_val \
    op interface \
    ports { data_905_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1473 \
    name data_908_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_908_val \
    op interface \
    ports { data_908_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1474 \
    name data_909_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_909_val \
    op interface \
    ports { data_909_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1475 \
    name data_911_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_911_val \
    op interface \
    ports { data_911_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1476 \
    name data_912_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_912_val \
    op interface \
    ports { data_912_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1477 \
    name data_915_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_915_val \
    op interface \
    ports { data_915_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1478 \
    name data_916_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_916_val \
    op interface \
    ports { data_916_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1479 \
    name data_918_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_918_val \
    op interface \
    ports { data_918_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1480 \
    name data_919_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_919_val \
    op interface \
    ports { data_919_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1481 \
    name data_922_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_922_val \
    op interface \
    ports { data_922_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1482 \
    name data_923_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_923_val \
    op interface \
    ports { data_923_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1483 \
    name data_925_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_925_val \
    op interface \
    ports { data_925_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1484 \
    name data_926_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_926_val \
    op interface \
    ports { data_926_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1485 \
    name data_928_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_928_val \
    op interface \
    ports { data_928_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1486 \
    name data_929_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_929_val \
    op interface \
    ports { data_929_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1487 \
    name data_930_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_930_val \
    op interface \
    ports { data_930_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1488 \
    name data_932_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_932_val \
    op interface \
    ports { data_932_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1489 \
    name data_933_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_933_val \
    op interface \
    ports { data_933_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1490 \
    name data_936_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_936_val \
    op interface \
    ports { data_936_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1491 \
    name data_937_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_937_val \
    op interface \
    ports { data_937_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1492 \
    name data_938_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_938_val \
    op interface \
    ports { data_938_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1493 \
    name data_939_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_939_val \
    op interface \
    ports { data_939_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1494 \
    name data_940_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_940_val \
    op interface \
    ports { data_940_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1495 \
    name data_943_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_943_val \
    op interface \
    ports { data_943_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1496 \
    name data_944_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_944_val \
    op interface \
    ports { data_944_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1497 \
    name data_945_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_945_val \
    op interface \
    ports { data_945_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1498 \
    name data_946_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_946_val \
    op interface \
    ports { data_946_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1499 \
    name data_947_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_947_val \
    op interface \
    ports { data_947_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1500 \
    name data_950_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_950_val \
    op interface \
    ports { data_950_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1501 \
    name data_951_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_951_val \
    op interface \
    ports { data_951_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1502 \
    name data_953_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_953_val \
    op interface \
    ports { data_953_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1503 \
    name data_954_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_954_val \
    op interface \
    ports { data_954_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1504 \
    name data_957_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_957_val \
    op interface \
    ports { data_957_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1505 \
    name data_958_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_958_val \
    op interface \
    ports { data_958_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1506 \
    name data_960_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_960_val \
    op interface \
    ports { data_960_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1507 \
    name data_961_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_961_val \
    op interface \
    ports { data_961_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1508 \
    name data_964_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_964_val \
    op interface \
    ports { data_964_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1509 \
    name data_965_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_965_val \
    op interface \
    ports { data_965_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1510 \
    name data_967_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_967_val \
    op interface \
    ports { data_967_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1511 \
    name data_968_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_968_val \
    op interface \
    ports { data_968_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1512 \
    name data_971_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_971_val \
    op interface \
    ports { data_971_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1513 \
    name data_972_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_972_val \
    op interface \
    ports { data_972_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1514 \
    name data_974_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_974_val \
    op interface \
    ports { data_974_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1515 \
    name data_975_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_975_val \
    op interface \
    ports { data_975_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1516 \
    name data_978_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_978_val \
    op interface \
    ports { data_978_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1517 \
    name data_979_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_979_val \
    op interface \
    ports { data_979_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1518 \
    name data_981_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_981_val \
    op interface \
    ports { data_981_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1519 \
    name data_982_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_982_val \
    op interface \
    ports { data_982_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1520 \
    name data_985_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_985_val \
    op interface \
    ports { data_985_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1521 \
    name data_986_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_986_val \
    op interface \
    ports { data_986_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1522 \
    name data_988_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_988_val \
    op interface \
    ports { data_988_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1523 \
    name data_989_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_989_val \
    op interface \
    ports { data_989_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1524 \
    name data_992_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_992_val \
    op interface \
    ports { data_992_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1525 \
    name data_993_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_993_val \
    op interface \
    ports { data_993_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1526 \
    name data_995_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_995_val \
    op interface \
    ports { data_995_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1527 \
    name data_996_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_996_val \
    op interface \
    ports { data_996_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1528 \
    name data_999_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_999_val \
    op interface \
    ports { data_999_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1529 \
    name data_1000_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1000_val \
    op interface \
    ports { data_1000_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1530 \
    name data_1002_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1002_val \
    op interface \
    ports { data_1002_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1531 \
    name data_1003_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1003_val \
    op interface \
    ports { data_1003_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1532 \
    name data_1006_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1006_val \
    op interface \
    ports { data_1006_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1533 \
    name data_1007_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1007_val \
    op interface \
    ports { data_1007_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1534 \
    name data_1009_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1009_val \
    op interface \
    ports { data_1009_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1535 \
    name data_1010_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1010_val \
    op interface \
    ports { data_1010_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1536 \
    name data_1013_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1013_val \
    op interface \
    ports { data_1013_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1537 \
    name data_1014_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1014_val \
    op interface \
    ports { data_1014_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1538 \
    name data_1016_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1016_val \
    op interface \
    ports { data_1016_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1539 \
    name data_1017_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1017_val \
    op interface \
    ports { data_1017_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1540 \
    name data_1020_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1020_val \
    op interface \
    ports { data_1020_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1541 \
    name data_1021_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1021_val \
    op interface \
    ports { data_1021_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1542 \
    name data_1023_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1023_val \
    op interface \
    ports { data_1023_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1543 \
    name data_1024_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1024_val \
    op interface \
    ports { data_1024_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1544 \
    name data_1027_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1027_val \
    op interface \
    ports { data_1027_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1545 \
    name data_1028_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1028_val \
    op interface \
    ports { data_1028_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1546 \
    name data_1030_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1030_val \
    op interface \
    ports { data_1030_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1547 \
    name data_1031_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1031_val \
    op interface \
    ports { data_1031_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1548 \
    name data_1033_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1033_val \
    op interface \
    ports { data_1033_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1549 \
    name data_1034_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1034_val \
    op interface \
    ports { data_1034_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1550 \
    name data_1035_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1035_val \
    op interface \
    ports { data_1035_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1551 \
    name data_1037_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1037_val \
    op interface \
    ports { data_1037_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1552 \
    name data_1038_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1038_val \
    op interface \
    ports { data_1038_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1553 \
    name data_1041_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1041_val \
    op interface \
    ports { data_1041_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1554 \
    name data_1042_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1042_val \
    op interface \
    ports { data_1042_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1555 \
    name data_1044_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1044_val \
    op interface \
    ports { data_1044_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1556 \
    name data_1045_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1045_val \
    op interface \
    ports { data_1045_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1557 \
    name data_1048_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1048_val \
    op interface \
    ports { data_1048_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1558 \
    name data_1049_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1049_val \
    op interface \
    ports { data_1049_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1559 \
    name data_1051_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1051_val \
    op interface \
    ports { data_1051_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1560 \
    name data_1052_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1052_val \
    op interface \
    ports { data_1052_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1561 \
    name data_1055_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1055_val \
    op interface \
    ports { data_1055_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1562 \
    name data_1056_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1056_val \
    op interface \
    ports { data_1056_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1563 \
    name data_1058_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1058_val \
    op interface \
    ports { data_1058_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1564 \
    name data_1059_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1059_val \
    op interface \
    ports { data_1059_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1565 \
    name data_1062_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1062_val \
    op interface \
    ports { data_1062_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1566 \
    name data_1063_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1063_val \
    op interface \
    ports { data_1063_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1567 \
    name data_1065_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1065_val \
    op interface \
    ports { data_1065_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1568 \
    name data_1066_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1066_val \
    op interface \
    ports { data_1066_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1569 \
    name data_1068_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1068_val \
    op interface \
    ports { data_1068_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1570 \
    name data_1069_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1069_val \
    op interface \
    ports { data_1069_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1571 \
    name data_1070_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1070_val \
    op interface \
    ports { data_1070_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1572 \
    name data_1072_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1072_val \
    op interface \
    ports { data_1072_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1573 \
    name data_1073_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1073_val \
    op interface \
    ports { data_1073_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1574 \
    name data_1074_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1074_val \
    op interface \
    ports { data_1074_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1575 \
    name data_1076_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1076_val \
    op interface \
    ports { data_1076_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1576 \
    name data_1077_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1077_val \
    op interface \
    ports { data_1077_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1577 \
    name data_1079_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1079_val \
    op interface \
    ports { data_1079_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1578 \
    name data_1080_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1080_val \
    op interface \
    ports { data_1080_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1579 \
    name data_1083_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1083_val \
    op interface \
    ports { data_1083_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1580 \
    name data_1084_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1084_val \
    op interface \
    ports { data_1084_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1581 \
    name data_1085_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1085_val \
    op interface \
    ports { data_1085_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1582 \
    name data_1086_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1086_val \
    op interface \
    ports { data_1086_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1583 \
    name data_1087_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1087_val \
    op interface \
    ports { data_1087_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1584 \
    name data_1090_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1090_val \
    op interface \
    ports { data_1090_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1585 \
    name data_1091_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1091_val \
    op interface \
    ports { data_1091_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1586 \
    name data_1092_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1092_val \
    op interface \
    ports { data_1092_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1587 \
    name data_1093_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1093_val \
    op interface \
    ports { data_1093_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1588 \
    name data_1094_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1094_val \
    op interface \
    ports { data_1094_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1589 \
    name data_1097_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1097_val \
    op interface \
    ports { data_1097_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1590 \
    name data_1098_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1098_val \
    op interface \
    ports { data_1098_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1591 \
    name data_1100_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1100_val \
    op interface \
    ports { data_1100_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1592 \
    name data_1101_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1101_val \
    op interface \
    ports { data_1101_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1593 \
    name data_1104_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1104_val \
    op interface \
    ports { data_1104_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1594 \
    name data_1105_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1105_val \
    op interface \
    ports { data_1105_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1595 \
    name data_1106_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1106_val \
    op interface \
    ports { data_1106_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1596 \
    name data_1107_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1107_val \
    op interface \
    ports { data_1107_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1597 \
    name data_1108_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1108_val \
    op interface \
    ports { data_1108_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1598 \
    name data_1111_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1111_val \
    op interface \
    ports { data_1111_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1599 \
    name data_1112_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1112_val \
    op interface \
    ports { data_1112_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1600 \
    name data_1114_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1114_val \
    op interface \
    ports { data_1114_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1601 \
    name data_1115_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1115_val \
    op interface \
    ports { data_1115_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1602 \
    name data_1118_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1118_val \
    op interface \
    ports { data_1118_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1603 \
    name data_1119_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1119_val \
    op interface \
    ports { data_1119_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1604 \
    name data_1121_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1121_val \
    op interface \
    ports { data_1121_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1605 \
    name data_1122_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1122_val \
    op interface \
    ports { data_1122_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1606 \
    name data_1125_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1125_val \
    op interface \
    ports { data_1125_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1607 \
    name data_1126_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1126_val \
    op interface \
    ports { data_1126_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1608 \
    name data_1128_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1128_val \
    op interface \
    ports { data_1128_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1609 \
    name data_1129_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1129_val \
    op interface \
    ports { data_1129_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1610 \
    name data_1132_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1132_val \
    op interface \
    ports { data_1132_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1611 \
    name data_1133_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1133_val \
    op interface \
    ports { data_1133_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1612 \
    name data_1135_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1135_val \
    op interface \
    ports { data_1135_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1613 \
    name data_1136_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1136_val \
    op interface \
    ports { data_1136_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1614 \
    name data_1139_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1139_val \
    op interface \
    ports { data_1139_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1615 \
    name data_1140_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1140_val \
    op interface \
    ports { data_1140_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1616 \
    name data_1142_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1142_val \
    op interface \
    ports { data_1142_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1617 \
    name data_1143_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1143_val \
    op interface \
    ports { data_1143_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1618 \
    name data_1146_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1146_val \
    op interface \
    ports { data_1146_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1619 \
    name data_1147_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1147_val \
    op interface \
    ports { data_1147_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1620 \
    name data_1149_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1149_val \
    op interface \
    ports { data_1149_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1621 \
    name data_1150_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1150_val \
    op interface \
    ports { data_1150_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1622 \
    name data_1152_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1152_val \
    op interface \
    ports { data_1152_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1623 \
    name data_1153_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1153_val \
    op interface \
    ports { data_1153_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1624 \
    name data_1154_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1154_val \
    op interface \
    ports { data_1154_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1625 \
    name data_1156_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1156_val \
    op interface \
    ports { data_1156_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1626 \
    name data_1157_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1157_val \
    op interface \
    ports { data_1157_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1627 \
    name data_1159_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1159_val \
    op interface \
    ports { data_1159_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1628 \
    name data_1160_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1160_val \
    op interface \
    ports { data_1160_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1629 \
    name data_1161_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1161_val \
    op interface \
    ports { data_1161_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1630 \
    name data_1163_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1163_val \
    op interface \
    ports { data_1163_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1631 \
    name data_1164_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1164_val \
    op interface \
    ports { data_1164_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1632 \
    name data_1166_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1166_val \
    op interface \
    ports { data_1166_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1633 \
    name data_1167_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1167_val \
    op interface \
    ports { data_1167_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1634 \
    name data_1168_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1168_val \
    op interface \
    ports { data_1168_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1635 \
    name data_1170_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1170_val \
    op interface \
    ports { data_1170_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1636 \
    name data_1171_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1171_val \
    op interface \
    ports { data_1171_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1637 \
    name data_1173_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1173_val \
    op interface \
    ports { data_1173_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1638 \
    name data_1174_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1174_val \
    op interface \
    ports { data_1174_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1639 \
    name data_1175_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_data_1175_val \
    op interface \
    ports { data_1175_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 1 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -2 \
    name ap_return \
    type ap_return \
    reset_level 1 \
    sync_rst true \
    corename ap_return \
    op interface \
    ports { ap_return { O 9 vector } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -3 \
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
    id -4 \
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



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


