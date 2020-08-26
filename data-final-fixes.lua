local multiplier = settings.startup["buff-solar"].value

if settings.startup["disable-alternate-solar"].value then
    data.raw.technology["bob-solar-energy-4"].enabled = false
    data.raw.technology["bob-electric-energy-accumulators-4"].enabled = false
    for _, tech in pairs(data.raw.technology) do
        if tech.prerequisites then
            bobmods.lib.tech.replace_prerequisite(tech.name, "bob-solar-energy-4", "bob-solar-energy-3")
            bobmods.lib.tech.replace_prerequisite(tech.name, "bob-electric-energy-accumulators-4", "bob-electric-energy-accumulators-3")
        end
    end
    for i = 2, 3 do
        data.raw.technology["bob-solar-energy-"..i].effects = {
            {
                type = "unlock-recipe",
                recipe = "solar-panel-"..i
            }
        }
        data.raw.technology["bob-electric-energy-accumulators-"..i].effects = {
            {
                type = "unlock-recipe",
                recipe = "large-accumulator-"..i
            }
        }
    end
    data.raw.technology["electric-energy-accumulators"].effects = {
        {
            type = "unlock-recipe",
            recipe = "large-accumulator"
        }
    }
    bobmods.lib.tech.add_science_pack("bob-solar-energy-2", "chemical-science-pack", 1)
    bobmods.lib.tech.add_science_pack("bob-solar-energy-3", "production-science-pack", 1)
    bobmods.lib.tech.add_science_pack("bob-electric-energy-accumulators-2", "chemical-science-pack", 1)
    bobmods.lib.tech.add_science_pack("bob-electric-energy-accumulators-3", "production-science-pack", 1)

    if mods['ScienceCostTweakerM'] then
        bobmods.lib.tech.replace_prerequisite('sct-lab-t3', 'bob-solar-energy-2', 'solar-energy')
    end

    data.raw.item["large-accumulator"].localised_name = {"item-name.accumulator"}
    data.raw.item["large-accumulator-2"].localised_name = {"item-name.accumulator-2"}
    data.raw.item["large-accumulator-3"].localised_name = {"item-name.accumulator-3"}
    data.raw.accumulator["large-accumulator"].localised_name = {"entity-name.accumulator"}
    data.raw.accumulator["large-accumulator-2"].localised_name = {"entity-name.accumulator-2"}
    data.raw.accumulator["large-accumulator-3"].localised_name = {"entity-name.accumulator-3"}

    data.raw.item["large-accumulator"].icon = "__Better_Bobs_Solar__/graphics/icons/large-accumulator.png"
    data.raw.item["large-accumulator"].icon_size = 32
    data.raw.item["large-accumulator-2"].icon = "__Better_Bobs_Solar__/graphics/icons/large-accumulator-2.png"
    data.raw.item["large-accumulator-2"].icon_size = 32
    data.raw.item["large-accumulator-3"].icon = "__Better_Bobs_Solar__/graphics/icons/large-accumulator-3.png"
    data.raw.item["large-accumulator-3"].icon_size = 32
    data.raw.item["solar-panel"].icon = "__Better_Bobs_Solar__/graphics/icons/solar-panel.png"
    data.raw.item["solar-panel"].icon_size = 32
    data.raw.item["solar-panel-2"].icon = "__Better_Bobs_Solar__/graphics/icons/solar-panel-2.png"
    data.raw.item["solar-panel-2"].icon_size = 32
    data.raw.item["solar-panel-3"].icon = "__Better_Bobs_Solar__/graphics/icons/solar-panel-3.png"
    data.raw.item["solar-panel-3"].icon_size = 32

    for i = 1, 3 do
        local acc
        local panel
        if i ~= 1 then
            acc = data.raw.accumulator["large-accumulator-"..i].energy_source
            panel = data.raw["solar-panel"]["solar-panel-"..i]
        else
            acc = data.raw.accumulator["large-accumulator"].energy_source
            panel = data.raw["solar-panel"]["solar-panel"]
        end
        acc.buffer_capacity = (5*multiplier^(i-1)).."MJ"
        acc.input_flow_limit = (300*multiplier^(i-1)).."kW"
        acc.output_flow_limit = (300*multiplier^(i-1)).."kW"
        panel.production = (60*multiplier^(i-1)).."kW"
    end

    bobmods.lib.recipe.replace_ingredient_in_all('solar-panel-small', 'solar-panel')
    bobmods.lib.recipe.replace_ingredient_in_all('solar-panel-small-2', 'solar-panel-2')
    bobmods.lib.recipe.replace_ingredient_in_all('solar-panel-small-3', 'solar-panel-3')
    bobmods.lib.recipe.replace_ingredient_in_all('solar-panel-large', 'solar-panel')
    bobmods.lib.recipe.replace_ingredient_in_all('solar-panel-large-2', 'solar-panel-2')
    bobmods.lib.recipe.replace_ingredient_in_all('solar-panel-large-3', 'solar-panel-3')

    bobmods.lib.recipe.replace_ingredient_in_all('accumulator', 'large-accumulator')
    bobmods.lib.recipe.replace_ingredient_in_all('fast-accumulator', 'large-accumulator')
    bobmods.lib.recipe.replace_ingredient_in_all('slow-accumulator', 'large-accumulator')
    bobmods.lib.recipe.replace_ingredient_in_all('fast-accumulator-2', 'large-accumulator-2')
    bobmods.lib.recipe.replace_ingredient_in_all('slow-accumulator-2', 'large-accumulator-2')
    bobmods.lib.recipe.replace_ingredient_in_all('fast-accumulator-3', 'large-accumulator-3')
    bobmods.lib.recipe.replace_ingredient_in_all('slow-accumulator-3', 'large-accumulator-3')
else
    local panels = {
        "solar-panel-small",
        "solar-panel",
        "solar-panel-large",
    }
    local power_values = {
        ["solar-panel-small"] = 26.67,
        ["solar-panel"] = 60,
        ["solar-panel-large"] = 106.67,
    }
    local accs = {
        "fast-accumulator",
        "large-accumulator",
        "slow-accumulator",
    }
    local acc_props = {
        ["fast-accumulator"] = {
            buffer_capacity = 4,
            input_flow_limit = 240,
            output_flow_limit = 960,
        },
        ["large-accumulator"] = {
            buffer_capacity = 10,
            input_flow_limit = 600,
            output_flow_limit = 600,
        },
        ["slow-accumulator"] = {
            buffer_capacity = 4,
            input_flow_limit = 240,
            output_flow_limit = 30,
        },
    }
    for _, panel in pairs(panels) do
        data.raw["solar-panel"][panel.."-2"].production = (power_values[panel] * multiplier).."kW"
        data.raw["solar-panel"][panel.."-3"].production = (power_values[panel] * multiplier^2).."kW"
    end
    for _, acc in pairs(accs) do
        data.raw["accumulator"][acc.."-2"].energy_source.buffer_capacity = (acc_props[acc].buffer_capacity * multiplier).."MJ"
        data.raw["accumulator"][acc.."-3"].energy_source.buffer_capacity = (acc_props[acc].buffer_capacity * multiplier^2).."MJ"
        data.raw["accumulator"][acc.."-2"].energy_source.input_flow_limit = (acc_props[acc].input_flow_limit * multiplier).."kW"
        data.raw["accumulator"][acc.."-3"].energy_source.input_flow_limit = (acc_props[acc].input_flow_limit * multiplier^2).."kW"
        data.raw["accumulator"][acc.."-2"].energy_source.output_flow_limit = (acc_props[acc].output_flow_limit * multiplier).."kW"
        data.raw["accumulator"][acc.."-3"].energy_source.output_flow_limit = (acc_props[acc].output_flow_limit * multiplier^2).."kW"
    end
end