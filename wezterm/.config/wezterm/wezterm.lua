local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'kanagawabones'

config.font = wezterm.font 'Terminess Nerd Font'
config.font_size = 14
config.use_ime = true
config.enable_tab_bar = false
config.enable_wayland = false

return config
