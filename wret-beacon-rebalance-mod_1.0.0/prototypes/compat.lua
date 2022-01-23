--compat changes

--K2
if mods["Krastorio2"] then
	
	local singularity_beacon = data.raw["beacon"]["kr-singularity-beacon"]
	singularity_beacon.module_specification.module_slots = 15
	singularity_beacon.module_specification.module_info_max_icons_per_row = 5
	singularity_beacon.module_specification.module_info_max_icon_rows = 3
	singularity_beacon.module_specification.module_info_icon_scale = .25
	singularity_beacon.module_specification.module_info_multi_row_initial_height_modifier = -.5
	singularity_beacon.supply_area_distance = singularity_beacon.supply_area_distance + .2
	
end

--remove FE+ beacons in favor of rebalance's beacons
if mods["FactorioExtended-Plus-Module"] then
	
	data.raw["technology"]["effect-transmission-mk2"].enabled = false
	data.raw["technology"]["effect-transmission-mk3"].enabled = false
	
end