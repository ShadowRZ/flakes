{ config, pkgs, ... }: {
  programs = {
    alacritty = {
      enable = true;
      settings = import ./alacritty.nix { inherit config pkgs; };
    };
    tmux = {
      enable = true;
      baseIndex = 1;
      escapeTime = 0;
      keyMode = "vi";
      secureSocket = true;
      terminal = "tmux-256color";
      sensibleOnTop = true;
      shortcut = "a";
      extraConfig = builtins.readFile ./tmux.conf;
    };
  };
}
