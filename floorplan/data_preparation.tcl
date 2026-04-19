set DESIGN_REF_PATH "/home/synopsys/installs/LIBRARIES/SAED14_EDK"


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

set NDM_REFERNCE_DIRS "\
  $DESIGN_REF_PATH/SAED14nm_EDK_STD_RVT/ndm/saed14rvt_base_frame_timing.ndm \
  $DESIGN_REF_PATH/SAED14nm_EDK_STD_RVT/ndm/saed14rvt_cg_frame_timing.ndm \
  $DESIGN_REF_PATH/SAED14nm_EDK_STD_HVT/ndm/saed14hvt_base_frame_timing.ndm \
  $DESIGN_REF_PATH/SAED14nm_EDK_STD_HVT/ndm/saed14hvt_cg_frame_timing.ndm \
  $DESIGN_REF_PATH/SAED14nm_EDK_STD_LVT/ndm/saed14lvt_base_frame_timing.ndm \
  $DESIGN_REF_PATH/SAED14nm_EDK_STD_LVT/ndm/saed14lvt_cg_frame_timing.ndm "


set HIERARCHICAL_DESIGNS ""
set HIERARCHICAL_CELLS  ""
set LINK_LIBRARY_FILES    "* $TARGET_LIBRARY_FILES"


set link_library  $LINK_LIBRARY_FILES 
set target_library $TARGET_LIBRARY_FILES

set MW_REFERNCE_CONTROL_FILE  ""

set TECH_FILE "$DESIGN_REF_PATH/SAED14nm_EDK_TECH_DATA/tf/saed14nm_1p9m.tf"


set MAP_FILE "$DESIGN_REF_PATH/SAED14nm_EDK_TECH_DATA/map/saed14nm_tf_itf_tluplus.map"

set GDS_MAP_FILE  "$DESIGN_REF_PATH/SAED14nm_EDK_TECH_DATA/map/saed14nm_1p9m_gdsin_gdsout.map" 

set STD_CELL_GDS "$DESIGN_REF_PATH/SAED14nm_EDK_TECH_DATA/SAED14nm_EDK_STD_HVT/gds \
$DESIGN_REF_PATH/SAED14nm_EDK_TECH_DATA/SAED14nm_EDK_STD_LVT/gds \
$DESIGN_REF_PATH/SAED14nm_EDK_TECH_DATA/SAED14nm_EDK_STD_RVT/gds \
$DESIGN_REF_PATH/SAED14nm_EDK_TECH_DATA/SAED14nm_EDK_STD_SLVT/gds "

set NDM_POWER_NET "VDD"
set NDM_POWER_PORT "VDD"
set NDM_GROUND_NET "VSS"
set NDM_GROUND_PORT "VSS"

set MIN_ROUTING_LAYER "M2"
set MAX_ROUTING_LAYER "M7"
set my_design_library ".ref_libs"


if {![file isdirectory $my_design_library ]} {
	create_lib .ref_libs -ref_libs $NDM_REFERNCE_DIRS -technology $TECH_FILE

    } else {

    }
open_lib .ref_libs
current_lib .ref_libs

#netlist read:

 read_verilog ./top_system_10ns_netlist.v
 
 #check_design 
 
 link 
  
 save_lib -as post_import_design
 
 # defining attributes for metal layers -- HVH (preferable) or VHV
define_user_attribute -type string -name routing_direction -classes routing_rule

# for horizontal
set_attribute -objects [get_layers {M1 M3 M5 M7 M9}] \
    -name routing_direction -value horizontal

# for vertical
set_attribute -objects [get_layers {M2 M4 M6 M8 MRDL}] \
    -name routing_direction -value vertical


# reading TLU+ file -- max file
read_parasitic_tech -tlup \
    /home/synopsys/installs/LIBRARIES/SAED14_EDK/SAED14nm_EDK_TECH_DATA/tlup/saed14nm_1p9m_Cmax.tlup  \
    -layermap /home/synopsys/installs/LIBRARIES/SAED14_EDK/SAED14nm_EDK_TECH_DATA/map/saed14nm_tf_itf_tluplus.map \
    -name worst_para


# min file
read_parasitic_tech -tlup \
    /home/synopsys/installs/LIBRARIES/SAED14_EDK/SAED14nm_EDK_TECH_DATA/tlup/saed14nm_1p9m_Cmax.tlup \
    -layermap \
    /home/synopsys/installs/LIBRARIES/SAED14_EDK/SAED14nm_EDK_TECH_DATA/map/saed14nm_tf_itf_tluplus.map \
    -name best_para


# reading the .sdc file
# read_sdc inputs/dtmf_recvr_core.sdc
source -e -v ./mcmm.tcl


# save block
# save_block -as minsoc_data1
save_block -as import_done

save_lib

 
