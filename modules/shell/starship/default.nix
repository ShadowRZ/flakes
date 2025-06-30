{
  flake.modules.homeManager = {
    shell = {
      programs.starship = {
        enable = true;
        settings = builtins.fromTOML (builtins.readFile ./starship.toml);
      };
    };
  };
}
