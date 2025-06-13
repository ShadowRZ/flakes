{ inputs, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];

  perSystem =
    { system, pkgs, ... }:
    {
      treefmt.config = import ./treefmt.nix;

      # Instance a global Nixpkgs
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          inputs.nix-indexdb.overlays.nix-index
          inputs.rust-overlay.overlays.default
          inputs.rycee-firefox.overlays.default
          inputs.shadowrz.overlays.default

          inputs.self.overlays.default
          inputs.self.overlays.blender-bin
        ];
        config = {
          allowUnfree = true;
          allowInsecurePredicate = pkg: builtins.elem (inputs.nixpkgs.lib.getName pkg) [ "electron" ];
          # https://developer.android.google.cn/studio/terms
          android_sdk.accept_license = true;
        };
      };

      devShells =
        let
          mkRustDevShell =
            rust-package:
            pkgs.mkShell {
              packages = with pkgs; [
                openssl
                pkg-config
                rust-package
              ];

              RUST_SRC_PATH = "${rust-package}/lib/rustlib/src/rust/library";
            };
        in
        {
          rust =
            mkRustDevShell (
              pkgs.rust-bin.stable.latest.default.override {
                extensions = [ "rust-src" ];
              }
            )
            // builtins.mapAttrs (
              version: toolchain:
              toolchain.default.override {
                extensions = [ "rust-src" ];
              }
            ) pkgs.rust-bin.stable;
          rust-nightly =
            mkRustDevShell (
              pkgs.rust-bin.selectLatestNightlyWith (
                toolchain:
                toolchain.default.override {
                  extensions = [ "rust-src" ];
                }
              )
            )
            // builtins.mapAttrs (
              version: toolchain:
              toolchain.default.override {
                extensions = [ "rust-src" ];
              }
            ) pkgs.rust-bin.nightly;
        };
    };
}
