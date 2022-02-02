{
  description = "@ShadowRZ's flake packages.";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Flake utils
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in { packages = (import ./packages.nix pkgs); }) // {
        # Overlay
        overlay = final: prev: (import ./packages.nix prev);
      };
}
