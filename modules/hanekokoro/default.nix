{
  config,
  inputs,
  lib,
  withSystem,
  ...
}:
let
  inherit (lib) types mkOption;
  cfg = config.hanekokoro.nixos;
in
{
  options = {
    hanekokoro.nixos = mkOption {
      type = types.attrsOf (
        types.submodule {
          options = {
            system = mkOption {
              type = types.enum [
                "x86_64-linux"
                "aarch64-linux"
              ];
              example = "x86_64-linux";
              description = ''
                The system of the NixOS configuration.
              '';
            };
            useHomeManager = mkOption {
              type = types.bool;
              default = true;
              example = false;
              description = ''
                Whether to include Home Manager support for this NixOS configuration.

                Usually should be set to `true`, though setting to `false` can be useful
                if you're defining a server configuration.
              '';
            };
            modules = mkOption {
              type = types.listOf (
                types.enum (
                  lib.uniqueStrings (
                    builtins.filter (name: !lib.hasPrefix "hosts/" name) (
                      builtins.concatMap builtins.attrNames (builtins.attrValues config.flake.modules)
                    )
                  )
                )
              );
              example = [ "base" ];
              description = ''
                A list of module names to be included in this configuration.

                Modules should be defined using [`modules` of flake-parts](https://flake.parts/options/flake-parts-modules.html).

                Modules named `hosts/<name>` are automatically imported.
              '';
            };
          };
        }

      );
      description = ''
        Define a set of NixOS hosts.
      '';
    };
  };

  config = {
    flake.nixosConfigurations = builtins.mapAttrs (
      name: cfg:
      withSystem cfg.system (
        { pkgs, ... }:
        inputs.nixpkgs.lib.nixosSystem {
          modules = [
            # Import NixOS configurations
            {
              imports = builtins.map (name: config.flake.modules.nixos.${name} or { }) cfg.modules;
            }
            # Import Home Manager configurations
            (
              if cfg.useHomeManager then
                {
                  imports = [ inputs.home-manager.nixosModules.home-manager ];

                  ## Home Manager
                  home-manager = {
                    useUserPackages = true;
                    useGlobalPkgs = true;
                  };

                  home-manager.users.shadowrz = {
                    imports = builtins.map (name: config.flake.modules.homeManager.${name} or { }) cfg.modules;
                  };
                }
              else
                { }
            )
            (
              { lib, ... }:
              {
                # Import system local config
                imports = [
                  config.flake.modules.nixos."hosts/${name}"
                ];

                networking.hostName = lib.mkDefault name;

                nixpkgs.pkgs = pkgs;
              }
            )
          ];
        }
      )
    ) cfg;
  };
}
