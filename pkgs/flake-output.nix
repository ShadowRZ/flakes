{ flake-utils, nixpkgs, fenix }:
flake-utils.lib.eachDefaultSystem (system:
  let 
    pkgs = nixpkgs.legacyPackages.${system};
    fenix_ = fenix.packages.${system};
  in {
    packages = (import ./. { inherit pkgs; })
      // (import ./rust-nightly-packages { inherit pkgs; fenix = fenix_; });
  }) // {
    # Overlay
    # Rust Nightly packages are unavilable
    overlay = final: prev: import ./. { pkgs = prev; };
  }
