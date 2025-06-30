{
  flake.modules.homeManager = {
    shell = {
      programs.dircolors = {
        enable = true;
        extraConfig = builtins.readFile ./dircolors.dircolors;
      };
    };
  };
}
