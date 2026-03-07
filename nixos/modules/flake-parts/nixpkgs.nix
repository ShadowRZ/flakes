{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      # Instance a global Nixpkgs
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          # keep-sorted start
          inputs.blender-bin.overlays.default
          inputs.emacs-overlay.overlays.default
          inputs.firefox-addons-nix.overlays.default
          inputs.neovim-overlay.overlays.default
          inputs.nix-indexdb.overlays.nix-index
          inputs.rust-overlay.overlays.default
          inputs.shadowrz.overlays.default
          # keep-sorted end
        ];
        config = {
          allowUnfree = true;
          allowInsecurePredicate = pkg: builtins.elem (inputs.nixpkgs.lib.getName pkg) [ "electron" ];
          # https://developer.android.google.cn/studio/terms
          android_sdk.accept_license = true;
        };
      };
    };
}
