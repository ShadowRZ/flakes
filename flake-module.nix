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

      devShells = {
        rust = pkgs.mkShell {
          buildInputs = with pkgs; [
            openssl
            pkg-config
            rust-bin.stable.latest.default
          ];
        };
        rust-nightly = pkgs.mkShell {
          buildInputs = with pkgs; [
            openssl
            pkg-config
            rust-bin.selectLatestNightlyWith (toolchain: toolchain.default)
          ];
        };
      };
    };
}
