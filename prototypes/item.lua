--beacon mk1 is at the end

--beacon mk2
local beacon2 = util.table.deepcopy(data.raw["item"]["beacon"])
beacon2.name = "wr-beacon-2"
beacon2.place_result = "wr-beacon-2"
beacon2.order = "a[beacon]-z2"
beacon2.icon = nil
beacon2.icons = {
	{icon = "__wret-beacon-rebalance-mod__/graphics/icon/beacon2.png", icon_size = 64, icon_mipmaps = 4},
	{icon = "__wret-beacon-rebalance-mod__/graphics/icon/two.png", icon_size = 64, icon_mipmaps = 4, scale = .25, shift = {-8, 8}}
}

--beacon mk3
local beacon3 = util.table.deepcopy(data.raw["item"]["beacon"])
beacon3.name = "wr-beacon-3"
beacon3.place_result = "wr-beacon-3"
beacon3.order = "a[beacon]-z3"
beacon3.icon = nil
beacon3.icons = {
	{icon = "__wret-beacon-rebalance-mod__/graphics/icon/beacon3.png", icon_size = 64, icon_mipmaps = 4},
	{icon = "__wret-beacon-rebalance-mod__/graphics/icon/three.png", icon_size = 64, icon_mipmaps = 4, scale = .25, shift = {-8, 8}}
}

--[[beacon mk1 (done in classic beacon part)
local beacon = data.raw["item"]["beacon"]
beacon.icon = nil
beacon.icons = {
	{icon = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/icon/beacon.png", icon_size = 64, icon_mipmaps = 4},
	{icon = "__wret-beacon-rebalance-mod__/graphics/icon/one.png", icon_size = 64, icon_mipmaps = 4, scale = .25, shift = {-8, 8}}
}]]

if settings.startup["wret-overload-enable-beaconmk2"].value == true then
data:extend{
	
	beacon2,
	
	{
	name = "wr-beacon-2",
	type = "recipe",
	category = "crafting",
	ingredients = {
		{type = "item", name = "beacon", amount = 1},
		{type = "item", name = "steel-plate", amount = 20},
		{type = "item", name = "processing-unit", amount = 20},
		{type = "item", name = "copper-cable", amount = 20},
		{type = "item", name = "radar", amount = 2}
	},
	results = {{type = "item", name = "wr-beacon-2", amount = 1}},
	enabled = false,
	energy_required = data.raw["recipe"]["beacon"].energy_required * 2,
	}
}
end

if settings.startup["wret-overload-enable-beaconmk3"].value == true then
data:extend{	
	beacon3,
	
	{
	name = "wr-beacon-3",
	type = "recipe",
	category = "crafting",
	ingredients = {
		{type = "item", name = "wr-beacon-2", amount = 1},
		{type = "item", name = "low-density-structure", amount = 20},
		{type = "item", name = "processing-unit", amount = 40},
		{type = "item", name = "copper-cable", amount = 30},
		{type = "item", name = "accumulator", amount = 2},
		{type = "item", name = "substation", amount = 2}
	},
	results = {{type = "item", name = "wr-beacon-3", amount = 1}},
	enabled = false,
	energy_required = data.raw["recipe"]["beacon"].energy_required * 4,
	}
}
end