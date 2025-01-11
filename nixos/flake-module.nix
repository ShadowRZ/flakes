{ inputs, ... }:
{
  flake.nixosModules =
    {
      default = import ./foundation-configuration.nix;
      with-flake-revision = { lib, ... }:
        {
          # Stores system revision.
          system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;
        };
      flake-registry = { lib, ... }:
        {
          nix.registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
        };
    }
    // inputs.self.lib.modulesFromDirectory ./modules
    // inputs.self.lib.modulesFromFiles ./templates;
}
