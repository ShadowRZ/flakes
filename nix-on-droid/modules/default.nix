{
  config,
  inputs,
  withSystem,
  ...
}:
{
  imports = [ inputs.flake-parts.flakeModules.modules ];

  perSystem =
    { system, ... }:
    {
      # Instance a global Nixpkgs
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          inputs.shadowrz.overlays.default
        ];
        config = {
          allowUnfree = true;
        };
      };
    };

  flake.nixOnDroidConfigurations.default = withSystem "aarch64-linux" (
    { pkgs, ... }:
    inputs.nix-on-droid.lib.nixOnDroidConfiguration {
      inherit pkgs;
      modules =
        let
          modules = [
            "base"
            "nix"
            "dev"
            "shell"
          ];
        in
        [
          # Import NixOS configurations
          {
            imports = map (name: config.flake.modules.nixOnDroid.${name} or { }) modules;
          }
          # Import Home Manager configurations
          {
            home-manager.config = {
              imports = map (
                name:
                config.partitions.home-manager.module.flake.modules.homeManager.${name}
                  or config.flake.modules.homeManager.${name} or { }
              ) modules;
            };
          }
        ];
    }
  );
  # base nix dev shell
}
