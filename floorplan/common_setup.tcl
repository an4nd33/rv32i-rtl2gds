puts "RM-Info: Running script [info script]\n"

##########################################################################################
# Variables common to all RM scripts
# Script: common_setup.tcl
# Version: F-2011.09-SP4 (April 2, 2012)
# Copyright (C) 2007-2012 Synopsys, Inc. All rights reserved.
##########################################################################################

set DESIGN_NAME                   "top_system"  ;#  The name of the top-level design

## Point to the new 14nm SAED libs
set DESIGN_REF_PATH "/home/synopsys/installs/LIBRARIES/SAED14nm_EDK"
set DESIGN_REF_PATH1 "/synopsys/installs/LIBRARIES/SAED14nm_EDK"

set DESIGN_REF_TECH_PATH          "/home/synopsys/installs/LIBRARIES/SAED14nm_EDK"

#set DESIGN_REF_DATA_PATH          ""  ;#  Absolute path prefix variable for library/design data.
                                       #  Use this variable to prefix the common absolute path to 
                                       #  the common variables defined below.
                                       #  Absolute paths are mandatory for hierarchical RM flow.
##########################################################################################
# Hierarchical Flow Design Variables
##########################################################################################

set HIERARCHICAL_DESIGNS           "" ;# List of hierarchical block design names "DesignA DesignB" ...
set HIERARCHICAL_CELLS             "" ;# List of hierarchical block cell instance names "u_DesignA u_DesignB" ...

##########################################################################################
# Library Setup Variables
##########################################################################################

# For the following variables, use a blank space to separate multiple entries
# Example: set TARGET_LIBRARY_FILES "lib1.db lib2.db lib3.db"

set ADDITIONAL_SEARCH_PATH      " \
        ${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm \
        ${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm \
        ${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm \
	${DESIGN_REF_PATH}/lib/sram_lp/logic_synth/singlelp \
	${DESIGN_REF_PATH}/lib/io_std/db_nldm "

set TARGET_LIBRARY_FILES   "\
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
$DESIGN_REF_PATH/SAED14nm_EDK_SRAM/liberty/nldm/saed14sram_ff0p88vm40c.db "


set LINK_LIBRARY_FILES    "* $TARGET_LIBRARY_FILES"


set link_library  $LINK_LIBRARY_FILES 
set target_library $TARGET_LIBRARY_FILES



#multi_voltage
set LINK_LIBRARY_FILES    "* \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ss0p72v125c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ss0p6v125c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_dlvl_ss0p72v125c_i0p72v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_dlvl_ss0p6v125c_i0p6v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ulvl_ss0p72v125c_i0p72v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ulvl_ss0p6v125c_i0p6v.db \
${DESIGN_REF_PATH}/lib/sram_lp/logic_synth/singlelp/saed14sram_ss0p72v125c_i0p72v.db \
${DESIGN_REF_PATH}/lib/sram_lp/logic_synth/singlelp/saed14sram_tt0p8v25c_i0p8v.db "

#multi_voltage
set TARGET_LIBRARY_FILES   "\
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ss0p72v125c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ss0p6v125c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_dlvl_ss0p72v125c_i0p72v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_dlvl_ss0p6v125c_i0p6v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ulvl_ss0p72v125c_i0p72v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ulvl_ss0p6v125c_i0p6v.db \
${DESIGN_REF_PATH}/lib/sram_lp/logic_synth/singlelp/saed14sram_ss0p72v125c_i0p72v.db \
${DESIGN_REF_PATH}/lib/sram_lp/logic_synth/singlelp/saed14sram_tt0p8v25c_i0p8v.db "


#multi_vt
set LINK_LIBRARY_FILES_MVT    "* \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_tt0p8v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ss0p6v125c.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_ss0p6v125c.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_tt0p8v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ss0p72v125c.db  \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_ss0p72v125c.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_tt0p6v25c.db \
${DESIGN_REF_PATH}/lib/sram_lp/logic_synth/singlelp/saed14sram_ss0p72v125c_i0p72v.db"          
                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                                                                   
#multi_vt
set TARGET_LIBRARY_FILES_MVT  "\
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_tt0p8v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ss0p6v125c.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_ss0p6v125c.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_tt0p8v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ss0p72v125c.db  \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_ss0p72v125c.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_tt0p6v25c.db \
${DESIGN_REF_PATH}/lib/sram_lp/logic_synth/singlelp/saed14sram_ss0p72v125c_i0p72v.db"          
#power_gating
set LINK_LIBRARY_FILES_PG    "* \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_dlvl_ss0p72v125c_i0p72v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_dlvl_ss0p6v125c_i0p6v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_pg_ss0p72v125c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ss0p72v125c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ulvl_ss0p72v125c_i0p72v.db \
${DESIGN_REF_PATH}/lib/sram/logic_synth/single/saed14sram_ss0p72v125c.db "


#power_gating
set TARGET_LIBRARY_FILES_PG    "\
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_dlvl_ss0p72v125c_i0p72v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_dlvl_ss0p6v125c_i0p6v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_pg_ss0p72v125c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ss0p72v125c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ulvl_ss0p72v125c_i0p72v.db \
${DESIGN_REF_PATH}/lib/sram/logic_synth/single/saed14sram_ss0p72v125c.db  "

#clock_gating
set LINK_LIBRARY_FILES_CLG   "* \
/home/synopsys/SAED14nm_EDK/stdcell_rvt/db_nldm/saed14rvt_ff0p7v125c.db \
/home/synopsys/SAED14nm_EDK/stdcell_rvt/db_nldm/saed14rvt_ff0p88v125c.db \
/home/synopsys/SAED14nm_EDK/stdcell_rvt/db_nldm/saed14rvt_ss0p6v125c.db \
/home/synopsys/SAED14nm_EDK/stdcell_rvt/db_nldm/saed14rvt_ss0p72v125c.db "


#clock_gating
set TARGET_LIBRARY_FILES_CLG    "\
/home/synopsys/SAED14nm_EDK/stdcell_rvt/db_nldm/saed14rvt_ff0p7v125c.db \
/home/synopsys/SAED14nm_EDK/stdcell_rvt/db_nldm/saed14rvt_ff0p88v125c.db \
/home/synopsys/SAED14nm_EDK/stdcell_rvt/db_nldm/saed14rvt_ss0p6v125c.db \
/home/synopsys/SAED14nm_EDK/stdcell_rvt/db_nldm/saed14rvt_ss0p72v125c.db "

set ADDITIONAL_LINK_LIB_FILES     " \
${DESIGN_REF_PATH}/lib/sram/logic_synth/single/saed14sram_ff0p88v125c.db \
saed32io_wb_ff1p16v125c_2p75v.db"

set NDM_REFERENCE_LIB_DIRS_MV  " \
	${DESIGN_REF_PATH}/lib/stdcell_rvt/ndm/saed14rvt_frame_only.ndm \
        ${DESIGN_REF_PATH}/lib/sram_lp/ndm/saed14_sram_lp_1rw_frame_only.ndm \
        "

set NDM_REFERENCE_LIB_DIRS_MVT  " \
	${DESIGN_REF_PATH}/lib/stdcell_rvt/ndm/saed14rvt_frame_only.ndm \
	${DESIGN_REF_PATH}/lib/stdcell_hvt/ndm/saed14hvt_frame_only.ndm \
	${DESIGN_REF_PATH}/lib/stdcell_lvt/ndm/saed14lvt_frame_only.ndm \
        ${DESIGN_REF_PATH}/lib/sram/ndm/saed14_sram_1rw_frame_only.ndm \
        "

set NDM_REFERENCE_LIB_DIRS_PG  " \
	${DESIGN_REF_PATH}/lib/stdcell_rvt/ndm/saed14rvt_frame_only.ndm \
        ${DESIGN_REF_PATH}/lib/sram/ndm/saed14_sram_1rw_frame_only.ndm \
        "


set NDM_REFERENCE_LIB_DIRS  " \
	${DESIGN_REF_PATH}/lib/stdcell_rvt/ndm/saed14rvt_frame_only.ndm \
	${DESIGN_REF_PATH}/lib/stdcell_hvt/ndm/saed14hvt_frame_only.ndm \
	${DESIGN_REF_PATH}/lib/stdcell_lvt/ndm/saed14lvt_frame_only.ndm \
        ${DESIGN_REF_PATH}/lib/sram/ndm/saed14_sram_2rw_frame_only.ndm \
        ${DESIGN_REF_PATH}/lib/io_std/ndm/saed14io_wb_frame_only.ndm \
	"


set NDM_REFERENCE_LIB_DIRS_CLG  " \
	/home/synopsys/SAED14nm_EDK/stdcell_rvt/ndm/saed14rvt_frame_only.ndm\
	/home/synopsys/SAED14nm_EDK/stdcell_hvt/ndm/saed14hvt_frame_only.ndm"
	
set MW_REFERENCE_CONTROL_FILE     ""  ;#  Reference Control file to define the MW ref libs

set TECH_FILE                     "${DESIGN_REF_TECH_PATH}/tech/milkyway/saed14nm_1p9m_mw.tf"  ;#  Milkyway technology file
set MAP_FILE                      "${DESIGN_REF_PATH}/tech/star_rc/saed14nm_tf_itf_tluplus.map"  ;#  Mapping file for TLUplus
set TLUPLUS_MAX_FILE              "${DESIGN_REF_PATH}/tech/star_rc/max/saed14nm_1p9m_Cmax.tluplus"  ;#  Max TLUplus file
set TLUPLUS_MIN_FILE              "${DESIGN_REF_PATH}/tech/star_rc/min/saed14nm_1p9m_Cmin.tluplus"  ;#  Min TLUplus file
set GDS_MAP_FILE          	  "${DESIGN_REF_PATH}/tech/milkyway/saed14nm_1p9m_gdsout_mw.map"
set STD_CELL_GDS                  " \
				${DESIGN_REF_PATH}/lib/stdcell_rvt/gds/saed14rvt.gds \
				${DESIGN_REF_PATH}/lib/stdcell_lvt/gds/saed14lvt.gds \
				${DESIGN_REF_PATH}/lib/stdcell_hvt/gds/saed14hvt.gds \
				${DESIGN_REF_PATH}/lib/stdcell_slvt/gds/saed14slvt.gds \
				"
set SRAM_SINGLE_GDS               "${DESIGN_REF_PATH}/lib/sram/gds/single.gds"
set SRAMLP_SINGLELP_GDS		  "${DESIGN_REF_PATH}/lib/sram_lp/gds/singlelp.gds"
set NDM_POWER_NET                "VDD" ;#
set NDM_POWER_PORT               "VDD" ;#
set NDM_GROUND_NET               "VSS" ;#
set NDM_GROUND_PORT              "VSS" ;#

set MIN_ROUTING_LAYER            "M2"   ;# Min routing layer
set MAX_ROUTING_LAYER            "M8"   ;# Max routing layer

##RH variable for ICC SAED library and design input data
#set ICC_INPUT_DATA "/global/scratch/mculver/PD_fest_2012/initial_design/dhm"

set LIBRARY_DONT_USE_FILE        "../../DATA_SAED/use_tie.tcl"   ;# Tcl file with library modifications for dont_use

##########################################################################################
# Multi-Voltage Common Variables
#
# Define the following MV common variables for the RM scripts for multi-voltage flows.
# Use as few or as many of the following definitions as needed by your design.
##########################################################################################
puts "RM-Info: Completed script [info script]\n"



 
