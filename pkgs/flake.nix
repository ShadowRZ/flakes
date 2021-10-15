{
  description = "@ShadowRZ's flake packages.";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, ... }: {
    # Overlay
    overlay = import ./.;
  };
}
