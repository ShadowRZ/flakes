{
  flake.modules = {
    nixos = {
      base = _: {
        programs.command-not-found.enable = false;
      };
    };

    homeManager = {
      base = _: {
        programs.command-not-found.enable = false;
      };
    };
  };
}
