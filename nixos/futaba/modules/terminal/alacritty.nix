{ config, pkgs }: {
  import = [ "~/.config/alacritty/alacritty.user.yml" ];
  env.TERM = "xterm-256color";
  window = {
    decoration = "full";
    dynamic_title = true;
  };
  font = {
    normal.family = "Sarasa Term SC";
    size = 16;
    builtin_box_drawing = true;
  };
  colors = {
    primary = {
      background = "#2e3440";
      foreground = "#d8dee9";
      dim_foreground = "#a5abb6";
    };
    cursor = {
      text = "#2e3440";
      cursor = "#d8dee9";
    };
    vi_mode_cursor = {
      text = "#2e3440";
      cursor = "#d8dee9";
    };
    selection = {
      text = "CellForeground";
      background = "#4c566a";
    };
    search = {
      matches = {
        foreground = "CellBackground";
        background = "#88c0d0";
      };
      bar = {
        background = "#434c5e";
        foreground = "#d8dee9";
      };
    };
    normal = {
      black = "#3b4252";
      red = "#bf616a";
      green = "#a3be8c";
      yellow = "#ebcb8b";
      blue = "#81a1c1";
      magenta = "#b48ead";
      cyan = "#88c0d0";
      white = "#e5e9f0";
    };
    bright = {
      black = "#4c566a";
      red = "#bf616a";
      green = "#a3be8c";
      yellow = "#ebcb8b";
      blue = "#81a1c1";
      magenta = "#b48ead";
      cyan = "#8fbcbb";
      white = "#eceff4";
    };
    dim = {
      black = "#373e4d";
      red = "#94545d";
      green = "#809575";
      yellow = "#b29e75";
      blue = "#68809a";
      magenta = "#8c738c";
      cyan = "#6d96a5";
      white = "#aeb3bb";
    };
  };
  cursor.shape = {
    shape = "Block";
    blinking = "Off";
  };
  shell.program = "${config.programs.tmux.package}/bin/tmux";
}
