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
      # Users
      ./saekmi/users
      # Home Manager Module
      home-manager.nixosModules.home-manager
      # (modulesPath + "/installer/scan/not-detected.nix")
      nixpkgs.nixosModules.notDetected
      {
        # Overlays
        nixpkgs.overlays = [
          # Emacs Overlay
          inputs.emacs-overlay.overlay
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
      }
    ];
  };
}
