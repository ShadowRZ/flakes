{
  description = "Codename Hanekokoro";

  inputs = {
    # Nixpkgs
    nixpkgs = {url = "github:NixOS/nixpkgs/nixos-unstable";};
    nixpkgs-stable = {url = "github:NixOS/nixpkgs/nixos-24.05";};
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
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
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
        nixpkgs-docs.follows = "nixpkgs";
        nix-formatter-pack.follows = "nix-formatter-pack";
        nmd.follows = "nmd";
        # Unsupported?
        nixpkgs-for-bootstrap.follows = "nixpkgs";
      };
    };
    # Lanzaboote
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        flake-utils.follows = "flake-utils";
        crane.follows = "crane";
        flake-compat.follows = "flake-compat";
        pre-commit-hooks-nix.follows = "pre-commit-hooks-nix";
        rust-overlay.follows = "rust-overlay";
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
      inputs.nvfetcher.follows = "nvfetcher";
    };
    ### Dedupes
    systems = {url = "github:nix-systems/default";};
    crane = {
      url = "github:ipetkov/crane";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
    };
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-formatter-pack = {
      url = "github:Gerschtli/nix-formatter-pack";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nmd.follows = "nmd";
      inputs.nmt.follows = "nmt";
    };
    nmd = {
      url = "sourcehut:~rycee/nmd";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.scss-reset.follows = "scss-reset";
    };
    nmt = {
      url = "sourcehut:~rycee/nmt";
      flake = false;
    };
    nvfetcher = {
      url = "github:berberman/nvfetcher";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-utils.follows = "flake-utils";
    };
    pre-commit-hooks-nix = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
      inputs.flake-compat.follows = "flake-compat";
      inputs.gitignore.follows = "gitignore";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    scss-reset = {
      url = "github:andreymatin/scss-reset";
      flake = false;
    };
  };

  outputs = inputs @ {flake-parts, ...}:
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
