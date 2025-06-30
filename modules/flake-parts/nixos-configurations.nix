{
  inputs,
  lib,
  config,
  withSystem,
  ...
}:
{
  flake.nixosConfigurations =
    lib.pipe
      (lib.filterAttrs (
        name: _: lib.hasPrefix config.flake.meta.prefix.hosts name
      ) config.flake.modules.nixos)
      [
        (lib.mapAttrs' (
          name: value: {
            name = lib.removePrefix config.flake.meta.prefix.hosts name;
            inherit value;
          }
        ))
        (lib.mapAttrs' (
          name: module: {
            inherit name;
            value = withSystem config.flake.meta.system.nixos.${name} (
              { pkgs, ... }:
              inputs.nixpkgs.lib.nixosSystem {
                modules = [
                  module

                  {
                    networking.hostName = name;

                    nixpkgs = {
                      inherit pkgs;
                    };
                  }
                ];
              }
            );
          }
        ))
      ];
}
