local container = {}

local item = table.deepcopy(data.raw["item"]["assembling-machine-1"])

item.name = "burner-assembling-machine"
item.order = "a-[burner-assembling-machine]c-[assembling-machine-1]"
item.place_result = "burner-assembling-machine"
item.icon = "__Legendary_Factory__/graphics/icons/burner-assembling-machine.png"
table.insert(container, item)
data:extend(container)

-- Recipe

data:extend({
  {
    enabled = true,
    energy_required = 10,
    ingredients = {
      { type = "item", name = "iron-plate",         amount = 25 },
      { type = "item", name = "iron-gear-wheel",    amount = 10 },
    },
    name = "burner-assembling-machine",
    results = { { type = "item", name = "burner-assembling-machine", amount = 1 } },
    type = "recipe"
  }
})
