{ config, pkgs }: {
  import = [ "~/.config/alacritty/alacritty.user.yml" ./catppuccin-mocha.yml ];
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
  cursor.shape = {
    shape = "Block";
    blinking = "Off";
  };
  shell.program = "${config.programs.tmux.package}/bin/tmux";
}
