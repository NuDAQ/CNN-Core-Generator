set tcldir [file dirname [file dirname [file normalize [info script]]]]
cd $tcldir

source [file join $tcldir project.tcl]

proc env_or_default {name default_value} {
    if {[info exists ::env($name)] && $::env($name) ne ""} {
        return $::env($name)
    }
    return $default_value
}

set hls_project_name [env_or_default HLS_PROJECT $hls_project_name]
set solution_name [env_or_default HLS_SOLUTION $solution_name]
set part [env_or_default HLS_PART $part]
set clock_period [env_or_default HLS_CLOCK $clock_period]

set verilog_dir [file join $hls_project_name $solution_name syn verilog]
if {![file exists $verilog_dir]} {
    puts "ERROR: Cannot find generated Verilog directory: $verilog_dir"
    exit 1
}

read_verilog [glob -nocomplain [file join $verilog_dir *.v]]

set report_dir [file join $hls_project_name $solution_name ooc_synth]
file mkdir $report_dir

set xdc_file [file join $report_dir ooc_clock.xdc]
set xdc [open $xdc_file w]
puts $xdc "create_clock -name ap_clk -period $clock_period \[get_ports ap_clk\]"
close $xdc
read_xdc $xdc_file

synth_design -top $project_name -part $part -mode out_of_context
report_utilization -file [file join $report_dir utilization_ooc.rpt]
report_timing_summary -file [file join $report_dir timing_ooc.rpt]
write_checkpoint -force [file join $report_dir ${project_name}_ooc.dcp]

puts "Wrote OOC reports under $report_dir"
