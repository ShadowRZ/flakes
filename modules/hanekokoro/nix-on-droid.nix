{
  config,
  inputs,
  lib,
  withSystem,
  ...
}:
let
  inherit (lib) types mkOption;
  cfg = config.hanekokoro.nix-on-droid;
in
{
  options = {
    hanekokoro.nix-on-droid = mkOption {
      type = types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            default = "default";
            example = "akasha";
            description = ''
              The exported attribute name of Nix On Droid.
            '';
          };
          system = mkOption {
            type = types.enum [
              "x86_64-linux"
              "aarch64-linux"
            ];
            example = "aarch64-linux";
            description = ''
              The system of Nix On Droid.
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
              A list of module names to be included in Nix On Droid.

              Modules should be defined using [`modules` of flake-parts](https://flake.parts/options/flake-parts-modules.html).
            '';
          };
        };
      };
      description = ''
        Define a set of NixOS hosts.
      '';
    };
  };

  config = {
    flake.nixOnDroidConfigurations.${cfg.name} = withSystem cfg.system (
      { pkgs, ... }:
      inputs.nix-on-droid.lib.nixOnDroidConfiguration {
        inherit pkgs;
        modules = [
          # Import NixOS configurations
          {
            imports = builtins.map (name: config.flake.modules.nixOnDroid.${name} or { }) cfg.modules;
          }
          # Import Home Manager configurations
          {
            home-manager.config = {
              imports = builtins.map (name: config.flake.modules.homeManager.${name} or { }) cfg.modules;
            };
          }
        ];
      }
    );
  };
}
