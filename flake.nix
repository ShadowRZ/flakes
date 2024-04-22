{
  description = "Codename Hanekokoro";

  inputs = {
    # Nixpkgs
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Home Manager
    disko = {
      url = "github:nix-community/disko";
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
      };
    };
    # NixOS WSL
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
    # Users' flake
    berberman = {
      url = "github:berberman/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {

    nixosConfigurations = {
      unknown-dimensions = import ./nixos-wsl { inherit inputs; };
      mika-honey = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # Modules
          ./nixos/modules
          ./nixos/modules/boot-systemd.nix
          ./nixos/modules/graphical
          ./nixos/modules/networking
          ./nixos/modules/networking/networkmanager.nix
          ./nixos/modules/user-profiles.nix
          ./nixos/modules/vmos-guest.nix
          ./nixos/profiles/plasma-desktop.nix
          # Disko config
          inputs.disko.nixosModules.disko
          ./nixos/disko/btrfs-subvolume.nix
          # System profile
          ./nixos/profiles/system/mika-honey.nix
          {
            home-manager = {
              sharedModules = [ ./home ];
              users = {
                shadowrz.imports =
                  [ ./home/env-extras.nix ./home/graphical.nix ./home/firefox ];
                root = { };
              };
            };
          }
        ];
      };
    };

    nixOnDroidConfigurations.default =
      import ./nix-on-droid { inherit inputs; };
  };
}
