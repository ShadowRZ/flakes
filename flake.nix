{
  description = "@ShadowRZ's flake.";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Neovim Nightly
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    # Flake utils
    flake-utils.url = "github:numtide/flake-utils";
    # Users' flake
    ## NickCao
    nickcao.url = "github:NickCao/flakes";
    nickcao.inputs.nixpkgs.follows = "nixpkgs";
    flake-compat.follows = "nickcao/flake-compat";
    naersk.follows = "nickcao/naersk";
    rust-overlay.follows = "nickcao/rust-overlay";
    ## Berberman
    berberman.url = "github:berberman/flakes";
    berberman.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{
    self,
    home-manager,
    nixpkgs,
    ...
  }: {
    # NixOS configurations.
    nixosConfigurations.futaba-necronomicon = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nixos/necronomicon
        # Home Manager Module
        home-manager.nixosModules.home-manager
        # (modulesPath + "/installer/scan/not-detected.nix")
        nixpkgs.nixosModules.notDetected
        {
          # Overlays
          nixpkgs.overlays = [
            # Neovim Nightly
            inputs.neovim-nightly.overlay
            # Users' flake
            inputs.nickcao.overlay
            inputs.berberman.overlay
            # Fix SmartDNS
            (final: prev: {
              smartdns = prev.smartdns.overrideAttrs (attrs: {
                postPatch = "rm systemd/smartdns.service";
              });
            })
          ];
          # Configuration revision.
          system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
          # Home Manager.
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
          };
          # Consistant nixpkgs version.
          nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
          nix.registry.p.flake = self;
        }
      ];
    };
  };
}
