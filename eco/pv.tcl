#Now Lets insert the filler cells 
create_stdcell_fillers  -lib_cells { */SAEDLVT14_FILL1 */SAEDLVT14_FILL2 */SAEDLVT14_FILL3 */SAEDLVT14_FILL16 */SAEDLVT14_FILL32 */SAEDLVT14_FILL64 }


#Perform Logical Connections
connect_pg_net -net VSS [get_pins */VSS]
connect_pg_net -net VDD [get_pins */VDD]

# Delete the filler cells that have routing DRC violations
remove_stdcell_fillers_with_violation

#Let us verify and report routing design rule checking (DRC) violations, by using "check_routes" command
check_routes

# Set the DRC runset file.
set_app_options -name signoff.check_drc.runset -value ./saed14nm_1p9m_drc_rules.rs
set_app_options -name signoff.check_drc.max_errors_per_rule -value 1000
set_app_options -name signoff.check_drc.run_dir -value "./icvDRC_run"
setenv _ICV_RSH_COMMAND ssh
signoff_check_drc
#set_app_options -list {signoff.fix_drc.init_drc_error_db "./icvDRC_run"}
set_app_options -name signoff.fix_drc.run_dir -value "./icvDRC_run"
set_app_options -name signoff.fix_drc.max_detail_route_iterations -value 10
signoff_fix_drc

#Run the command to check the LVS,by using "check_lvs" command
check_lvs

#Metal fill 
set_app_options  -name signoff.create_metal_fill.runset -value ./saed14nm_1p9m_mfill_rules.rs
signoff_create_metal_fill

create_utilization_configuration -scope block core_utilization -include {all}
report_utilization -config core_utilization
save_block -as final

write_gds rv32i.gds

#close_block -f
#close_lib



