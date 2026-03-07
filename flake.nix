{
  description = "Hanekokoro Infra";

  inputs = {
    # Nixpkgs
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable-small";
    };
    # Flake Parts
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      {
        inputs,
        lib,
        ...
      }:
      let
        # A simplified version of import-tree using only nixpkgs.lib
        import-tree = path: {
          imports = lib.fileset.toList (lib.fileset.fileFilter (f: f.hasExt "nix") path);
        };
      in
      {
        debug = true;

        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];

        imports = [ inputs.flake-parts.flakeModules.partitions ];

        partitions = {
          home-manager = {
            extraInputsFlake = ./home-manager;
            module = {
              imports = [
                (import-tree ./home-manager/modules)
              ];
            };
          };
          nixos = {
            extraInputsFlake = ./nixos;
            module = {
              imports = [
                (import-tree ./nixos/modules)
              ];
            };
          };
          dev = {
            extraInputsFlake = ./dev;
            module =
              { inputs, ... }:
              {
                imports = [
                  inputs.treefmt-nix.flakeModule
                ];

                perSystem =
                  { config, pkgs, ... }:
                  {
                    treefmt.config = {
                      projectRootFile = "flake.nix";

                      ### nix
                      programs.deadnix.enable = true;
                      programs.statix.enable = true;
                      programs.nixfmt.enable = true;
                    };

                    devShells.default = pkgs.mkShellNoCC {
                      packages = [
                        config.treefmt.build.wrapper
                        # keep-sorted start
                        pkgs.deadnix
                        pkgs.just
                        pkgs.keep-sorted
                        pkgs.nixd
                        pkgs.nixfmt
                        pkgs.statix
                        # keep-sorted end
                      ];
                    };
                  };
              };
          };
        };

        partitionedAttrs = {
          nixosConfigurations = "nixos";
          devShells = "dev";
        };
      }
    );
}
