data:extend({
    {
        type = "bool-setting",
        name = "disable-alternate-solar",
        setting_type = "startup",
        default_value = true,
    },
    {
        type = "double-setting",
        name = "buff-solar",
        setting_type = "startup",
        default_value = 2,
        allowed_values = {1.5, 2, 4, 8},
    }
})