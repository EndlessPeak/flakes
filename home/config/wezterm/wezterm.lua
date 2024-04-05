local wezterm = require("wezterm")
local config = {
    font_size = 16,
    font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Regular"}),
    color_scheme = "Catppuccin Mocha",
    window_decorations = "RESIZE",
    window_background_opacity = 0.95,
    text_background_opacity = 0.95,
    window_padding = {
        left = 20,
        right = 20,
        top = 20,
        bottom = 5,
    },
}

return config
