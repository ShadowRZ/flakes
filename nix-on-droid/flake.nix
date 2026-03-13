{
  inputs = {
    # keep-sorted start block=yes
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "";
    };
    nix-indexdb = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "";
    };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs = {
        nixpkgs.follows = "";
        home-manager.follows = "home-manager";
        nixpkgs-docs.follows = "";
        nix-formatter-pack.follows = "";
        nmd.follows = "";
        nixpkgs-for-bootstrap.follows = "";
      };
    };
    shadowrz = {
      url = "github:ShadowRZ/nur-packages";
      inputs.nixpkgs.follows = "";
    };
    # keep-sorted end
  };

  outputs = _: { };
}
