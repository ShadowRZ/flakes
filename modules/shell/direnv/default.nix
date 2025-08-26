{
  flake.modules.homeManager = {
    shell =
      _:
      {
        programs.direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
      };
  };
}
