require("lib")

player_list = {}

script.on_init(function()
  local technologies_to_research = {
    'quality-module',
    'epic-quality',
    'legendary-quality'
  }

  for _, tech_name in ipairs(technologies_to_research) do
    for _, force in pairs(game.forces) do
      if force.technologies[tech_name] then
        force.technologies[tech_name].researched = true
      end
    end
  end
end)
script.on_event({ defines.events.on_cutscene_cancelled, defines.events.on_cutscene_finished }, function(event)
  setup_player_initial_items(event)
end)

script.on_event({ defines.events.on_player_created, defines.events.on_player_joined_game }, function(event)
  setup_player_initial_items(event)
end)

function setup_player_initial_items(event)
  local player = game.get_player(event.player_index)

  if (player) then
    if Contains(player_list, player) then return end
    if (player.controller_type ~= defines.controllers.character) then return end
    local player_inventory = player.character.get_inventory(defines.inventory.character_main)

    if player_inventory then
      player_inventory.clear()

      local difficulty = settings.startup["difficulty"].value
      if difficulty == "Default" then
        player_inventory.insert({ name = "stone-furnace", quality = "legendary", count = 2 })
        player_inventory.insert({ name = "burner-mining-drill", count = 1})
        player_inventory.insert({ name = "burner-recycler", quality = "legendary", count = 2 })
        player_inventory.insert({ name = "burner-assembling-machine", quality = "legendary", count = 2 })
        player_inventory.insert({ name = "burner-inserter", quality = "legendary", count = 6 })
        player_inventory.insert({ name = "wooden-chest", quality = "legendary", count = 2 })
      end
      if difficulty == "Hard" then
        player_inventory.insert({ name = "stone-furnace", quality = "legendary", count = 2 })
        player_inventory.insert({ name = "burner-mining-drill", count = 1})
        player_inventory.insert({ name = "burner-recycler", quality = "legendary", count = 2 })
        player_inventory.insert({ name = "burner-assembling-machine", quality = "legendary", count = 1 })
        player_inventory.insert({ name = "burner-inserter", quality = "legendary", count = 4 })
        player_inventory.insert({ name = "wooden-chest", quality = "legendary", count = 1 })
      end
      if difficulty == "Very Hard" then
        player_inventory.insert({ name = "stone-furnace", quality = "legendary", count = 1 })
        player_inventory.insert({ name = "burner-mining-drill", count = 1})
        player_inventory.insert({ name = "burner-recycler", quality = "legendary", count = 1 })
        player_inventory.insert({ name = "burner-assembling-machine", quality = "legendary", count = 1 })
        player_inventory.insert({ name = "burner-inserter", quality = "legendary", count = 2 })
        player_inventory.insert({ name = "wooden-chest", quality = "legendary", count = 1 })
      end
      if difficulty == "Masochist" then
        player_inventory.insert({ name = "stone-furnace", quality = "legendary", count = 1 })
        player_inventory.insert({ name = "burner-mining-drill", count = 1})
        player_inventory.insert({ name = "burner-assembling-machine", quality = "legendary", count = 1 })
      end
    end
  end
end
local ignore_group = {
  'logistics'
}

local sub_groups_to_check = {
  'transport',
  'train-transport',
  'energy-pipe-distribution',
  'storage',
  'container'
}

local sub_groups_to_forbid = {
  'logistic-network',
  'inserter',
}

local names_to_check = {
  'spidertron',
  'tank',
  'logistic-robot',
  'construcion-robot',
  'roboport',
  'artillery-wagon',
  'small-electric-pole',
  'medium-electric-pole',
  'big-electric-pole',
  'substation',
  'pump',
  'wooden-chest',
  'iron-chest',
  'steel-chest'
}

local function contains(array, target)
  for _, value in ipairs(array) do
    if value == target then
      return true
    end
  end
  return false
end

local function destroy_not_legendary(player, entity, game, item)
  if (player ~= nil) then
    if (entity.quality.level ~= 5) then
      if (entity.is_registered_for_construction()) then
        player.create_local_flying_text({ text = "Cannot place non lengedary ghost entities.", create_at_cursor = true })
      elseif (entity.can_be_destroyed()) then
        local inventory = player.get_main_inventory()
        if (inventory ~= nil) then
          inventory.insert(item)
        end
        player.create_local_flying_text({ text = "Cannot place non lengedary entities.", create_at_cursor = true })
      end
      game.play_sound({ path = "utility/cannot_build" })
      entity.destroy()
    end
  end
end

--- @param entity LuaEntity
--- @param group (string) Either "group" or "subgroup". Determines the operation.
--- @return string
function getGroupName(entity, group)
  ---@type string
  local group_name = nil
  if (entity.prototype.group.name == 'other') then
    group_name = entity.ghost_prototype[group].name
  else
    group_name = entity.prototype[group].name
  end
  assert(group_name ~= nil, "Error setting group name")
  return group_name
end

--- @param entity LuaEntity
--- @return string
function getEntityName(entity)
  ---@type string
  local name = nil
  if (entity.prototype.group.name == 'other') then
    name = entity.ghost_name
  else
    name = entity.name
  end
  assert(name ~= nil, "Error setting group name")
  return name
end

script.on_event(defines.events.on_built_entity,
  function(event)
    local player = game.get_player(event.player_index)
    local quality_level = event.entity.quality.level
    if (player ~= nil) then
      if (quality_level ~= 5) then
        local item = nil
        if (event["consumed_items"] ~= nil and #event.consumed_items > 0) then
          item = event.consumed_items[1]
        end
        local entity_name = getEntityName(event.entity)
        local group_name = getGroupName(event.entity, "group")
        local subgroup_name = getGroupName(event.entity, "subgroup")
        if (entity_name == 'burner-mining-drill') then
          return
        end
        if (contains(ignore_group, group_name)) then
          if (contains(sub_groups_to_forbid, subgroup_name)) then
            destroy_not_legendary(player, event.entity, game, item)
            return
          end
          if (contains(sub_groups_to_check, subgroup_name)) then
            if (contains(names_to_check, entity_name)) then
              destroy_not_legendary(player, event.entity, game, item)
              return
            end
          end
          return
        end
        destroy_not_legendary(player, event.entity, game, item)
      end
    end
  end
)
