local container = {}

local entity = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-1"])

entity.name = "burner-assembling-machine"
entity.order = "a-[burner-assembling-machine]c-[assembling-machine-1]"
entity.crafting_speed = 0.25
entity.energy_usage = "90kW"
entity.minable = { mining_time = 0.2, result = "burner-assembling-machine" }
entity.module_slots = 3
entity.energy_source =
{
  type = "burner",
  fuel_categories = { "chemical" },
  effectivity = 1,
  fuel_inventory_size = 1,
  emissions_per_minute = { pollution = 2 },
  light_flicker =
  {
    color = { 0, 0, 0 },
    minimum_intensity = 0.6,
    maximum_intensity = 0.95
  },
  smoke =
  {
    {
      name = "smoke",
      deviation = { 0.1, 0.1 },
      frequency = 5,
      position = { 0.0, -0.8 },
      starting_vertical_speed = 0.08,
      starting_frame_deviation = 60
    }
  }
}

table.insert(container, entity)
data:extend(container)
