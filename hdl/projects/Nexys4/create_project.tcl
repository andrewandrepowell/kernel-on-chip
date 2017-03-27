#
# Vivado (TM) v2016.4 (64-bit)
#
# create_project_test.tcl: Tcl script for re-creating project 'rtl_project'
#
# Generated by Vivado on Sun Mar 26 20:57:29 EDT 2017
# IP Build 1755317 on Mon Jan 23 20:30:07 MST 2017
#
# This file contains the Vivado Tcl commands for re-creating the project to the state*
# when this script was generated. In order to re-create the project, please source this
# file in the Vivado Tcl Shell.
#
# * Note that the runs in the created project will be configured the same way as the
#   original project, however they will not be launched automatically. To regenerate the
#   run results please launch the synthesis/implementation runs as needed.
#
#*****************************************************************************************
# NOTE: In order to use this script for source control purposes, please make sure that the
#       following files are added to the source control system:-
#
# 1. This project restoration tcl script (create_project_test.tcl) that was generated.
#
# 2. The following source(s) files that were local or imported into the original project.
#    (Please see the '$orig_proj_dir' and '$origin_dir' variable setting below at the start of the script)
#
#    <none>
#
# 3. The following remote source files that were added to the original project:-
#
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_crossbar_pack.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasma/mlite_pack.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_uart_pack.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasma/shifter.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasma/reg_bank.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_crossbar_base.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_crossbar_axi4_write_cntrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_crossbar_axi4_read_cntrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasma/pipeline.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasma/pc_next.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasma/mult.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasma/mem_ctrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasma/control.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasma/bus_mux.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasma/alu.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/generic_fifo.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_timer_pack.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_int_pack.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_gpio_pack.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_cpu_pack.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_axi4_full2lite_pack.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/projects/Nexys4/bd/mig_wrap/mig_wrap.bd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_crossbar.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_cpu_mem_cntrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_cpu_l1_cache_cntrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_cpu_axi4_write_cntrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_cpu_axi4_read_cntrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_axi4_full2lite_write_cntrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_axi4_full2lite_read_cntrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasma/mlite_cpu.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/projects/Nexys4/main_pack.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/projects/Nexys4/jump_pack.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/projects/Nexys4/boot_pack.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/uart.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_uart_axi4_write_cntrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_uart_axi4_read_cntrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_timer_control_bridge.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_timer_cntrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_timer_axi4_write_cntrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_timer_axi4_read_cntrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_int_cntrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_int_axi4_write_cntrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_int_axi4_read_cntrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_gpio_cntrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_gpio_axi4_write_cntrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_gpio_axi4_read_cntrl.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/projects/Nexys4/plasoc_0_crossbar_wrap_pack.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/projects/Nexys4/proc_sys_reset_0/proc_sys_reset_0.xci"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_cpu.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_axi4_full2lite.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/projects/Nexys4/plasoc_0_crossbar_wrap.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/projects/Nexys4/bram.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/projects/Nexys4/axi_bram_ctrl_1/axi_bram_ctrl_1.xci"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/projects/Nexys4/axi_bram_ctrl_0/axi_bram_ctrl_0.xci"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_uart.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_timer.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_int.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/plasoc/plasoc_gpio.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/projects/Nexys4/axi_cdma_0/axi_cdma_0.xci"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/projects/Nexys4/bd/mig_wrap/hdl/mig_wrap_wrapper.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/projects/Nexys4/axiplasma_wrapper.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/projects/Nexys4/testbench_vivado_0.vhd"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/projects/Nexys4/bd/mig_wrap/ip/mig_wrap_mig_7series_0_0/mig_b.prj"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/projects/Nexys4/clk_wiz_0/clk_wiz_0.xci"
#    "/opt/Xilinx/Projects/koc/axiplasma/hdl/projects/Nexys4/constraints.xdc"
#
#*****************************************************************************************

# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir "."

# Use origin directory path location variable, if specified in the tcl shell
if { [info exists ::origin_dir_loc] } {
  set origin_dir $::origin_dir_loc
}

variable script_file
set script_file "create_project_test.tcl"

# Help information for this script
proc help {} {
  variable script_file
  puts "\nDescription:"
  puts "Recreate a Vivado project from this script. The created project will be"
  puts "functionally equivalent to the original project for which this script was"
  puts "generated. The script contains commands for creating a project, filesets,"
  puts "runs, adding/importing sources and setting properties on various objects.\n"
  puts "Syntax:"
  puts "$script_file"
  puts "$script_file -tclargs \[--origin_dir <path>\]"
  puts "$script_file -tclargs \[--help\]\n"
  puts "Usage:"
  puts "Name                   Description"
  puts "-------------------------------------------------------------------------"
  puts "\[--origin_dir <path>\]  Determine source file paths wrt this path. Default"
  puts "                       origin_dir path value is \".\", otherwise, the value"
  puts "                       that was set with the \"-paths_relative_to\" switch"
  puts "                       when this script was generated.\n"
  puts "\[--help\]               Print help information for this script"
  puts "-------------------------------------------------------------------------\n"
  exit 0
}

if { $::argc > 0 } {
  for {set i 0} {$i < [llength $::argc]} {incr i} {
    set option [string trim [lindex $::argv $i]]
    switch -regexp -- $option {
      "--origin_dir" { incr i; set origin_dir [lindex $::argv $i] }
      "--help"       { help }
      default {
        if { [regexp {^-} $option] } {
          puts "ERROR: Unknown option '$option' specified, please type '$script_file -tclargs --help' for usage info.\n"
          return 1
        }
      }
    }
  }
}

# Set the directory path for the original project from where this script was exported
set orig_proj_dir "[file normalize "$origin_dir/rtl_project"]"

# Create project
create_project rtl_project ./rtl_project -part xc7a100tcsg324-1

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Reconstruct message rules
# None

# Set project properties
set obj [get_projects rtl_project]
set_property "corecontainer.enable" "1" $obj
set_property "default_lib" "xil_defaultlib" $obj
set_property "ip_cache_permissions" "read write" $obj
set_property "part" "xc7a100tcsg324-1" $obj
set_property "sim.ip.auto_export_scripts" "1" $obj
set_property "simulator_language" "Mixed" $obj
set_property "target_language" "VHDL" $obj
set_property "xpm_libraries" "XPM_CDC XPM_MEMORY" $obj
set_property "xsim.array_display_limit" "64" $obj
set_property "xsim.trace_limit" "65536" $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 "[file normalize "$origin_dir/../../plasoc/plasoc_crossbar_pack.vhd"]"\
 "[file normalize "$origin_dir/../../plasma/mlite_pack.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_uart_pack.vhd"]"\
 "[file normalize "$origin_dir/../../plasma/shifter.vhd"]"\
 "[file normalize "$origin_dir/../../plasma/reg_bank.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_crossbar_base.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_crossbar_axi4_write_cntrl.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_crossbar_axi4_read_cntrl.vhd"]"\
 "[file normalize "$origin_dir/../../plasma/pipeline.vhd"]"\
 "[file normalize "$origin_dir/../../plasma/pc_next.vhd"]"\
 "[file normalize "$origin_dir/../../plasma/mult.vhd"]"\
 "[file normalize "$origin_dir/../../plasma/mem_ctrl.vhd"]"\
 "[file normalize "$origin_dir/../../plasma/control.vhd"]"\
 "[file normalize "$origin_dir/../../plasma/bus_mux.vhd"]"\
 "[file normalize "$origin_dir/../../plasma/alu.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/generic_fifo.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_timer_pack.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_int_pack.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_gpio_pack.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_cpu_pack.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_axi4_full2lite_pack.vhd"]"\
 "[file normalize "$origin_dir/bd/mig_wrap/mig_wrap.bd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_crossbar.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_cpu_mem_cntrl.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_cpu_l1_cache_cntrl.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_cpu_axi4_write_cntrl.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_cpu_axi4_read_cntrl.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_axi4_full2lite_write_cntrl.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_axi4_full2lite_read_cntrl.vhd"]"\
 "[file normalize "$origin_dir/../../plasma/mlite_cpu.vhd"]"\
 "[file normalize "$origin_dir/main_pack.vhd"]"\
 "[file normalize "$origin_dir/jump_pack.vhd"]"\
 "[file normalize "$origin_dir/boot_pack.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/uart.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_uart_axi4_write_cntrl.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_uart_axi4_read_cntrl.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_timer_control_bridge.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_timer_cntrl.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_timer_axi4_write_cntrl.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_timer_axi4_read_cntrl.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_int_cntrl.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_int_axi4_write_cntrl.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_int_axi4_read_cntrl.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_gpio_cntrl.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_gpio_axi4_write_cntrl.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_gpio_axi4_read_cntrl.vhd"]"\
 "[file normalize "$origin_dir/plasoc_0_crossbar_wrap_pack.vhd"]"\
 "[file normalize "$origin_dir/proc_sys_reset_0/proc_sys_reset_0.xci"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_cpu.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_axi4_full2lite.vhd"]"\
 "[file normalize "$origin_dir/plasoc_0_crossbar_wrap.vhd"]"\
 "[file normalize "$origin_dir/bram.vhd"]"\
 "[file normalize "$origin_dir/axi_bram_ctrl_1/axi_bram_ctrl_1.xci"]"\
 "[file normalize "$origin_dir/axi_bram_ctrl_0/axi_bram_ctrl_0.xci"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_uart.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_timer.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_int.vhd"]"\
 "[file normalize "$origin_dir/../../plasoc/plasoc_gpio.vhd"]"\
 "[file normalize "$origin_dir/axi_cdma_0/axi_cdma_0.xci"]"\
 "[file normalize "$origin_dir/bd/mig_wrap/hdl/mig_wrap_wrapper.vhd"]"\
 "[file normalize "$origin_dir/axiplasma_wrapper.vhd"]"\
 "[file normalize "$origin_dir/testbench_vivado_0.vhd"]"\
 "[file normalize "$origin_dir/bd/mig_wrap/ip/mig_wrap_mig_7series_0_0/mig_b.prj"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset file properties for remote files
set file "$origin_dir/../../plasoc/plasoc_crossbar_pack.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasma/mlite_pack.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_uart_pack.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasma/shifter.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasma/reg_bank.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_crossbar_base.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_crossbar_axi4_write_cntrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_crossbar_axi4_read_cntrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasma/pipeline.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasma/pc_next.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasma/mult.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasma/mem_ctrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasma/control.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasma/bus_mux.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasma/alu.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/generic_fifo.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_timer_pack.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_int_pack.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_gpio_pack.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_cpu_pack.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_axi4_full2lite_pack.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/bd/mig_wrap/mig_wrap.bd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
if { ![get_property "is_locked" $file_obj] } {
  set_property "synth_checkpoint_mode" "Hierarchical" $file_obj
}

set file "$origin_dir/../../plasoc/plasoc_crossbar.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_cpu_mem_cntrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_cpu_l1_cache_cntrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_cpu_axi4_write_cntrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_cpu_axi4_read_cntrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_axi4_full2lite_write_cntrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_axi4_full2lite_read_cntrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasma/mlite_cpu.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/main_pack.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/jump_pack.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/boot_pack.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/uart.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_uart_axi4_write_cntrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_uart_axi4_read_cntrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_timer_control_bridge.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_timer_cntrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_timer_axi4_write_cntrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_timer_axi4_read_cntrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_int_cntrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_int_axi4_write_cntrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_int_axi4_read_cntrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_gpio_cntrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_gpio_axi4_write_cntrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_gpio_axi4_read_cntrl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/plasoc_0_crossbar_wrap_pack.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_cpu.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_axi4_full2lite.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/plasoc_0_crossbar_wrap.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/bram.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_uart.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_timer.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_int.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/../../plasoc/plasoc_gpio.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/bd/mig_wrap/hdl/mig_wrap_wrapper.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/axiplasma_wrapper.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/testbench_vivado_0.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj


# Set 'sources_1' fileset file properties for local files
# None

# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property "top" "axiplasma_wrapper" $obj

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 "[file normalize "$origin_dir/clk_wiz_0/clk_wiz_0.xci"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset file properties for remote files
# None

# Set 'sources_1' fileset file properties for local files
# None

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Add/Import constrs file and set constrs file properties
set file "[file normalize "$origin_dir/constraints.xdc"]"
set file_added [add_files -norecurse -fileset $obj $file]
set file "$origin_dir/constraints.xdc"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets constrs_1] [list "*$file"]]
set_property "file_type" "XDC" $file_obj

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
# Empty (no sources present)

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property "top" "testbench_vivado_0" $obj
set_property "transport_int_delay" "0" $obj
set_property "transport_path_delay" "0" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj

# Create 'synth_1' run (if not found)
if {[string equal [get_runs -quiet synth_1] ""]} {
  create_run -name synth_1 -part xc7a100tcsg324-1 -flow {Vivado Synthesis 2016} -strategy "Vivado Synthesis Defaults" -constrset constrs_1
} else {
  set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]
  set_property flow "Vivado Synthesis 2016" [get_runs synth_1]
}
set obj [get_runs synth_1]
set_property "part" "xc7a100tcsg324-1" $obj

# set the current synth run
current_run -synthesis [get_runs synth_1]

# Create 'impl_1' run (if not found)
if {[string equal [get_runs -quiet impl_1] ""]} {
  create_run -name impl_1 -part xc7a100tcsg324-1 -flow {Vivado Implementation 2016} -strategy "Vivado Implementation Defaults" -constrset constrs_1 -parent_run synth_1
} else {
  set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
  set_property flow "Vivado Implementation 2016" [get_runs impl_1]
}
set obj [get_runs impl_1]
set_property "part" "xc7a100tcsg324-1" $obj
set_property "steps.write_bitstream.args.readback_file" "0" $obj
set_property "steps.write_bitstream.args.verbose" "0" $obj

# set the current impl run
current_run -implementation [get_runs impl_1]

puts "INFO: Project created:rtl_project"
