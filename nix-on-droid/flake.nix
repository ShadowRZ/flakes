{
  inputs = {
    hanekokoro-flake.url = "path:../.";
    nixpkgs.follows = "hanekokoro-flake/nixpkgs";

    # keep-sorted start block=yes
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-indexdb = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        nixpkgs-docs.follows = "";
        nix-formatter-pack.follows = "";
        nmd.follows = "";
        nixpkgs-for-bootstrap.follows = "";
      };
    };
    shadowrz = {
      url = "github:ShadowRZ/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # keep-sorted end
  };

  outputs = _: { };
}
