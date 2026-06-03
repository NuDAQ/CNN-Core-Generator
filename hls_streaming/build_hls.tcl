set tcldir [file dirname [file normalize [info script]]]
cd $tcldir

source [file join $tcldir project.tcl]
source [file join $tcldir build_opt.tcl]

proc env_or_default {name default_value} {
    if {[info exists ::env($name)] && $::env($name) ne ""} {
        return $::env($name)
    }
    return $default_value
}

proc bool_env_override {name opt_name} {
    global opt
    if {[info exists ::env($name)] && $::env($name) ne ""} {
        set opt($opt_name) $::env($name)
    }
}

proc report_time {op_name time_start time_end} {
    set time_taken [expr {$time_end - $time_start}]
    set time_s [expr {($time_taken / 1000) % 60}]
    set time_m [expr {($time_taken / (1000 * 60)) % 60}]
    set time_h [expr {($time_taken / (1000 * 60 * 60)) % 24}]
    puts "***** ${op_name} COMPLETED IN ${time_h}h${time_m}m${time_s}s *****"
}

set hls_project_name [env_or_default HLS_PROJECT $hls_project_name]
set solution_name [env_or_default HLS_SOLUTION $solution_name]
set part [env_or_default HLS_PART $part]
set clock_period [env_or_default HLS_CLOCK $clock_period]
set clock_uncertainty [env_or_default HLS_CLOCK_UNCERTAINTY $clock_uncertainty]

bool_env_override HLS_RESET reset
bool_env_override HLS_CSIM csim
bool_env_override HLS_SYNTH synth
bool_env_override HLS_COSIM cosim
bool_env_override HLS_EXPORT export
bool_env_override HLS_OOC_SYNTH ooc_synth

if {$opt(reset)} {
    open_project -reset $hls_project_name
} else {
    open_project $hls_project_name
}

set_top $project_name

set common_cflags "-std=c++14 -I. -Ifirmware"
set tb_cflags [env_or_default HLS_TB_CFLAGS "$common_cflags -DHLS_STREAMING_2X_INPUT"]
add_files firmware/${project_name}.cpp -cflags $common_cflags
add_files -tb tb/compare_runner.cpp -cflags $tb_cflags
add_files -tb firmware/weights

if {$opt(reset)} {
    open_solution -reset $solution_name
} else {
    open_solution $solution_name
}

config_compile -name_max_length 80
set_part $part
config_schedule -enable_dsp_full_reg=false
create_clock -period $clock_period -name default
set_clock_uncertainty $clock_uncertainty default

puts "***** HLS STREAMING BUILD CONFIG *****"
puts "project:           $hls_project_name"
puts "solution:          $solution_name"
puts "top:               $project_name"
puts "part:              $part"
puts "clock_period:      $clock_period"
puts "clock_uncertainty: $clock_uncertainty"
puts "csim:              $opt(csim)"
puts "synth:             $opt(synth)"
puts "cosim:             $opt(cosim)"
puts "export:            $opt(export)"
puts "ooc_synth:         $opt(ooc_synth)"

if {$opt(csim)} {
    puts "***** C SIMULATION *****"
    set time_start [clock clicks -milliseconds]
    csim_design
    set time_end [clock clicks -milliseconds]
    report_time "C SIMULATION" $time_start $time_end
}

if {$opt(synth)} {
    puts "***** C/RTL SYNTHESIS *****"
    set time_start [clock clicks -milliseconds]
    csynth_design
    set time_end [clock clicks -milliseconds]
    report_time "C/RTL SYNTHESIS" $time_start $time_end
}

if {$opt(cosim)} {
    puts "***** C/RTL COSIMULATION *****"
    set time_start [clock clicks -milliseconds]
    cosim_design
    set time_end [clock clicks -milliseconds]
    report_time "C/RTL COSIMULATION" $time_start $time_end
}

if {$opt(export)} {
    puts "***** EXPORT IP *****"
    set time_start [clock clicks -milliseconds]
    export_design -format ip_catalog
    set time_end [clock clicks -milliseconds]
    report_time "EXPORT IP" $time_start $time_end
}

if {$opt(ooc_synth)} {
    puts "***** VIVADO OUT-OF-CONTEXT SYNTHESIS *****"
    set verilog_dir [file join $hls_project_name $solution_name syn verilog]
    if {![file exists $verilog_dir]} {
        puts "ERROR: Cannot find $verilog_dir. Run C synthesis first."
        exit 1
    }
    set time_start [clock clicks -milliseconds]
    exec vivado -mode batch -source [file join $tcldir scripts vivado_ooc_synth.tcl] >@ stdout
    set time_end [clock clicks -milliseconds]
    report_time "VIVADO OUT-OF-CONTEXT SYNTHESIS" $time_start $time_end
}

if {$opt(synth)} {
    set summary_cmd [list python3 [file join $tcldir scripts summarize_hls.py] \
        --project [file join $tcldir $hls_project_name] \
        --solution $solution_name \
        --top $project_name]
    puts "***** HLS SUMMARY *****"
    if {[catch {exec {*}$summary_cmd} summary_output]} {
        puts "WARN: summary script failed:"
        puts $summary_output
    } else {
        puts $summary_output
    }
}

exit
