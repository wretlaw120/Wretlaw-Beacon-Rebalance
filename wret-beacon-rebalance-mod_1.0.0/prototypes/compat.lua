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
	
	data.raw["recipe"]["beacon2-recipe"].ingredients = {
		{"beacon", 1},
		{"low-density-structure", 20},
		{"processing-unit", 20},
		{"copper-cable", 20},
		{"radar", 4}
	}
	data.raw["recipe"]["beacon3-recipe"].ingredients = {
		{"beacon2-item", 1},
		{"imersium-beam", 4},
		{"ai-core", 20},
		{"copper-cable", 30},
		{"energy-control-unit", 20},
		{"substation", 4},
		{"advanced-radar", 4}
	}
	data.raw["technology"]["effect-transmission-2"].unit.ingredients = {
		{"production-science-pack", 1},
		{"utility-science-pack", 1},
		{"space-science-pack", 1},
	}
	data.raw["technology"]["effect-transmission-3"].unit.ingredients = {
		{"production-science-pack", 1},
		{"utility-science-pack", 1},
		{"space-science-pack", 1},
		{"matter-tech-card", 1},
		{"advanced-tech-card", 1}
	}
	data.raw["technology"]["effect-transmission-3"].prerequisites = {
		"effect-transmission", 
		"utility-science-pack",
	}
	data.raw["technology"]["effect-transmission-3"].prerequisites = {
		"effect-transmission-2", 
		"space-science-pack", 
		"electric-energy-distribution-2",
		"kr-ai-core",
		"kr-energy-control-unit",
		"advanced-radar",
	}
	
end

--remove FE+ beacons in favor of rebalance's beacons
if mods["FactorioExtended-Plus-Module"] then
	
	data.raw["technology"]["effect-transmission-mk2"].enabled = false
	data.raw["technology"]["effect-transmission-mk3"].enabled = false
	
end