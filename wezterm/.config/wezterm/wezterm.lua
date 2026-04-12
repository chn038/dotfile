local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Nord (Gogh)'

config.font = wezterm.font 'FiraCode Nerd Font Mono'
config.font_size = 10
config.use_ime = true
config.enable_tab_bar = false
config.enable_wayland = true

config.scrollback_lines = 10000

return config
