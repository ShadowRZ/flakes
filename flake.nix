{
  description = "@ShadowRZ's flake.";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Neovim Nightly
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    # Flake utils
    flake-utils.url = "github:numtide/flake-utils";
    # Users' flake
    ## NickCao
    nickcao.url = "github:NickCao/flakes";
    nickcao.inputs.nixpkgs.follows = "nixpkgs";
    flake-compat.follows = "nickcao/flake-compat";
    naersk.follows = "nickcao/naersk";
    rust-overlay.follows = "nickcao/rust-overlay";
    ## Berberman
    berberman.url = "github:berberman/flakes";
    berberman.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, ... }: {
    # NixOS configurations.
    nixosConfigurations = import ./nixos {
      inherit inputs self;
      system = "x86_64-linux";
    };
  };
}
