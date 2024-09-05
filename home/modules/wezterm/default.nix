{ inputs, ... }: {
  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.x86_64-linux.default;
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}
