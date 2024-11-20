script.on_init(function()
  local technologies_to_research = {
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

local ignore_group = {
  'logistics'
}

local sub_groups_to_check = {
  'transport',
  'train-transport',
  'energy-pipe-distribution',
}

local sub_groups_to_forbid = {
  'container',
  'logistic-network',
  'inserter'
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
  'pump'
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
        -- Handle Ghosts here
        if (event.entity.prototype.group.name == 'other') then
          if (contains(ignore_group, event.entity.ghost_prototype.group.name)) then
            if (contains(sub_groups_to_forbid, event.entity.ghost_prototype.subgroup.name)) then
              destroy_not_legendary(player, event.entity, game, item)
              return
            end
            if (contains(sub_groups_to_check, event.entity.ghost_prototype.subgroup.name)) then
              if (contains(names_to_check, event.entity.ghost_name)) then
                destroy_not_legendary(player, event.entity, game, item)
                return
              end
            end
          end
        end
        if (contains(ignore_group, event.entity.prototype.group.name)) then
          if (contains(sub_groups_to_forbid, event.entity.prototype.subgroup.name)) then
            destroy_not_legendary(player, event.entity, game, item)
            return
          end
          if (contains(sub_groups_to_check, event.entity.prototype.subgroup.name)) then
            if (contains(names_to_check, event.entity.name)) then
              destroy_not_legendary(player, event.entity, game, item)
              return
            end
          end
          return
        else
          destroy_not_legendary(player, event.entity, game, item)
          return
        end
      end
    end
  end
)
