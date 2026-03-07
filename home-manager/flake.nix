{
  description = "Hanekokoro Flake @ Home Manager";

  inputs = {
    # Nixpkgs
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    # keep-sorted start block=yes
    catppuccin-nix = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    systems = {
      url = "github:nix-systems/default";
    };
    # keep-sorted end
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports =
        let
          inherit (inputs.nixpkgs) lib;
        in
        lib.fileset.toList (lib.fileset.fileFilter (f: f.hasExt "nix") ./modules);
      systems = import inputs.systems;
    };
}
