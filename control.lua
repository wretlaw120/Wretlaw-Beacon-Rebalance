--wretlaw120 edition

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

if settings.startup["wret-overload-disable-overloaded"].value == false then
	local overloaded_machines = storage.overloaded_machines or {}
	storage.overloaded_machines = overloaded_machines
	for _,v in pairs(overloaded_machines) do
		if v[1].valid then enable(v[1]) end
	end
return end

local filter_build = {{filter = "type", type = "beacon"},
	{filter = "type", type = "assembling-machine", mode = "or"},
	{filter = "type", type = "furnace", mode = "or"},
	{filter = "type", type = "rocket-silo", mode = "or"},
}
local filter_destroy = {{filter = "type", type = "beacon"}}

local function on_built_beacon_or_machine(eventdata)
	if eventdata.entity.type == "beacon" then
		local entities_to_check = eventdata.entity.get_beacon_effect_receivers()
		for _,ent in pairs(entities_to_check) do
			if ent.get_beacons()[2] then
				disable(ent)
			end
		end
	else --is crafting machine
		if eventdata.entity.get_beacons()[2] then
			disable(eventdata.entity)
		end
	end
end

local function on_destroyed_beacon_or_machine(eventdata)
	if eventdata.entity.type == "beacon" then
		local entities_to_check = eventdata.entity.get_beacon_effect_receivers()
		for _,ent in pairs(entities_to_check) do
			if ent.get_beacons()[3] then
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

	game.print("bruh")
	if event.moved_entity.type == "beacon" then
		local e = event.moved_entity
		local bb = event.moved_entity.bounding_box
		local mr = prototypes.max_beacon_supply_area_distance
		local entities_to_check = e.surface.find_entities_filtered({area = {
			{bb.left_top.x - 1 - mr, bb.left_top.y - 1 - mr},
			{bb.right_bottom.x + 1 + mr, bb.right_bottom.y + 1 + mr}}
		})
		for _,ent in pairs(entities_to_check) do
			if ent.get_beacons()[2] then
				disable(ent)
			else
				enable(ent)
			end
		end
		return
	end

	if event.moved_entity.get_beacons then
		if event.moved_entity.get_beacons()[2] then
			disable(event.moved_entity)
			return
		else
			enable(event.moved_entity)
			return
		end
	end

end

local function on_load_setup()

	--if remote.interfaces["PickerDollies"] and remote.interfaces["PickerDollies"]["dolly_moved_entity_id"] then
	--	script.on_event(remote.call("PickerDollies", "dolly_moved_entity_id"), picker_dolly_move)
	--end
	--if remote.interfaces["picker-dollies"] and remote.interfaces["picker-dollies"]["dolly_moved_entity_id"] then
	--	script.on_event(remote.call("picker-dollies", "dolly_moved_entity_id"), picker_dolly_move)
	--end

end

local function setup()

	storage.beacon_tiles = {}

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

	on_load_setup()

end

script.on_init(setup)
script.on_load(on_load_setup)
script.on_configuration_changed(setup)

--script.on_init(setup)
--script.on_load(on_load_setup)
--script.on_configuration_changed(setup)

--[[
local function get_box(entity, range) --this function makes sure that any function working with area uses every tile they have any presence in.
	
	if range == nil then range = 0 end
	local collision_left_top = entity.prototype.collision_box.left_top
	local collision_right_bottom = entity.prototype.collision_box.right_bottom
	local position = entity.position
	local start_x = math.floor(entity.position.x + collision_left_top.x - range)
	local start_y = math.floor(entity.position.y + collision_left_top.y - range)
	local end_x = math.ceil(entity.position.x + collision_right_bottom.x + range - 1)
	local end_y = math.ceil(entity.position.y + collision_right_bottom.y + range - 1)
	
	return start_x, start_y, end_x, end_y
	
end

local function get_beaconable(machine) --this was a lot simpler when I thought machines needed module slots to be affected by beacons

	if machine.type == "beacon" then return false end

	local allowed_effects = machine.prototype.allowed_effects

	if allowed_effects == nil then return false end

	if type(allowed_effects) == string then return true end
	for key, value in pairs(allowed_effects) do
		if value == true then return true end
	end

	return false

end

local function detect_overload(machine)
	
	if not get_beaconable(machine) then return end
	
	--local module_inventory = machine.get_module_inventory()
	--if (module_inventory == nil or #module_inventory == 0) then return end
	
	local start_x, start_y, end_x, end_y = get_box(machine)
	local surface = machine.surface
	local surface_name = machine.surface.name
	local beacon_tiles = storage.beacon_tiles[surface_name] or {}
	storage.beacon_tiles[surface_name] = beacon_tiles
	local overloaded_machines = storage.overloaded_machines or {}
	storage.overloaded_machines = overloaded_machines
	local machine_number = machine.unit_number
	
	local function disable_machine() --function that disables the machines, adds floating text, warning label, and adds the machine to list a of disabled machines
		if storage.overloaded_machines[machine_number] == nil then
			surface.create_entity{
				name = "flying-text",
				position = machine.position,
				text = {"beacon-overload"}
			}
			machine.active = false
			storage.overloaded_machines[machine_number] = {
				machine, rendering.draw_sprite{
					sprite = "beacon-overload",
					x_scale = 0.5,
					y_scale = 0.5,
					target = machine,
					surface = surface
				}	
			}
		end
	end
	
	local beacon_tile_number = nil
	local previous_beacon_number = nil
	
	for marker_x = start_x, end_x do --goes through tiles the machine occupies and does two things
		if beacon_tiles[marker_x] ~= nil then
			for marker_y = start_y, end_y do
				if beacon_tiles[marker_x][marker_y] ~= nil then
					if type(beacon_tiles[marker_x][marker_y]) == "number" then beacon_tiles[marker_x][marker_y] = {} end
					if #beacon_tiles[marker_x][marker_y] > 1 then --if the number of beacons affecting a tile under the machine is more than one, disable machine
						disable_machine()
						return
					elseif #beacon_tiles[marker_x][marker_y] == 1 then --detects if there are multiple beacons affecting the same machine on different tiles
						beacon_tile_number = beacon_tiles[marker_x][marker_y][1]
						if previous_beacon_number == nil then previous_beacon_number = beacon_tile_number end
						if beacon_tile_number ~= previous_beacon_number then
							disable_machine()
							return
						end
						previous_beacon_number = beacon_tile_number
					end
				end
			end
		end
	end
	
	if storage.overloaded_machines[machine_number] ~= nil then --if the machine is in a state where it should not be overloaded, this part fixes that
		surface.create_entity{
			name = "flying-text",
			position = machine.position,
			text = {"beacon-overload-ended"}
		}
		machine.active = true
		rendering.destroy(storage.overloaded_machines[machine_number][2])
		storage.overloaded_machines[machine_number] = nil
	end
	
end

local function update_beacon_tiles(beacon, mode, limbo)
	
	local range = beacon.prototype.supply_area_distance
	local start_x, start_y, end_x, end_y = get_box(beacon, range)
	local surface = beacon.surface
	local surface_name = surface.name
	local beacon_tiles = storage.beacon_tiles[surface_name] or {}
	storage.beacon_tiles[surface_name] = beacon_tiles
	local dolly_limbo = {}
	local beacon_number = beacon.unit_number
	local overload_mode = "normal"

	if mode == "dolly-remove" then --picker dollies compatibility
		overload_mode = "dolly-remove"
		mode = "remove"
		start_x = start_x - 1
		start_y = start_y - 1
		end_x = end_x + 1
		end_y = end_y + 1
		dolly_limbo = surface.find_entities{{start_x, start_y}, {(end_x + 1), (end_y + 1)}}
		--game.print(#dolly_limbo)
	elseif mode == "dolly-add" then
		mode = "add"
		overload_mode = "dolly-add"
	end

	if mode == "add" then  --goes through tiles under the effect of the beacon and adds the beacon's presence
		for marker_x = start_x, end_x do
			if beacon_tiles[marker_x] == nil then
				beacon_tiles[marker_x] = {marker_x}
			end
			
			for marker_y = start_y, end_y do
				if beacon_tiles[marker_x][marker_y] == nil then
					beacon_tiles[marker_x][marker_y] = {beacon_number}
				else
					if type(beacon_tiles[marker_x][marker_y]) == "number" then beacon_tiles[marker_x][marker_y] = {} end
					table.insert(beacon_tiles[marker_x][marker_y], beacon_number)
				end
			end

		end
	end
	
	if mode == "remove" then --goes through tiles the beacon affected and removes the beacon's presence from the tiles
		for marker_x = start_x, end_x do
			if beacon_tiles[marker_x] == nil then
				beacon_tiles[marker_x] = {marker_x}
			end

			for marker_y = start_y, end_y do
				if beacon_tiles[marker_x][marker_y] ~= nil then
					if type(beacon_tiles[marker_x][marker_y]) == "number" then beacon_tiles[marker_x][marker_y] = {} end
					for key, number in ipairs(beacon_tiles[marker_x][marker_y]) do
						if number == beacon_number then
							table.remove(beacon_tiles[marker_x][marker_y], key)
						end
					end
				end
			end

		end
	end
	
	if overload_mode == "normal" then
		for _, entity in ipairs(surface.find_entities{{start_x, start_y}, {(end_x + 1), (end_y + 1)}}) do --finds entities within range of the beacon and checks them
			detect_overload(entity)
		end
	elseif overload_mode == "dolly-add" then
		for _, entity in pairs(limbo) do
			--game.print("aaaa")
			detect_overload(entity)
		end
		--game.print(serpent.block(limbo))
		dolly_limbo = {}
	end

	return dolly_limbo
	
end

local function on_built(event)
	
	if not event.created_entity and not event.entity then return end
	local entity = event.created_entity or event.entity
	local surface = entity.surface
	local surface_name = surface.name
	
	if entity.type == "beacon" then
		update_beacon_tiles(entity, "add")
		return
	end
	
	--the following is for testing the tiles underneath the placed lamp
	if entity.type == "lamp" and settings.global["wret-overload-enable-lamp-tile-detection"].value == true then
		local beacon_tiles = storage.beacon_tiles[surface_name] or {}
		storage.beacon_tiles[surface_name] = beacon_tiles
		local marker_x, marker_y = get_box(entity)
		if beacon_tiles[marker_x] ~= nil and beacon_tiles[marker_x][marker_y] ~= nil then
			if #beacon_tiles[marker_x][marker_y] > 0 then
				local beacons = {#beacon_tiles[marker_x][marker_y]}
				for _, beacon in ipairs(beacon_tiles[marker_x][marker_y]) do
					beacons[(#beacons+1)] = tostring(beacon)
				end
				beacon_list = table.concat(beacons, "   ")
				game.print(beacon_list)
			else
				game.print(0)
			end
		else
			game.print(0)
		end
	end
	
	detect_overload(entity)
	
end

local function picker_dolly_move(event)

	if event.moved_entity.prototype.type == "beacon" then
		update_beacon_tiles(event.moved_entity, "dolly-add", update_beacon_tiles(event.moved_entity, "dolly-remove")) --lol
		return
	end

	detect_overload(event.moved_entity)

end

local function on_load_setup()

	if remote.interfaces["PickerDollies"] and remote.interfaces["PickerDollies"]["dolly_moved_entity_id"] then
		script.on_event(remote.call("PickerDollies", "dolly_moved_entity_id"), picker_dolly_move)
	end

end

local function setup()
	
	storage.beacon_tiles = {}
	
	for _, surface in pairs(game.surfaces) do
		for _, beacon in ipairs(surface.find_entities_filtered{type="beacon"}) do
			update_beacon_tiles(beacon, "add")
		end
	end

	for _,force in pairs(game.forces) do
		if force.technologies["effect-transmission-2"] and force.technologies["effect-transmission-2"].researched then
			force.recipes["wr-beacon-2-recipe"].enabled = true
		end
		if force.technologies["effect-transmission-3"] and force.technologies["effect-transmission-3"].researched then
			force.recipes["wr-beacon-3-recipe"].enabled = true
		end
	end

	on_load_setup()
	
end

script.on_init(setup)
script.on_load(on_load_setup)
script.on_configuration_changed(setup)

script.on_event(defines.events.on_built_entity, on_built)
script.on_event(defines.events.on_robot_built_entity, on_built)
script.on_event(defines.events.on_entity_cloned, on_built)
script.on_event(defines.events.script_raised_built, on_built)
script.on_event(defines.events.script_raised_revive, on_built)

local function on_destroyed(event)
	local entity = event.entity
	
	if entity.type == "beacon" then
		update_beacon_tiles(entity, "remove")
	end
	
end

local filter = {{filter = "type", type = "beacon"}}
script.on_event(defines.events.on_player_mined_entity, on_destroyed, filter)
script.on_event(defines.events.on_robot_mined_entity, on_destroyed, filter)
script.on_event(defines.events.on_entity_died, on_destroyed, filter)
script.on_event(defines.events.script_raised_destroy, on_destroyed, filter)

--[[

ive tried but i just dont think that this system can work with area cloning 

local function on_area_clone(event)
	game.print("skadoosh")
	local biggest_beacon_radius = 35
	--if event.clone_entities ~= true then return end
	log(serpent.block(event))
	--game.print(serpent.block(event.destination_area))
	--game.print(serpent.block(event.source_area))
	local new_destination_area = {
		{event.destination_area.left_top.x - biggest_beacon_radius, event.destination_area.left_top.y - biggest_beacon_radius},
		{event.destination_area.right_bottom.x + biggest_beacon_radius, event.destination_area.right_bottom.y + biggest_beacon_radius}
	}
	local destination_beacons = event.destination_surface.find_entities_filtered({
		area = event.destination_area,
		type = "beacon",
	})
	local source_beacons = event.source_surface.find_entities_filtered({
		area = event.source_area,
		type = "beacon",
	})
	local destination_entities = event.destination_surface.find_entities_filtered({
		area = new_destination_area,
		type = "beacon",
	})
	
	--game.print(#destination_entities)
	local beacon_list = {}
	for _,beacon in pairs(destination_beacons) do
		--if not beacon.valid then game.print(beacon.valid) end
		update_beacon_tiles(beacon, "add")
		table.insert(beacon_list, beacon.unit_number)
	end
	game.print(serpent.block(beacon_list))
	log(serpent.block(beacon_list))


	local surface_name = event.destination_surface.name
	local beacon_tiles = storage.beacon_tiles[surface_name] or {}
	storage.beacon_tiles[surface_name] = beacon_tiles

	for marker_x = event.destination_area.left_top.x - biggest_beacon_radius, event.destination_area.right_bottom.x + biggest_beacon_radius do
		if beacon_tiles[marker_x] == nil then
			beacon_tiles[marker_x] = {marker_x}
		end

		for marker_y = event.destination_area.left_top.y - biggest_beacon_radius, event.destination_area.right_bottom.y + biggest_beacon_radius do
			if beacon_tiles[marker_x][marker_y] ~= nil then
				if type(beacon_tiles[marker_x][marker_y]) == "number" then beacon_tiles[marker_x][marker_y] = {} end
				for key, number in ipairs(beacon_tiles[marker_x][marker_y]) do
					local still_exists = false
					--log(serpent.block(beacon_list))
					--log(serpent.block(beacon_tiles[marker_x][marker_y]))
					for key_2, beacon_number in ipairs(beacon_list) do
						if number == beacon_number then 
							still_exists = true 
							game.print("asd2") 
							log(serpent.block(number))
						end
						--game.print("asd")
					end
					if not still_exists then 
						log(serpent.block(beacon_tiles[marker_x][marker_y][key])) 
						beacon_tiles[marker_x][marker_y][key] = nil
					end
				end
			end
		end
	end

	for _,entity in pairs(destination_entities) do 
		detect_overload(entity)
	end

end

script.on_event(defines.events.on_area_cloned, on_area_clone)
script.on_event(defines.events.on_brush_cloned, on_area_clone)--]]