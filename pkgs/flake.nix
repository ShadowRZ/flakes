{
  description = "@ShadowRZ's flake packages.";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Flake utils
    flake-utils.url = "github:numtide/flake-utils";
    # Fenix (Required for taskmaid)
    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, flake-utils, nixpkgs, ... }:
    import ./flake-output.nix {
      inherit flake-utils nixpkgs;
      fenix = inputs.fenix;
    };
}
