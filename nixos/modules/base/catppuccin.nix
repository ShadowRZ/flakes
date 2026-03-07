{ inputs, ... }:
{
  flake.modules.homeManager.base = {
    imports = [
      inputs.catppuccin-nix.homeModules.catppuccin
    ];

    catppuccin = {
      ghostty = {
        enable = true;
        flavor = "mocha";
      };
    };
  };
}
