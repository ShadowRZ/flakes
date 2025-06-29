{
  programs.kitty = {
    enable = true;
    font = {
      name = "Hanekokoro Mono";
      size = 19;
    };
    themeFile = "rose-pine";
    settings = {
      scrollback_lines = 40000;
      show_hyperlink_targets = true;
      hide_window_decorations = true;
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_bar_min_tabs = 0;
      tab_powerline_style = "angled";
      tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}[#{index}] {title}";
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";
      wayland_enable_ime = true;
    };
  };
}
