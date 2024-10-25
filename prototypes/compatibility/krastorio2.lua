
--K2 compatibility
if mods["Krastorio2"] then
	
	if settings.startup["wret-change-K2-beacon"].value then
	local singularity_beacon = data.raw["beacon"]["kr-singularity-beacon"]
	singularity_beacon.module_specification.module_slots = 15
	singularity_beacon.module_specification.module_info_max_icons_per_row = 5
	singularity_beacon.module_specification.module_info_max_icon_rows = 3
	singularity_beacon.module_specification.module_info_icon_scale = .25
	singularity_beacon.module_specification.module_info_multi_row_initial_height_modifier = -.5
	singularity_beacon.supply_area_distance = singularity_beacon.supply_area_distance + .2
	singularity_beacon.energy_usage = "800kW"
	end
	
	if settings.startup["wret-overload-enable-beaconmk3"].value == true then
		data.raw["recipe"]["wr-beacon-3"].ingredients = {
			{type = "item", name = "wr-beacon-2", amount = 1},
			{type = "item", name = "imersium-beam", amount = 4},
			{type = "item", name = "ai-core", amount = 20},
			{type = "item", name = "copper-cable", amount = 30},
			{type = "item", name = "energy-control-unit", amount = 20},
			{type = "item", name = "substation", amount = 4},
		}
		data.raw["technology"]["effect-transmission-3"].prerequisites = {
			"effect-transmission-2", 
			"space-science-pack", 
			"electric-energy-distribution-2",
			"kr-ai-core",
			"kr-energy-control-unit",
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
		if settings.startup["kr-rebalance-radar"].value then 
			table.insert(data.raw["recipe"]["wr-beacon-3"].ingredients, {"advanced-radar", 4})
			table.insert(data.raw["technology"]["effect-transmission-3"].prerequisites, "advanced-radar")
		end
	end
	
	if settings.startup["wret-overload-enable-beaconmk2"].value == true then
		data.raw["recipe"]["wr-beacon-2"].ingredients = {
			{type = "item", name = "beacon", amount = 1},
			{type = "item", name = "low-density-structure", amount = 20},
			{type = "item", name = "processing-unit", amount = 20},
			{type = "item", name = "copper-cable", amount = 20},
			{type = "item", name = "radar", amount = 4}
		}
		data.raw["technology"]["effect-transmission-2"].unit.ingredients = {
			{"production-science-pack", 1},
			{"utility-science-pack", 1},
			{"space-science-pack", 1},
		}
	end
end