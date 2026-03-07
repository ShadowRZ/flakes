{
  description = "Hanekokoro Flake";

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
        ...
      }:
      {
        debug = true;

        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];

        imports = [ inputs.flake-parts.flakeModules.partitions ];

        partitions = {
          nixos = {
            extraInputsFlake = ./nixos;
            module = import ./nixos;
          };
          home-manager = {
            extraInputsFlake = ./home-manager;
            module = import ./home-manager;
          };
          nix-on-droid = {
            extraInputsFlake = ./nix-on-droid;
            module = import ./nix-on-droid;
          };
          dev = {
            extraInputsFlake = ./dev;
            module = import ./dev;
          };
        };

        partitionedAttrs = {
          nixosConfigurations = "nixos";
          nixOnDroidConfigurations = "nix-on-droid";
          devShells = "dev";
        };
      }
    );
}
