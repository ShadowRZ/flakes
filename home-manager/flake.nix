{
  inputs = {
    hanekokoro-flake.url = "path:../.";
    nixpkgs.follows = "hanekokoro-flake/nixpkgs";

    # keep-sorted start block=yes
    catppuccin-nix = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # keep-sorted end
  };

  outputs = _: { };
}
