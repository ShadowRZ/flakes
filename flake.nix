{
  description = "@ShadowRZ's flake.";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # NUR
    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";
    # Emacs Overlay
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
    # Wayland tools
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";
    # Flake utils
    flake-utils.url = "github:numtide/flake-utils";
    # Fenix
    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";
    # Users' flake
    ## NickCao
    nickcao.url = "github:NickCao/flakes";
    nickcao.inputs.nixpkgs.follows = "nixpkgs";
    ## Berberman
    berberman.url = "github:berberman/flakes";
    berberman.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, home-manager, nixpkgs, flake-utils, ... }:
    {
      # Package metadatas.
      # Only x86_64-linux is considered.
      pkgs-metas = builtins.mapAttrs (key: value: {
        version = (value.version or null);
        meta = (value.meta or null);
      }) self.packages.x86_64-linux;
      # NixOS configurations.
      nixosConfigurations.hermitmedjed-s = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
          # Home Manager Module
          home-manager.nixosModules.home-manager
          # (modulesPath + "/installer/scan/not-detected.nix")
          nixpkgs.nixosModules.notDetected
          {
            # Overlays
            nixpkgs.overlays = [
              # NUR
              inputs.nur.overlay
              # Wayland tools
              inputs.nixpkgs-wayland.overlay
              # Emacs Overlay
              inputs.emacs-overlay.overlay
              # Fenix
              inputs.fenix.overlay
              # Users' flake
              inputs.nickcao.overlays.default
              inputs.berberman.overlay
              # My overlay
              self.overlay
              (import ./override/package-overlay.nix)
              # Rust Nightly Packages
              (final: prev:
                import ./pkgs/rust-nightly-packages {
                  pkgs = prev;
                  fenix = inputs.fenix.packages.${system};
                })
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
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ inputs.nur.overlay ];
        };
      in {
        # Update my Firefox addons.
        apps.update-firefox-addons = with pkgs;
          let
            update-firefox-addons =
              writeShellScriptBin "update-firefox-addons" ''
                ${nur.repos.rycee.mozilla-addons-to-nix}/bin/mozilla-addons-to-nix \
                  nixos/futaba/profiles/firefox/extra-addons.json \
                  nixos/futaba/profiles/firefox/extra-addons.nix
              '';
          in flake-utils.lib.mkApp { drv = update-firefox-addons; };
      }) // (import ./pkgs/flake-output.nix {
        inherit flake-utils nixpkgs;
        fenix = inputs.fenix;
      });
}
