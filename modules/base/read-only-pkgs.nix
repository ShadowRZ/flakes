{ inputs, ... }:
{
  flake.modules.nixos = {
    base = {
      imports = [ inputs.nixpkgs.nixosModules.readOnlyPkgs ];

      # TODO: Investigate
      disabledModules = [ "hardware/facter/system.nix" ];
    };
  };
}
