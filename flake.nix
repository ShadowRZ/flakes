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
    devshell = { url = "github:numtide/devshell"; };
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
      imports = [ ez-configs.flakeModule inputs.devshell.flakeModule ];

      systems =
        [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];

      perSystem = { pkgs, ... }: {
        devshells.default = { packages = with pkgs; [ nixfmt nil ]; };
      };

      ezConfigs = {
        root = ./.;
        globalArgs = { inherit inputs; };
        nixos.hosts.hanekokoroos.userHomeModules = [ "shadowrz" "root" ];
      };

      flake = {
        nixOnDroidConfigurations.default =
          import ./nix-on-droid { inherit inputs; };
      };
    };
}
