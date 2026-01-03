{
  flake.modules.homeManager = {
    dev-desktop =
      _:
      {
        programs.neovide = {
          enable = true;
          settings = {
            frame = "none";
            font = {
              normal = [
                "Hanekokoro Mono"
                "Sarasa Mono SC"
              ];
              size = 22.0;
            };
          };
        };
      };
  };
}
