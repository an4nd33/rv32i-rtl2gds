#===========================================================
# Formality Setup File
# Design  : top_system
# Purpose : RTL vs Gate-Level Netlist Equivalence Checking
#===========================================================

# Enable Synopsys auto setup
set synopsys_auto_setup true

#===========================================================
# Load SVF (Generated from Design Compiler)
#===========================================================

set_svf default.svf

#===========================================================
# Library Setup
#===========================================================

set DESIGN_REF_PATH "/home/synopsys/installs/LIBRARIES/SAED14_EDK"

read_db -tech "\
$DESIGN_REF_PATH/SAED14nm_EDK_STD_RVT/liberty/nldm/base/saed14rvt_base_tt0p8v25c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_RVT/liberty/nldm/base/saed14rvt_base_ss0p72v125c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_RVT/liberty/nldm/base/saed14rvt_base_ff0p88vm40c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_HVT/liberty/nldm/base/saed14hvt_base_tt0p8v25c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_HVT/liberty/nldm/base/saed14hvt_base_ss0p72v125c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_HVT/liberty/nldm/base/saed14hvt_base_ff0p88vm40c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_LVT/liberty/nldm/base/saed14lvt_base_tt0p8v25c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_LVT/liberty/nldm/base/saed14lvt_base_ss0p72v125c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_LVT/liberty/nldm/base/saed14lvt_base_ff0p88vm40c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_HVT/liberty/nldm/cg/saed14hvt_cg_tt0p8v25c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_HVT/liberty/nldm/cg/saed14hvt_cg_ss0p72v125c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_HVT/liberty/nldm/cg/saed14hvt_cg_ff0p88vm40c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_RVT/liberty/nldm/cg/saed14rvt_cg_tt0p8v25c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_RVT/liberty/nldm/cg/saed14rvt_cg_ss0p72v125c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_RVT/liberty/nldm/cg/saed14rvt_cg_ff0p88vm40c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_LVT/liberty/nldm/cg/saed14lvt_cg_tt0p8v25c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_LVT/liberty/nldm/cg/saed14lvt_cg_ss0p72v125c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_LVT/liberty/nldm/cg/saed14lvt_cg_ff0p88vm40c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_SRAM/liberty/nldm/saed14sram_tt0p8v25c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_SRAM/liberty/nldm/saed14sram_ss0p72v125c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_SRAM/liberty/nldm/saed14sram_ff0p88vm40c.db \
"

#===========================================================
# Read Reference Design (RTL)
#===========================================================

read_verilog -r ./soc.v
set_top top_system
set_reference_design top_system

#===========================================================
# Read Implementation Design (Gate Netlist)
#===========================================================

read_verilog -i ./top_system_10ns_netlist.v
set_top top_system
set_implementation_design top_system

#===========================================================
# Matching and Verification
#===========================================================

match
verify

#===========================================================
# Reports
#===========================================================

report_guidance -summary
report_verification -summary
report_unmatched_points
report_failing_points
