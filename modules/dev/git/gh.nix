{
  flake.modules.homeManager = {
    dev =
      { pkgs, ... }:
      {
        programs = {
          ### Gh
          gh = {
            enable = true;
            settings = {
              git_protocol = "ssh";
              version = "1";
            };
          };
        };
      };
  };
}
