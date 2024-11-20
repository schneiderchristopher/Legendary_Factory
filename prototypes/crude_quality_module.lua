local container = {}

local item = table.deepcopy(data.raw["module"]["quality-module"])
item.tier = 0
item.name = "quality-module-0"
item.order = "c[quality]-d[quality-module-0]"
item.effect = { quality = 0.05, speed = -0.05 }
table.insert(container, item)

data:extend(container)

-- Recipe

data:extend({
      {
         enabled = true,
         energy_required = 10,
         ingredients = {
            {type = "item", name="iron-plate", amount=20},
            {type = "item", name="copper-plate", amount=20},
         },
         name = "quality-module-0",
         results = {{type = "item", name = "quality-module-0", amount=1}},
         type = "recipe"
      }
})
            
                            
