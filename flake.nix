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
    # Impermanence
    impermanence.url = "github:nix-community/impermanence";
    impermanence.inputs.nixpkgs.follows = "nixpkgs";
    # Sops-Nix
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    # Users' flake
    ## NickCao
    nickcao.url = "github:NickCao/flakes";
    nickcao.inputs.nixpkgs.follows = "nixpkgs";
    ## Berberman
    berberman.url = "github:berberman/flakes";
    berberman.inputs.nixpkgs.follows = "nixpkgs";
    ## My flake
    shadowrz.url = "github:ShadowRZ/nur-packages";
    shadowrz.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, shadowrz, home-manager, nixpkgs, ... }: {
    # NixOS configurations.
    nixosConfigurations.hermitmedjed-s = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs.configurationPath = builtins.toString self;
      specialArgs.nixpkgsPath = builtins.toString nixpkgs;
      modules = [
        ./nixos/configuration.nix
        # Home Manager Module
        home-manager.nixosModules.home-manager
        # (modulesPath + "/installer/scan/not-detected.nix")
        nixpkgs.nixosModules.notDetected
        # Impermanence
        inputs.impermanence.nixosModule
        # Sops-Nix
        inputs.sops-nix.nixosModules.sops
        {
          # Overlays
          nixpkgs.overlays = [
            # NUR
            inputs.nur.overlay
            # Emacs Overlay
            inputs.emacs-overlay.overlay
            # Users' flake
            inputs.nickcao.overlays.default
            inputs.berberman.overlay
            # My overlay
            (import "${shadowrz}/overlay.nix")
            (import ./override/package-overlay.nix)
          ];
          # Configuration revision.
          system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
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
  };
}
