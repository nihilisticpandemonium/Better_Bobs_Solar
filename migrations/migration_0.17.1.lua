for _, force in pairs(game.forces) do
    if not game.technology_prototypes["bob-solar-energy-4"].enabled then
        force.technologies["bob-solar-energy-4"].enabled = false
        force.technologies["bob-electric-energy-accumulators-4"].enabled = false
    end
end