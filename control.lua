local function disable(entity)
	entity.active = false
	local overloaded_machines = storage.overloaded_machines or {}
	storage.overloaded_machines = overloaded_machines
	if storage.overloaded_machines[entity.unit_number] then return end
	storage.overloaded_machines[entity.unit_number] = {
		entity, rendering.draw_sprite{
			sprite = "beacon-overload",
			x_scale = 0.5,
			y_scale = 0.5,
			target = entity,
			surface = entity.surface
		}
	}
end

local function enable(entity)
	local overloaded_machines = storage.overloaded_machines or {}
	storage.overloaded_machines = overloaded_machines
	if storage.overloaded_machines[entity.unit_number] then
		if storage.overloaded_machines[entity.unit_number][2]
		and storage.overloaded_machines[entity.unit_number][2].valid then
			storage.overloaded_machines[entity.unit_number][2].destroy()
		end
		entity.active = true
		storage.overloaded_machines[entity.unit_number] = nil
	end
end

local whitelisted_beacons = {}

local function count_overloaders(entity)

	if not entity.valid then return 0 end
	if not entity.get_beacons then return 0 end
	if not entity.get_beacons() then return 0 end

	local count = 0
	for _,beacon in pairs(entity.get_beacons()) do
		if whitelisted_beacons[beacon.name] then else count = count + 1 end
	end
	return count

end

if settings.startup["wret-overload-disable-overloaded"].value == false then

	local overloaded_machines = storage.overloaded_machines or {}
	storage.overloaded_machines = overloaded_machines
	for _,v in pairs(overloaded_machines) do
		if v[1].valid then enable(v[1]) end
	end

	remote.add_interface("wr-beacon-rebalance", {
		add_whitelisted_beacon = function(beacon_name)
			error("a mod is attempting to create a beacon whitelist. beacon whitelists need the beacon overload setting to be enabled")
		end,
		remove_whitelisted_beacon = function(beacon_name) end,
		list_of_whitelisted_beacons = function() return {} end,
		reset_beacons = function() end
	})

	return
end

local filter_build = {
	{filter = "type", type = "beacon"},
	{filter = "type", type = "assembling-machine", mode = "or"},
	{filter = "type", type = "furnace", mode = "or"},
	{filter = "type", type = "rocket-silo", mode = "or"},
	{filter = "type", type = "lab", mode = "or"},
	{filter = "type", type = "drill", mode = "or"},
}
local filter_destroy = {{filter = "type", type = "beacon"}}

local function on_built_beacon_or_machine(eventdata)
	--game.print(eventdata.entity.type)
	--game.print(serpent.block(eventdata.entity.get_beacons()))
	if eventdata.entity.type == "beacon" then
		local entities_to_check = eventdata.entity.get_beacon_effect_receivers()
		for _,ent in pairs(entities_to_check) do
			if count_overloaders(ent) > 1 then
				disable(ent)
			end
		end
	else --is crafting machine
		if count_overloaders(eventdata.entity) > 1 then
			disable(eventdata.entity)
		end
	end
end

local function on_destroyed_beacon_or_machine(eventdata)
	if eventdata.entity.valid and eventdata.entity.type == "beacon" then
		local entities_to_check = eventdata.entity.get_beacon_effect_receivers()
		for _,ent in pairs(entities_to_check) do
			if count_overloaders(ent) > 2 then
				--disable(ent)
			else --2 or fewer beacons, and one of those is currently being destroyed
				enable(ent)
			end
		end
	else --is crafting machine
		enable(eventdata.entity)
	end
end

script.on_event(defines.events.on_built_entity, on_built_beacon_or_machine, filter_build)
script.on_event(defines.events.on_robot_built_entity, on_built_beacon_or_machine, filter_build)
script.on_event(defines.events.on_entity_cloned, on_built_beacon_or_machine, filter_build)
script.on_event(defines.events.script_raised_built, on_built_beacon_or_machine, filter_build)
script.on_event(defines.events.script_raised_revive, on_built_beacon_or_machine, filter_build)
script.on_event(defines.events.on_space_platform_built_entity, on_built_beacon_or_machine, filter_build)

script.on_event(defines.events.on_player_mined_entity, on_destroyed_beacon_or_machine, filter_destroy)
script.on_event(defines.events.on_robot_mined_entity, on_destroyed_beacon_or_machine, filter_destroy)
script.on_event(defines.events.on_entity_died, on_destroyed_beacon_or_machine, filter_destroy)
script.on_event(defines.events.script_raised_destroy, on_destroyed_beacon_or_machine, filter_destroy)
script.on_event(defines.events.on_space_platform_mined_entity, on_destroyed_beacon_or_machine, filter_destroy)

local function picker_dolly_move(event)

	if event.moved_entity.type == "beacon" then
		local e = event.moved_entity
		local bb = event.moved_entity.bounding_box
		local mr = prototypes.max_beacon_supply_area_distance
		local entities_to_check = e.surface.find_entities_filtered({area = {
			{bb.left_top.x - 1 - mr, bb.left_top.y - 1 - mr},
			{bb.right_bottom.x + 1 + mr, bb.right_bottom.y + 1 + mr}}
		})
		for _,ent in pairs(entities_to_check) do
			if count_overloaders(ent) > 1 then
				disable(ent)
			else
				enable(ent)
			end
		end
		return
	end

	if count_overloaders(event.moved_entity) > 1 then
		disable(event.moved_entity)
		return
	else
		enable(event.moved_entity)
		return
	end

end

local function interface_setup()

	if remote.interfaces["PickerDollies"] and remote.interfaces["PickerDollies"]["dolly_moved_entity_id"] then
		script.on_event(remote.call("PickerDollies", "dolly_moved_entity_id"), picker_dolly_move)
	end

end

local function recalculate_overloads()

	for _, surface in pairs(game.surfaces) do
		for _, beacon in pairs(surface.find_entities_filtered{type="beacon"}) do
			on_built_beacon_or_machine{entity = beacon}
		end
	end

	for _,force in pairs(game.forces) do
		if force.technologies["effect-transmission-2"] and force.technologies["effect-transmission-2"].researched then
			force.recipes["wr-beacon-2"].enabled = true
		end
		if force.technologies["effect-transmission-3"] and force.technologies["effect-transmission-3"].researched then
			force.recipes["wr-beacon-3"].enabled = true
		end
	end

end

local function on_load_setup()

	interface_setup()

end

local function setup()

	recalculate_overloads()

	interface_setup()

end

script.on_init(setup)
script.on_load(on_load_setup)
script.on_configuration_changed(setup)

remote.add_interface("wr-beacon-rebalance",
	{
		add_whitelisted_beacon = function(beacon_name)
			if whitelisted_beacons[beacon_name] then return end
			whitelisted_beacons[beacon_name] = true
		end,
		remove_whitelisted_beacon = function(beacon_name)
			if not whitelisted_beacons[beacon_name] then return end
			whitelisted_beacons[beacon_name] = nil
		end,
		list_of_whitelisted_beacons = function()
			local whitelist = {}
			for name,_ in pairs(whitelisted_beacons) do
				table.insert(whitelist, name)
			end
			return whitelist
		end,
		reset_beacons = function()
			recalculate_overloads()
		end
	}
)