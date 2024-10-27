--beacon mk1 at end

local beacon_profile = settings.startup["wret-overload-disable-overloaded"].value and {1,1} or {1,0}

--beacon mk2
local beacon2 = util.table.deepcopy(beacon_fake)
beacon2.name = "wr-beacon-2"
beacon2.module_slots = 15
beacon2.supply_area_distance = 14
--beacon2.module_specification.module_info_max_icons_per_row = 5
--beacon2.module_specification.module_info_max_icon_rows = 3
beacon2.icons_positioning = {{
    inventory_index = defines.inventory.beacon_modules,
    max_icons_per_row = 5,
    scale = .5,
    separation_multiplier = 1.1,
    multi_row_initial_height_modifier = -.3
}}
beacon2.minable.results = {{type = "item", name = "wr-beacon-2", amount = 1}}
beacon2.collision_box = {{-1.8, -1.8}, {1.8, 1.8}}
beacon2.selection_box = {{-2, -2}, {2, 2}}
beacon2.drawing_box = {{-2, -2}, {2, 2}}
beacon2.energy_usage = "12MW"
if beacon2.next_upgrade then beacon2.next_upgrade = nil end
beacon2.profile = beacon_profile
beacon2.distribution_effectivity = 1
beacon2.beacon_counter = "total"

--the below is basically copied straight from the Classic Beacon mod by Kirazy. 
    -- Beacon2 Base
    beacon2.graphics_set.animation_list[1].animation.layers[1].hr_version = nil
    beacon2.graphics_set.animation_list[1].animation.layers[1] = {
        filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/beacon2-base.png",
        width = 232,
        height = 186,
        shift = util.by_pixel(11*(4/3), 1.5*(4/3)),
        scale = 0.5*(4/3),
    }
    -- Beacon2 Base Shadow
    beacon2.graphics_set.animation_list[1].animation.layers[2].hr_version = nil
    beacon2.graphics_set.animation_list[1].animation.layers[2] = {
        filename = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/entity/beacon/hr-beacon-base-shadow.png",
        width = 232,
        height = 186,
        shift = util.by_pixel(11*(4/3), 1.5*(4/3)),
        draw_as_shadow = true,
        scale = 0.5*(4/3),
    }
    -- Beacon2 Antenna Base
    beacon2.graphics_set.animation_list[2].animation.layers[1].hr_version = nil
    beacon2.graphics_set.animation_list[2].animation.layers[1] = {
        filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/hr-beacon-antenna-green.png",
        width = 108,
        height = 100,
        line_length = 8,
        frame_count = 32,
        animation_speed = 0.5,
        shift = util.by_pixel(-1*(4/3), -55*(4/3)),
        scale = 0.5*(4/3),
    }
    -- Beacon2 Antenna Shadow
    beacon2.graphics_set.animation_list[2].animation.layers[2].hr_version = nil
    beacon2.graphics_set.animation_list[2].animation.layers[2] = {
        filename = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/entity/beacon/hr-beacon-antenna-shadow.png",
        width = 126,
        height = 98,
        line_length = 8,
        frame_count = 32,
        animation_speed = 0.5,
        shift = util.by_pixel(100.5*(4/3), 15.5*(4/3)),
        draw_as_shadow = true,
        scale = 0.5*(4/3),
    }

beacon2.water_reflection = {
    pictures = {
        filename = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/entity/beacon/beacon-reflection.png",
        priority = "extra-high",
        width = 24,
        height = 28,
        shift = util.by_pixel(0*(4/3), 55*(4/3)),
        variation_count = 1,
        scale = 5*(4/3),
    },
    rotate = false,
    orientation_to_variation = false
}

--beacon mk3 
local beacon3 = util.table.deepcopy(beacon_fake)
beacon3.name = "wr-beacon-3"
beacon3.module_slots = 20
beacon3.supply_area_distance = 14
--beacon3.module_specification.module_info_max_icons_per_row = 5
--beacon3.module_specification.module_info_max_icon_rows = 4
beacon3.icons_positioning = {{
    inventory_index = defines.inventory.beacon_modules,
    max_icons_per_row = 5,
    scale = .5,
    separation_multiplier = 1.1,
    multi_row_initial_height_modifier = (-1.3-.3)/2 - .05
}}
beacon3.minable.results = {{type = "item", name = "wr-beacon-3", amount = 1}}
beacon3.collision_box = {{-1.8, -1.8}, {1.8, 1.8}}
beacon3.selection_box = {{-2, -2}, {2, 2}}
beacon3.drawing_box = {{-2, -2}, {2, 2}}
beacon3.energy_usage = "20MW"
if beacon3.next_upgrade then beacon3.next_upgrade = nil end
beacon3.profile = beacon_profile
beacon3.distribution_effectivity = 1
beacon3.beacon_counter = "total"

--the below is basically copied straight from the Classic Beacon mod by Kirazy. 
    -- Beacon3 Base
    beacon3.graphics_set.animation_list[1].animation.layers[1].hr_version = nil
    beacon3.graphics_set.animation_list[1].animation.layers[1] = {
        filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/beacon3-base.png",
        width = 232,
        height = 186,
        shift = util.by_pixel(11*(4/3), 1.5*(4/3)),
        scale = 0.5*(4/3),
    }
    -- Beacon3 Base Shadow
    beacon3.graphics_set.animation_list[1].animation.layers[2].hr_version = nil
    beacon3.graphics_set.animation_list[1].animation.layers[2] = {
        filename = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/entity/beacon/hr-beacon-base-shadow.png",
        width = 232,
        height = 186,
        shift = util.by_pixel(11*(4/3), 1.5*(4/3)),
        draw_as_shadow = true,
        scale = 0.5*(4/3),
    }
    -- Beacon3 Antenna Base
    beacon3.graphics_set.animation_list[2].animation.layers[1].hr_version = nil
    beacon3.graphics_set.animation_list[2].animation.layers[1] = {
        filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/hr-beacon-antenna-blue.png",
        width = 108,
        height = 100,
        line_length = 8,
        frame_count = 32,
        animation_speed = 0.5,
        shift = util.by_pixel(-1*(4/3), -55*(4/3)),
        scale = 0.5*(4/3),
    }
    -- Beacon3 Antenna Shadow
    beacon3.graphics_set.animation_list[2].animation.layers[2].hr_version = nil
    beacon3.graphics_set.animation_list[2].animation.layers[2] = {
        filename = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/entity/beacon/hr-beacon-antenna-shadow.png",
        width = 126,
        height = 98,
        line_length = 8,
        frame_count = 32,
        animation_speed = 0.5,
        shift = util.by_pixel(100.5*(4/3), 15.5*(4/3)),
        draw_as_shadow = true,
        scale = 0.5*(4/3),
    }

beacon3.water_reflection = {
    pictures = {
        filename = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/entity/beacon/beacon-reflection.png",
        priority = "extra-high",
        width = 24,
        height = 28,
        shift = util.by_pixel(0*(4/3), 55*(4/3)),
        variation_count = 1,
        scale = 5*(4/3),
    },
    rotate = false,
    orientation_to_variation = false
}

--beacon mk1 (put last so it doesnt interfere with the others)
local beacon = data.raw["beacon"]["beacon"]
beacon.module_slots = 8
--beacon.module_specification.module_info_max_icons_per_row = 4
beacon.energy_usage = "350kW"
--beacon.collision_box = {{-1.3, -1.3}, {1.3, 1.3}}
beacon.supply_area_distance = 3
beacon.icons_positioning = {{
    inventory_index = defines.inventory.beacon_modules,
    max_icons_per_row = 4,
    scale = .5,
    separation_multiplier = 1.1,
    multi_row_initial_height_modifier = -.3
}}
beacon.profile = beacon_profile
beacon.distribution_effectivity = 1
beacon.beacon_counter = "total"

if settings.startup["wret-overload-enable-notnotmelon-style"].value == true then
	beacon.module_specification.module_slots = 4
	beacon.supply_area_distance = 9.2
	beacon.energy_usage = "1050KW"
end

if settings.startup["wret-overload-enable-beaconmk2"].value == true then
    beacon2.icons = data.raw["item"]["wr-beacon-2"].icons
	data:extend{beacon2}
end

if settings.startup["wret-overload-enable-beaconmk3"].value == true then
    beacon3.icons = data.raw["item"]["wr-beacon-3"].icons
	data:extend{beacon3}
end

data:extend{
	beacon,

		--the beacon overload sprite
	{
		type = 'sprite',
		name = 'beacon-overload',
		filename = '__wret-beacon-rebalance-mod__/graphics/icon/beacon-overload.png',
		priority = 'extra-high-no-scale',
		width = 64,
		height = 64,
		flags = {'icon'}
	},
}