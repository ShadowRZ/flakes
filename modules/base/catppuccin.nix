{ inputs, ... }:
{
  flake.modules.homeManager.base = {
    imports = [
      inputs.catppuccin-nix.homeModules.catppuccin
    ];

    catppuccin = {
      fish = {
        enable = true;
        flavor = "latte";
      };
      ghostty = {
        enable = true;
        flavor = "latte";
      };
    };
  };
}
