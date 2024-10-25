if settings.startup["wret-overload-enable-beaconmk2"].value == true then
    data.raw["technology"]["effect-transmission-2"].unit = {
        count = 2000,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"space-science-pack", 1},
            {"electromagnetic-science-pack", 1},
        },
        time = 30,
    }
    data.raw["technology"]["effect-transmission-2"].prerequisites = {"effect-transmission", "electromagnetic-science-pack"}
    data.raw.recipe["wr-beacon-2"].ingredients = {
		{type = "item", name = "beacon", amount = 1},
		{type = "item", name = "steel-plate", amount = 20},
		{type = "item", name = "processing-unit", amount = 20},
		{type = "item", name = "superconductor", amount = 20},
	}
    data.raw.recipe["wr-beacon-2"].category = "electronics"
end

if settings.startup["wret-overload-enable-beaconmk3"].value == true then
    data.raw["technology"]["effect-transmission-3"].unit = {
        count = 4000,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1},
            {"electromagnetic-science-pack", 1},
            {"cryogenic-science-pack", 1},
        },
        time = 30,
    }
    data.raw["technology"]["effect-transmission-3"].prerequisites = {"effect-transmission-2", "quantum-processor"}
    data.raw.recipe["wr-beacon-3"].ingredients = {
		{type = "item", name = "wr-beacon-2", amount = 1},
		{type = "item", name = "low-density-structure", amount = 20},
		{type = "item", name = "quantum-processor", amount = 40},
        {type = "fluid", name = "fluoroketone-cold", amount = 40},
        {type = "item", name = "refined-concrete", amount = 20}
	}
    table.insert(data.raw.recipe["wr-beacon-3"].results, {type = "fluid", name = "fluoroketone-hot", amount = 20})
    data.raw.recipe["wr-beacon-3"].category = "electronics"
    data.raw.recipe["wr-beacon-3"].main_product = "wr-beacon-3"
end