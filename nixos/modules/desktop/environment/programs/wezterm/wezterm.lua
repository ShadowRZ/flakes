local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.xcursor_theme = 'Bibata-Modern-Ice'
config.xcursor_size = 32
config.color_scheme = 'Catppuccin Mocha'
config.font_size = 16.0

config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = wezterm.color.get_builtin_schemes()[config.color_scheme].background,
      fg_color = wezterm.color.get_builtin_schemes()[config.color_scheme].foreground,
    },
    inactive_tab = {
      bg_color = "#313244",
      fg_color = wezterm.color.get_builtin_schemes()[config.color_scheme].foreground,
    },
    inactive_tab_edge = "#313244"
  }
}

config.font = wezterm.font_with_fallback({
  { family = 'Hanekokoro Mono', weight = 'Light' },
  { family = 'Sarasa Mono SC', weight = 'Light' },
})

config.window_padding = {
  left = 2,
  right = 2,
  top = 8,
  bottom = 8
}

config.window_frame = {
  font = wezterm.font_with_fallback(
    {
      'Space Grotesk',
      'Source Han Sans SC VF'
    }
  ),
  font_size = 11,
  active_titlebar_bg = "#181825",
  inactive_titlebar_bg = "#1e1e2e",
}

config.mouse_bindings = {
  -- Bind clipboard actions to more sensible keys
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelection 'PrimarySelection',
  },
  {
    event = { Up = { streak = 2, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelection 'PrimarySelection',
  },
  {
    event = { Up = { streak = 3, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelection 'PrimarySelection',
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'SHIFT',
    action = wezterm.action.Nop,
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'ALT',
    action = wezterm.action.Nop,
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'SHIFT|ALT',
    action = wezterm.action.Nop,
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

-- FIXME: https://github.com/wez/wezterm/issues/5360
-- config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'

return config
-- vim:ts=2:sw=2:et


