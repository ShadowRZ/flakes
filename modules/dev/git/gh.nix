{
  flake.modules.homeManager = {
    dev =
      _:
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
