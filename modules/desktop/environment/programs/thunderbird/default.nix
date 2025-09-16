{
  flake.modules.homeManager = {
    desktop =
      {
        pkgs,
        ...
      }:
      {
        programs.thunderbird = {
          enable = true;
          package = pkgs.thunderbird-latest;
          profiles = {
            default = {
              isDefault = true;
            };
          };
        };
      };
  };
}
