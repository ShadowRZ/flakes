local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.xcursor_theme = 'Fuchsia'
config.xcursor_size = 32
config.color_scheme = 'Catppuccin Mocha'
config.font_size = 19.0

config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = wezterm.color.get_builtin_schemes()[config.color_scheme].background,
      fg_color = wezterm.color.get_builtin_schemes()[config.color_scheme].cursor_bg,
    },
    inactive_tab = {
      bg_color = wezterm.color.get_builtin_schemes()[config.color_scheme].cursor_fg,
      fg_color = wezterm.color.get_builtin_schemes()[config.color_scheme].cursor_bg,
    },
    inactive_tab_edge = wezterm.color.get_builtin_schemes()[config.color_scheme].cursor_bg
  }
}

config.font = wezterm.font_with_fallback({
  'Iosevka Minoko Term',
  'Sarasa Mono SC'
})

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0
}

config.window_frame = {
  font = wezterm.font_with_fallback(
  {
    'Space Grotesk',
    'Source Han Sans SC VF'
  }
),
  font_size = 10.0,
  active_titlebar_bg = wezterm.color.get_builtin_schemes()[config.color_scheme].cursor_fg,
  inactive_titlebar_bg = wezterm.color.get_builtin_schemes()[config.color_scheme].cursor_fg
}

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelection 'PrimarySelection',
  },
  -- Bind 'Up' event of CTRL-Click to open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
  -- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
  {
    event = { Down = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.Nop,
  },
}

config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'

return config
-- vim:ts=2:sw=2:et
