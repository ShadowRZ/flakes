{ inputs, ... }:
{
  flake.modules.nixos = {
    base = {
      imports = [ inputs.nixpkgs.nixosModules.readOnlyPkgs ];
    };
  };
}
