{
  inputs = {
    hanekokoro-flake.url = "path:../.";
    nixpkgs.follows = "hanekokoro-flake/nixpkgs";
    flake-parts.follows = "hanekokoro-flake/flake-parts";

    # keep-sorted start block=yes
    catppuccin-nix = {
      url = "github:catppuccin/nix";
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
