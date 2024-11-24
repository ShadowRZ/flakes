{ inputs, ... }:
{
  flake.nixosModules = {
    default = import ./foundation-configuration.nix;
  } // inputs.self.lib.modulesFromDirectory ./modules // inputs.self.lib.modulesFromFiles ./templates;
}
