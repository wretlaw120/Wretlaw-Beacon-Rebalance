local technology = table.deepcopy(data.raw["technology"]["effect-transmission"])
technology.upgrade = "true"

if settings.startup["wret-overload-enable-beaconmk2"].value == true then
	data:extend{
		technology,
		--effect transmission 2 (beacon mk 2)
		{
		name = "effect-transmission-2",
		type = "technology",
		icon = data.raw["technology"]["effect-transmission"].icon,
		icon_size = data.raw["technology"]["effect-transmission"].icon_size,
		upgrade = "true",
		unit = {
			count = 400,
			ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
			},
			time = 30,
		},
		prerequisites = {"effect-transmission", "utility-science-pack"},
		effects = {
			{type = "unlock-recipe", recipe = "beacon2-recipe"},
		},
		},
	}
end

if settings.startup["wret-overload-enable-beaconmk3"].value == true then
	data:extend{
		technology,
		--effect transmission 3 (beacon mk 3)
		{
		name = "effect-transmission-3",
		type = "technology",
		icon = data.raw["technology"]["effect-transmission"].icon,
		icon_size = data.raw["technology"]["effect-transmission"].icon_size,
		upgrade = "true",
		unit = {
			count = 1000,
			ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1},
			},
			time = 30,
		},
		prerequisites = {"effect-transmission-2", "space-science-pack", "electric-energy-distribution-2"},
		effects = {
			{type = "unlock-recipe", recipe = "beacon3-recipe"}
		},
	}
	}
end