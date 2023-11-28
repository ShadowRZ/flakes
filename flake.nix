{
  description = "Project Hanekokoro";

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
    # Nix On Droid
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
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

      flake = {
        nixOnDroidConfigurations.default =
          inputs.nix-on-droid.lib.nixOnDroidConfiguration {
            modules = [
              ./nix-on-droid/nix-on-droid.nix
              {
                nix = {
                  nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
                  registry = { nixpkgs.flake = inputs.nixpkgs; };
                };
                home-manager = {
                  useGlobalPkgs = true;
                  config.imports = with inputs; [
                    self.homeModules.default
                    self.homeModules.shadowrz
                    nix-indexdb.hmModules.nix-index
                    { programs.nix-index-database.comma.enable = true; }
                  ];
                };
              }
            ];
          };
      };
    };
}
