if settings.startup["wret-overload-enable-beaconmk3"].value == true then
	settings.startup["wret-overload-enable-beaconmk2"].value = true
end
if mods["StableFoundations"] then
	settings.startup["wret-overload-disable-overloaded"].value = false
end

require("prototypes.classic_beacon")
require("prototypes.item")
require("prototypes.entity")
require("prototypes.technology")

if mods["Krastorio2"] then
	require("prototypes.compatibility.krastorio2")
end

if mods["FactorioExtended-Plus-Module"] then
	require("prototypes.compatibility.FE_plus_modules")
end