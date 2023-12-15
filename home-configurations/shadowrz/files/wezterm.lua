local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Sakura'
config.font_size = 19.0

config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = '#18131e',
      fg_color = '#ff65fd',
    },
    inactive_tab = {
      bg_color = '#24242e',
      fg_color = '#c05cbf',
    },
    inactive_tab_edge = '#c05cbf'
  }
}

config.font = wezterm.font_with_fallback(
  {
    'Iosevka Minoko Term',
    'Sarasa Mono SC'
  },
  {
    weight = 'ExtraLight'
  }
)

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
  active_titlebar_bg = '#24242e',
  inactive_titlebar_bg = '#24242e'
}

config.background = {
  -- This is the deepest/back-most layer. It will be rendered first
  {
    source = {
      Color = wezterm.color.get_builtin_schemes()[config.color_scheme].background
    },
    width = '100%',
    height = '100%',
  },
  -- Subsequent layers are rendered over the top of each other
  {
    source = {
      File = '@bgImage@',
    },
    height = '100%',
    horizontal_align = 'Right',
    opacity = 0.1,
  }
}
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'

return config
-- vim:ts=2:sw=2:et
