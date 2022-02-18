if settings.startup["wret-overload-enable-beaconmk3"].value == true then
	settings.startup["wret-overload-enable-beaconmk2"].value = true
end

require("prototypes.classic_beacon")
require("prototypes.item")
require("prototypes.entity")
require("prototypes.technology")

if mods["Krastorio2"] or mods["FactorioExtended-Plus-Module"] then
require("prototypes.compat")
end