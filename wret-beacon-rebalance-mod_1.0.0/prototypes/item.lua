--beacon mk1 is at the end

--beacon mk2
local beacon2 = util.table.deepcopy(data.raw["item"]["beacon"])
beacon2.name = "beacon2-item"
beacon2.place_result = "beacon2"
beacon2.icon = nil
beacon2.icons = {
	{icon = "__wret-beacon-rebalance-mod__/graphics/icon/beacon2.png", icon_size = 64, icon_mipmaps = 4},
	{icon = "__wret-beacon-rebalance-mod__/graphics/icon/two.png", icon_size = 64, icon_mipmaps = 4, scale = .25, shift = {-8, 8}}
}

--beacon mk3
local beacon3 = util.table.deepcopy(data.raw["item"]["beacon"])
beacon3.name = "beacon3-item"
beacon3.place_result = "beacon3"
beacon3.icon = nil
beacon3.icons = {
	{icon = "__wret-beacon-rebalance-mod__/graphics/icon/beacon3.png", icon_size = 64, icon_mipmaps = 4},
	{icon = "__wret-beacon-rebalance-mod__/graphics/icon/three.png", icon_size = 64, icon_mipmaps = 4, scale = .25, shift = {-8, 8}}
}

--beacon mk1
local beacon = data.raw["item"]["beacon"]
beacon.icon = nil
beacon.icons = {
	{icon = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/icon/beacon.png", icon_size = 64, icon_mipmaps = 4},
	{icon = "__wret-beacon-rebalance-mod__/graphics/icon/one.png", icon_size = 64, icon_mipmaps = 4, scale = .25, shift = {-8, 8}}
}

if settings.startup["wret-overload-enable-beaconmk2"].value == true then
data:extend{
	
	beacon2,
	
	{
	name = "beacon2-recipe",
	type = "recipe",
	category = "crafting",
	ingredients = {
		{"beacon", 1},
		{"steel-plate", 20},
		{"processing-unit", 20},
		{"copper-cable", 20},
		{"radar", 2}
	},
	result = "beacon2-item",
	enabled = false
	}
}
end

if settings.startup["wret-overload-enable-beaconmk3"].value == true then
data:extend{	
	beacon3,
	
	{
	name = "beacon3-recipe",
	type = "recipe",
	category = "crafting",
	ingredients = {
		{"beacon2-item", 1},
		{"low-density-structure", 20},
		{"rocket-control-unit", 20},
		{"copper-cable", 30},
		{"accumulator", 2},
		{"substation", 2}
	},
	result = "beacon3-item",
	enabled = false
	}
}
end