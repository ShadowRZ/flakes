{
  description = "Codename Hanekokoro";

  inputs = {
    # Nixpkgs
    nixpkgs = {url = "github:NixOS/nixpkgs/nixos-unstable";};
    # NixOS Sensible
    nixos-sensible = {url = "github:Guanran928/nixos-sensible";};
    # Flake Utils
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    # Flake Parts
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Disko
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NUR
    nur = {url = "github:nix-community/NUR";};
    # Sops-Nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Impermanence
    impermanence = {url = "github:nix-community/impermanence";};
    # Blender (Binary)
    blender = {
      url = "github:edolstra/nix-warez?dir=blender";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Prebuilt Nix Index DB
    nix-indexdb = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Nix On Droid
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    # Lanzaboote
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs = {
        flake-parts.follows = "flake-parts";
        flake-utils.follows = "flake-utils";
      };
    };
    # Treefmt
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Users' flake
    berberman = {
      url = "github:berberman/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ### Dedupes
    systems = {url = "github:nix-systems/default";};
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [inputs.treefmt-nix.flakeModule];
      systems = inputs.flake-utils.lib.defaultSystems;
      perSystem = {pkgs, ...}: {
        packages = import ./pkgs {inherit pkgs;};
        treefmt.config = import ./treefmt.nix;
      };
      flake = {
        nixosConfigurations = {
          mononekomi = inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {inherit inputs;};
            modules = [./hosts/mononekomi];
          };
        };
        overlays = {
          default = import ./overlays;
          packages = import ./pkgs/overlay.nix;
        };
        nixOnDroidConfigurations = {
          akasha = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
            extraSpecialArgs = {inherit inputs;};
            modules = [./hosts/akasha];
            pkgs = import inputs.nixpkgs {
              system = "aarch64-linux";
              overlays = [
                inputs.nur.overlay
              ];
            };
          };
        };
      };
    };
}
