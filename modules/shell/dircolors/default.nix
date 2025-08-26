{
  flake.modules.homeManager = {
    shell =
      _:
      {
        programs.dircolors = {
          enable = true;
          extraConfig = builtins.readFile ./dircolors.dircolors;
        };
      };
  };
}
