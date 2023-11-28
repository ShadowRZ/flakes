{
  description = "Hanekokoro OS";

  inputs = {
    # Nixpkgs
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    # Flake Parts
    flake-parts = { url = "github:hercules-ci/flake-parts"; };
    # Ez Configs
    ez-configs = {
      url = "github:ehllie/ez-configs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NUR
    nur = { url = "github:nix-community/NUR"; };
    # Sops-Nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Impermanence
    impermanence = { url = "github:nix-community/impermanence"; };
    # Emacs Overlay
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    # Users' flake
    berberman = {
      url = "github:berberman/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, ez-configs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ez-configs.flakeModule ];

      systems =
        [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];

      perSystem = { pkgs, ... }: {
        devShells.default = with pkgs;
          mkShell { nativeBuildInputs = [ nixfmt nil ]; };
      };

      ezConfigs = {
        root = ./.;
        globalArgs = { inherit inputs; };
        nixos.hosts.hanekokoroos.userHomeModules = [ "shadowrz" "root" ];
      };
    };

#  outputs = inputs@{ flake-parts, ... }:
#    flake-parts.lib.mkFlake { inherit inputs; } {
#      flake = {
#        # NixOS configurations.
#        nixosConfigurations.hanekokoroos = inputs.nixpkgs.lib.nixosSystem {
#          system = "x86_64-linux";
#          modules = [
#            ./nixos/configuration.nix
#            inputs.nixpkgs.nixosModules.notDetected
#            inputs.home-manager.nixosModules.home-manager
#            inputs.impermanence.nixosModule
#            inputs.sops-nix.nixosModules.sops
#            inputs.nur.nixosModules.nur
#            inputs.nix-indexdb.nixosModules.nix-index
#            ({ config, ... }: {
#              # Overlays
#              nixpkgs.overlays = [
#                inputs.blender.overlays.default
#                inputs.berberman.overlays.default
#                inputs.emacs-overlay.overlays.default
#              ];
#              # Configuration revision.
#              system.configurationRevision =
#                inputs.nixpkgs.lib.mkIf (inputs.self ? rev) inputs.self.rev;
#              # Pin NIX_PATH
#              nix.settings.nix-path = [ "nixpkgs=${inputs.nixpkgs}" ];
#              nix.registry = {
#                p.flake = inputs.self;
#                nixpkgs.flake = inputs.nixpkgs;
#              };
#              # Home Manager
#              home-manager = {
#                useUserPackages = true;
#                useGlobalPkgs = true;
#                sharedModules = [ ./dotfiles/home-configuration.nix ];
#                extraSpecialArgs = { inherit (config) nur; };
#                users = {
#                  shadowrz = {
#                    imports = [
#                      ./dotfiles/shadowrz/home-configuration.nix
#                      ./nixos/shadowrz/home-configuration.nix
#                    ];
#                  };
#                  # Enable root modules
#                  root = { };
#                };
#              };
#            })
#          ];
#        };
#      };
#    };
}

