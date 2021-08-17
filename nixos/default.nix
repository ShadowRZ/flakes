{ inputs, self, system }:
let
  # Nixpkgs
  nixpkgs = inputs.nixpkgs;
  # Home Manager
  home-manager = inputs.home-manager;
in {
  futaba-g480 = nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      # Entry point
      ./hosts/futaba-g480.nix
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
}
