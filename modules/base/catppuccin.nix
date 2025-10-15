{ inputs, ... }:
{
  flake.modules.homeManager.base = {
    imports = [
      inputs.catppuccin-nix.homeModules.catppuccin
    ];

    catppuccin = {
      fish = {
        enable = true;
        flavor = "mocha";
      };
      ghostty = {
        enable = true;
        flavor = "mocha";
      };
    };
  };
}
