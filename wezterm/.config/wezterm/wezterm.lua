local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'kanagawabones'

config.font = wezterm.font 'Terminess Nerd Font'
config.font_size = 14
config.use_ime = true
config.xim_im_name = "fcitx"

return config
