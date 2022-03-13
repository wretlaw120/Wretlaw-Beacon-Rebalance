--beacon mk1 at end

--beacon mk2
local beacon2 = util.table.deepcopy(beacon_fake)
beacon2.name = "beacon2"
beacon2.module_specification.module_slots = 15
beacon2.supply_area_distance = 14.2
beacon2.module_specification.module_info_max_icons_per_row = 5
beacon2.module_specification.module_info_max_icon_rows = 3
beacon2.minable.result = "beacon2-item"
beacon2.collision_box = {{-1.8, -1.8}, {1.8, 1.8}}
beacon2.selection_box = {{-2, -2}, {2, 2}}
beacon2.drawing_box = {{-2, -2}, {2, 2}}
beacon2.energy_usage = "12MW"
if beacon2.next_upgrade then beacon2.next_upgrade = nil end

--the bellow is basically copied straight from the Classic Beacon mod by Kirazy. 
    -- Beacon2 Base
    beacon2.graphics_set.animation_list[1].animation.layers[1].hr_version = {
        filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/beacon2-base.png",
        width = 232,
        height = 186,
        shift = util.by_pixel(11*(4/3), 1.5*(4/3)),
        scale = 0.5*(4/3),
    }
    -- Beacon2 Base Shadow
    beacon2.graphics_set.animation_list[1].animation.layers[2].hr_version = {
        filename = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/entity/beacon/hr-beacon-base-shadow.png",
        width = 232,
        height = 186,
        shift = util.by_pixel(11*(4/3), 1.5*(4/3)),
        draw_as_shadow = true,
        scale = 0.5*(4/3),
    }
    -- Beacon2 Antenna Base
    beacon2.graphics_set.animation_list[2].animation.layers[1].hr_version = {
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
    beacon2.graphics_set.animation_list[2].animation.layers[2].hr_version = {
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
beacon3.name = "beacon3"
beacon3.module_specification.module_slots = 20
beacon3.supply_area_distance = 14.2
beacon3.module_specification.module_info_max_icons_per_row = 5
beacon3.module_specification.module_info_max_icon_rows = 4
beacon3.minable.result = "beacon3-item"
beacon3.collision_box = {{-1.8, -1.8}, {1.8, 1.8}}
beacon3.selection_box = {{-2, -2}, {2, 2}}
beacon3.drawing_box = {{-2, -2}, {2, 2}}
beacon3.energy_usage = "20MW"
if beacon3.next_upgrade then beacon3.next_upgrade = nil end

--the below is basically copied straight from the Classic Beacon mod by Kirazy. 
    -- Beacon3 Base
    beacon3.graphics_set.animation_list[1].animation.layers[1].hr_version = {
        filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/beacon3-base.png",
        width = 232,
        height = 186,
        shift = util.by_pixel(11*(4/3), 1.5*(4/3)),
        scale = 0.5*(4/3),
    }
    -- Beacon3 Base Shadow
    beacon3.graphics_set.animation_list[1].animation.layers[2].hr_version = {
        filename = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/entity/beacon/hr-beacon-base-shadow.png",
        width = 232,
        height = 186,
        shift = util.by_pixel(11*(4/3), 1.5*(4/3)),
        draw_as_shadow = true,
        scale = 0.5*(4/3),
    }
    -- Beacon3 Antenna Base
    beacon3.graphics_set.animation_list[2].animation.layers[1].hr_version = {
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
    beacon3.graphics_set.animation_list[2].animation.layers[2].hr_version = {
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
beacon.module_specification.module_slots = 8
beacon.module_specification.module_info_max_icons_per_row = 4
beacon.energy_usage = "350KW"
--beacon.collision_box = {{-1.3, -1.3}, {1.3, 1.3}}
beacon.supply_area_distance = 4.5 - beacon.collision_box[2][1]

if settings.startup["wret-overload-enable-notnotmelon-style"].value == true then
	beacon.module_specification.module_slots = 4
	beacon.supply_area_distance = 9.2
	beacon.energy_usage = "1050KW"
end

if settings.startup["wret-overload-enable-beaconmk2"].value == true then
    beacon2.icons = data.raw["item"]["beacon2-item"].icons
	data:extend{beacon2}
end

if settings.startup["wret-overload-enable-beaconmk3"].value == true then
    beacon3.icons = data.raw["item"]["beacon3-item"].icons
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