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
