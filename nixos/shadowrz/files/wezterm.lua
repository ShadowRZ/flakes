-- Pull in the wezterm API
local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Dracula (Official)'
config.font = wezterm.font_with_fallback(
  {
    'Iosevka Minoko Term',
    'Sarasa Term SC'
  },
  {
    weight = 'ExtraLight'
  }
)
config.font_size = 16.0
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0
}

config.window_frame = {
  font = wezterm.font { family = 'Iosevka Minoko', weight = 'Bold', stretch = 'Expanded' },
  font_size = 12.0,
  active_titlebar_bg = '#272e33',
  inactive_titlebar_bg = '#272e33'
}
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'

return config
