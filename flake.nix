{
  description = "Hanekokoro OS";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Flake utils
    flake-utils.url = "github:numtide/flake-utils";
    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # NUR
    nur.url = "github:nix-community/NUR";
    # Sops-Nix
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    # Impermanence
    impermanence.url = "github:nix-community/impermanence";
    # Emacs Overlay
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
    # Blender (Binary)
    blender.url = "github:edolstra/nix-warez?dir=blender";
    blender.inputs.nixpkgs.follows = "nixpkgs";
    # Prebuilt Nix Index DB
    nix-indexdb.url = "github:nix-community/nix-index-database";
    nix-indexdb.inputs.nixpkgs.follows = "nixpkgs";
    # Users' flake
    ## Berberman
    berberman.url = "github:berberman/flakes";
    berberman.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, ... }:
    {
      # NixOS configurations.
      nixosConfigurations.hanekokoroos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
          # (modulesPath + "/installer/scan/not-detected.nix")
          nixpkgs.nixosModules.notDetected
          # Home Manager Module
          inputs.home-manager.nixosModules.home-manager
          # Impermanence
          inputs.impermanence.nixosModule
          # Sops-Nix
          inputs.sops-nix.nixosModules.sops
          # NUR
          inputs.nur.nixosModules.nur
          # Nix Index database
          inputs.nix-indexdb.nixosModules.nix-index
          ({ config, ... }: {
            # Overlays
            nixpkgs.overlays = [
              # Blender (Binary)
              inputs.blender.overlays.default
              # Users' flake
              inputs.berberman.overlays.default
              # Emacs Overlay
              inputs.emacs-overlay.overlays.default
            ];
            # Configuration revision.
            system.configurationRevision =
              nixpkgs.lib.mkIf (self ? rev) self.rev;
            # Pin NIX_PATH
            nix.settings.nix-path = [ "nixpkgs=${nixpkgs}" ];
            nix.registry = {
              p.flake = self;
              nixpkgs.flake = nixpkgs;
            };
            # Home Manager
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              sharedModules = [ ./dotfiles/home-configuration.nix ];
              extraSpecialArgs = { inherit (config) nur; };
              users = {
                shadowrz = {
                  imports = [
                    ./dotfiles/shadowrz/home-configuration.nix
                    ./nixos/shadowrz/home-configuration.nix
                  ];
                };
                # Enable root modules
                root = { };
              };
            };
          })
        ];
      };
    } // flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = with pkgs;
          mkShell { nativeBuildInputs = [ nixfmt nil ]; };
      });
}
