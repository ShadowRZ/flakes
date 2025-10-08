{
  flake.modules.homeManager = {
    desktop =
      _:
      {
        programs.ghostty = {
          enable = true;
          settings = {
            font-family = "Hanekokoro Mono Light";
            font-size = 16;
            window-padding-balance = true;
            gtk-titlebar = false;
            window-decoration = true;

            window-width = 80;
            window-height = 22;
          };
        };
      };
  };
}
