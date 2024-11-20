local container = {}

local item = table.deepcopy(data.raw["item"]["recycler"])

item.name = "burner-recycler"
item.order = "c-[recycler]-d[burner-recycler]"
item.place_result = "burner-recycler"
table.insert(container, item)
data:extend(container)

-- Recipe

data:extend({
  {
    enabled = true,
    energy_required = 10,
    ingredients = {
      { type = "item", name = "iron-plate",         amount = 20 },
      { type = "item", name = "iron-gear-wheel",    amount = 5 },
      { type = "item", name = "electronic-circuit", amount = 3 },
    },
    name = "burner-recycler",
    results = { { type = "item", name = "burner-recycler", amount = 1 } },
    type = "recipe"
  }
})
