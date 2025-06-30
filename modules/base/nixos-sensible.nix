{ inputs, ... }:
{
  flake.modules.nixos = {
    base = {
      imports = [
        inputs.nixos-sensible.nixosModules.default
        inputs.nixos-sensible.nixosModules.zram
      ];
    };
  };
}
