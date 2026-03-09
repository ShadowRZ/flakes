{
  inputs = {
    hanekokoro-flake.url = "path:../.";
    nixpkgs.follows = "hanekokoro-flake/nixpkgs";
    flake-parts.follows = "hanekokoro-flake/flake-parts";

    # keep-sorted start block=yes
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

  outputs = _: { };
}
