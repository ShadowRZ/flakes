{
  description = "@ShadowRZ's flake packages.";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Flake utils
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, ... }: {
    # Overlay
    overlay = import ./.;
  };
}
