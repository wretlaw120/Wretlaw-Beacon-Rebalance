
--FE+ compatibility
if mods["FactorioExtended-Plus-Module"] then
	
	if settings.startup["wret-block-FE-beacons"].value then
	data.raw["technology"]["effect-transmission-mk2"].enabled = false
	data.raw["technology"]["effect-transmission-mk3"].enabled = false
	end
	
	if settings.startup["wret-FE-beacons-modification"] then

		local FE_beacon_2 = data.raw["beacon"]["beacon-mk2"]

		FE_beacon_2.module_specification.module_slots = 10
		FE_beacon_2.module_specification.module_info_max_icons_per_row = 4
		FE_beacon_2.module_specification.module_info_max_icon_rows = 3
		FE_beacon_2.distribution_effectivity = .75
		FE_beacon_2.supply_area_distance = data.raw["beacon"]["beacon"].supply_area_distance
		FE_beacon_2.energy_usage = "1MW"

		local FE_beacon_3 = data.raw["beacon"]["beacon-mk3"]

		FE_beacon_3.module_specification.module_slots = 12
		FE_beacon_3.module_specification.module_info_max_icons_per_row = 4
		FE_beacon_3.module_specification.module_info_max_icon_rows = 3
		FE_beacon_3.distribution_effectivity = 1
		FE_beacon_3.supply_area_distance = data.raw["beacon"]["beacon"].supply_area_distance
		FE_beacon_3.energy_usage = "3MW"
		
	end
	
end