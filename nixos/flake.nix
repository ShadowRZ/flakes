{
  description = "Hanekokoro Flake @ NixOS";

  inputs = {
    # Nixpkgs
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable-small";
    };
    # NixOS Sensible
    nixos-sensible = {
      url = "github:Guanran928/nixos-sensible";
    };
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Disko
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Sops-Nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Preservation
    preservation = {
      url = "github:nix-community/preservation";
    };
    # Prebuilt Nix Index DB
    nix-indexdb = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Catppuccin Nix
    catppuccin-nix = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Lanzaboote
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        crane.follows = "crane";
        # https://github.com/nix-community/lanzaboote/blob/v0.4.1/flake.nix#L11
        pre-commit.follows = "";
        rust-overlay.follows = "rust-overlay";
      };
    };
    # Firefox Addons Nix
    firefox-addons-nix = {
      url = "github:petrkozorezov/firefox-addons-nix";
      inputs = {
        # Unused
        flake-utils.follows = "";
        nixpkgs.follows = "nixpkgs";
      };
    };
    # Neovim Overlay
    neovim-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
    # Emacs Overlay
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = ""; # Only used for Nix Community Hydra jobs
      };
    };
    ### Personal packages
    shadowrz = {
      url = "github:ShadowRZ/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ### Dedupes
    crane = {
      url = "github:ipetkov/crane";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs = _: { };
}
