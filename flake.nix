{
  description = "Hanekokoro Flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable-small";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    # keep-sorted start block=yes
    blender-bin = {
      url = "github:ShadowRZ/nix-kotone?dir=blender-bin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin-nix = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    crane = {
      url = "github:ipetkov/crane";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs = {
        nixpkgs.follows = "";
        nixpkgs-stable.follows = ""; # Only used for Nix Community Hydra jobs
      };
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "";
    };
    import-tree = {
      url = "github:vic/import-tree";
    };
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
    neovim-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
    niri = {
      url = "github:niri-wm/niri";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        rust-overlay.follows = "";
      };
    };
    nix-indexdb = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "";
    };
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
    nixos-sensible = {
      url = "github:Guanran928/nixos-sensible";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    noctalia-shell = {
      url = "github:noctalia-dev/noctalia-shell/v5";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    preservation = {
      url = "github:nix-community/preservation";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "";
    };
    shadowrz = {
      url = "github:ShadowRZ/nur-packages";
      inputs.nixpkgs.follows = "";
    };
    silent-sddm = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "";
    };
    systems = {
      url = "github:nix-systems/default";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      # The Nixpkgs input is only used for its own checks and formatters,
      # and we only require its flake module which is independent.
      inputs.nixpkgs.follows = "";
    };
    # keep-sorted end
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
