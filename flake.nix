{
  description = "Hanekokoro OS";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # NUR
    nur.url = "github:nix-community/NUR";
    # Emacs Overlay
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
    # Sops-Nix
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    # Impermanence
    impermanence.url = "github:nix-community/impermanence";
    # Blender (Binary)
    blender.url = "github:edolstra/nix-warez?dir=blender";
    blender.inputs.nixpkgs.follows = "nixpkgs";
    # Prebuilt Nix Index DB
    nix-indexdb.url = "github:nix-community/nix-index-database";
    nix-indexdb.inputs.nixpkgs.follows = "nixpkgs";
    # Users' flake
    ## NickCao
    nickcao.url = "github:NickCao/flakes";
    nickcao.inputs.nixpkgs.follows = "nixpkgs";
    ## Berberman
    berberman.url = "github:berberman/flakes";
    berberman.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, home-manager, nixpkgs, ... }: {
    # NixOS configurations.
    nixosConfigurations.hanekokoroos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nixos/configuration.nix
        # (modulesPath + "/installer/scan/not-detected.nix")
        nixpkgs.nixosModules.notDetected
        # Home Manager Module
        home-manager.nixosModules.home-manager
        # Impermanence
        inputs.impermanence.nixosModule
        # Sops-Nix
        inputs.sops-nix.nixosModules.sops
        # NUR
        inputs.nur.nixosModules.nur
        # Nix Index database
        inputs.nix-indexdb.nixosModules.nix-index
        {
          # Overlays
          nixpkgs.overlays = [
            # Emacs Overlay
            inputs.emacs-overlay.overlay
            # Blender (Binary)
            inputs.blender.overlays.default
            # Users' flake
            inputs.nickcao.overlays.default
            inputs.berberman.overlays.default
          ];
          # Configuration revision.
          system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
          # Pin NIX_PATH
          nix.settings.nix-path = [ "nixpkgs=${nixpkgs}" ];
          nix.registry = {
            p.flake = self;
            nixpkgs.flake = nixpkgs;
          };
        }
      ];
    };
  };
}
