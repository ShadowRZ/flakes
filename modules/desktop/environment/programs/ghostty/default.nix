{
  flake.modules.homeManager = {
    desktop =
      { config, ... }:
      {
        programs.ghostty = {
          enable = true;
          settings = {
            font-family = "Hanekokoro Mono";
            font-style = "Light";
            font-style-italic = "Light Italic";
            font-size = 16;
            window-padding-balance = true;
            gtk-titlebar = false;
            window-decoration = true;
            window-width = 80;
            window-height = 22;

            command = "${config.programs.zellij.package}/bin/zellij";
          };
        };
      };
  };
}
