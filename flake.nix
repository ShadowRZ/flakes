{
  description = "Hanekokoro Infra";

  inputs = {
    # Nixpkgs
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable-small";
    };
    # NixOS Sensible
    nixos-sensible = {
      url = "github:Guanran928/nixos-sensible";
    };
    # Flake Parts
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    # Import Tree
    import-tree = {
      url = "github:vic/import-tree";
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
    # Nix On Droid
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
    # Treefmt
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
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
    # Catppuccin Nix
    catppuccin-nix = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Nixvim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    ### Personal packages
    shadowrz = {
      url = "github:ShadowRZ/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ### Non flake
    silent-sddm = {
      url = "github:uiriansan/SilentSDDM";
      flake = false;
    };
    ### Dedupes
    crane = {
      url = "github:ipetkov/crane";
    };
    systems = {
      url = "github:nix-systems/default";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
