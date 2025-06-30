{
  flake.modules.homeManager = {
    dev = {
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
