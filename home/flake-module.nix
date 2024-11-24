{ inputs, ... }:
{
  flake.hmModules = {
    default = import ./foundation-configuration.nix;
  } // inputs.self.lib.modulesFromDirectory ./modules;
}
