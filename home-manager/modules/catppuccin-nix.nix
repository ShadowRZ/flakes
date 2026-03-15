{ inputs, ... }:
{
  flake.modules.homeManager.base = {
    imports = [
      inputs.catppuccin-nix.homeModules.catppuccin
    ];

    catppuccin = {
      accent = "rosewater";
      flavor = "mocha";

      fish = {
        enable = true;
      };
      gh-dash = {
        enable = true;
      };
      mpv = {
        enable = true;
      };
      delta = {
        enable = true;
      };
      obs = {
        enable = true;
        flavor = "latte";
      };
      starship = {
        enable = true;
      };
    };
  };
}
