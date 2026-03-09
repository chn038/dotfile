local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Rosé Pine (Gogh)'

config.font = wezterm.font 'FiraCode Nerd Font Mono'
config.font_size = 12
config.use_ime = true
config.enable_tab_bar = false
config.enable_wayland = false

return config
