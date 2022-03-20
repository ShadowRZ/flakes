{
  description = "@ShadowRZ's flake.";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Neovim Nightly
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    # Wayland tools
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    # Flake utils
    flake-utils.url = "github:numtide/flake-utils";
    # NVFetcher
    nvfetcher.url = "github:berberman/nvfetcher";
    nvfetcher.inputs.nixpkgs.follows = "nixpkgs";
    # Users' flake
    ## NickCao
    nickcao.url = "github:NickCao/flakes";
    nickcao.inputs.nixpkgs.follows = "nixpkgs";
    flake-compat.follows = "nickcao/flake-compat";
    rust-overlay.follows = "nickcao/rust-overlay";
    ## Berberman
    berberman.url = "github:berberman/flakes";
    berberman.inputs.nixpkgs.follows = "nixpkgs";
    berberman.inputs.nvfetcher.follows = "nvfetcher";
  };

  outputs = inputs@{ self, home-manager, nixpkgs, flake-utils, ... }:
    {
      overlay = final: prev: (import ./pkgs prev);
      # NixOS configurations.
      nixosConfigurations.hermitmedjed-s = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
          # Wayland WMs
          ./modules/programs/wayfire.nix
          ./modules/programs/hikari.nix
          # Home Manager Module
          home-manager.nixosModules.home-manager
          # (modulesPath + "/installer/scan/not-detected.nix")
          nixpkgs.nixosModules.notDetected
          {
            # Overlays
            nixpkgs.overlays = [
              # Neovim Nightly
              inputs.neovim-nightly.overlay
              # Wayland tools
              # Users' flake
              inputs.nickcao.overlays.default
              inputs.berberman.overlay
              self.overlay
              (final: prev: {
                # Fix SmartDNS
                smartdns = prev.smartdns.overrideAttrs
                  (attrs: { postPatch = "rm systemd/smartdns.service"; });
              })
              inputs.nixpkgs-wayland.overlay
            ];
            # Configuration revision.
            system.configurationRevision =
              nixpkgs.lib.mkIf (self ? rev) self.rev;
            # Home Manager.
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
            };
            # Pin NIX_PATH
            nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
            nix.registry.p.flake = self;
            nix.registry.nixpkgs.flake = nixpkgs;
          }
        ];
      };
    } // flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in { packages = (import ./pkgs pkgs); });
}
