local container = {}

local entity = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-2"])

entity.name = "burner-assembling-machine"
entity.order = "a-[burner-assembling-machine]c-[assembling-machine-1]"
entity.crafting_speed = 0.25
entity.energy_usage = "90kW"
entity.minable = { mining_time = 0.2, result = "burner-assembling-machine" }
entity.module_slots = 3
entity.icon = "__Legendary_Factory__/graphics/icons/burner-assembling-machine.png"
entity.corpse = "burner-assembling-machine-remnants"

entity.crafting_categories = {"crafting", "basic-crafting", "advanced-crafting"}
if mods["space-age"] then
  table.insert(entity.crafting_categories, "electronics")
  table.insert(entity.crafting_categories, "pressing")
end

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
entity.graphics_set =
{
  animation =
  {
    layers =
    {
      {
        filename = "__Legendary_Factory__/graphics/entity/burner-assembling-machine/burner-assembling-machine.png",
        priority="high",
        width = 214,
        height = 226,
        frame_count = 32,
        line_length = 8,
        shift = util.by_pixel(0, 2),
        scale = 0.5
      },
      {
        filename = "__base__/graphics/entity/assembling-machine-1/assembling-machine-1-shadow.png",
        priority="high",
        width = 190,
        height = 165,
        line_length = 1,
        repeat_count = 32,
        draw_as_shadow = true,
        shift = util.by_pixel(8.5, 5),
        scale = 0.5
      }
    }
  }
}

local remnants = {{
  type = "corpse",
  name = "burner-assembling-machine-remnants",
  icon = "__Legendary_Factory__/graphics/icons/burner-assembling-machine.png",
  hidden_in_factoriopedia = true,
  flags = {"placeable-neutral", "not-on-map"},
  subgroup = "production-machine-remnants",
  order = "a-a-a",
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  tile_width = 3,
  tile_height = 3,
  selectable_in_game = false,
  time_before_removed = 60 * 60 * 15, -- 15 minutes
  expires = false,
  final_render_layer = "remnants",
  animation = make_rotated_animation_variations_from_sheet (3,
  {
    filename = "__Legendary_Factory__/graphics/entity/burner-assembling-machine/remnants/burner-assembling-machine-remnants.png",
    line_length = 1,
    width = 328,
    height = 282,
    direction_count = 1,
    shift = util.by_pixel(0, 9.5),
    scale = 0.5
  })
}}
table.insert(container, entity)
data:extend(container)
data:extend(remnants)
