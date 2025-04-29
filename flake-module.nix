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
          inputs.self.overlays.default
          inputs.self.overlays.blender-bin
          inputs.self.overlays.firefox-addons

          inputs.nix-indexdb.overlays.nix-index
          inputs.shadowrz.overlays.default
          inputs.rust-overlay.overlays.default
        ];
        config = {
          allowUnfree = true;
          allowInsecurePredicate = pkg: builtins.elem (inputs.nixpkgs.lib.getName pkg) [ "electron" ];
          # https://developer.android.google.cn/studio/terms
          android_sdk.accept_license = true;
        };
      };

      # Export package
      packages = {
        inherit (pkgs) mozilla-addons-to-nix;
      };
    };
}
