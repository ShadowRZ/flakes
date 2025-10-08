{ inputs, ... }:
{
  flake.overlays.default = final: prev: {
    # https://github.com/NixOS/nixpkgs/pull/449551 TODO: Remove when merged
    ltrace = prev.zsh.overrideAttrs (attrs: {
      patches = (attrs.patches or [ ]) ++ [
        (final.fetchpatch {
          name = "ltrace-0.7.3-print-test-pie.patch";
          url = "https://raw.githubusercontent.com/gentoo/gentoo/refs/heads/master/dev-debug/ltrace/files/ltrace-0.7.3-print-test-pie.patch";
          hash = "sha256-rUafTv13a4vS/yNIVRMbm5zwWTVTqMmFgmnS/XtPfdE=";
        })
      ];
    });
    shadowrz = {
      firefox-addons = final.callPackage ../../firefox/addons.nix {
        inherit (final.firefox-addons) buildFirefoxXpiAddon;
      };
      silent-sddm = final.silent-sddm.override {
        theme = "default";
        extraBackgrounds = [ final.nixos-artwork.wallpapers.nineish.src ];
        theme-overrides = {
          "LoginScreen" = {
            blur = 75;
            background = "${final.nixos-artwork.wallpapers.nineish.src.name}";
          };
          "LockScreen" = {
            blur = 0;
            background = "${final.nixos-artwork.wallpapers.nineish.src.name}";
          };
          "LockScreen.Clock" = {
            font-family = "Space Grotesk";
          };
          "LockScreen.Date" = {
            font-family = "Space Grotesk";
          };
          "LockScreen.Message" = {
            font-family = "Space Grotesk";
          };
          "LoginScreen.LoginArea.Username" = {
            font-family = "Space Grotesk";
          };
          "LoginScreen.LoginArea.PasswordInput" = {
            font-family = "Space Grotesk";
          };
          "LoginScreen.LoginArea.LoginButton" = {
            font-family = "Space Grotesk";
          };
          "LoginScreen.LoginArea.Spinner" = {
            font-family = "Space Grotesk";
          };
          "LoginScreen.LoginArea.WarningMessage" = {
            font-family = "Space Grotesk";
          };
          "LoginScreen.MenuArea.Buttons" = {
            font-family = "Space Grotesk";
          };
          "LoginScreen.MenuArea.Popups" = {
            font-family = "Space Grotesk";
          };
          "Tooltips" = {
            font-family = "Space Grotesk";
          };
          "LoginScreen.MenuArea.Layout" = {
            display = false;
          };
        };
      };
    };
    silent-sddm = final.callPackage inputs.silent-sddm {
      gitRev = inputs.silent-sddm.rev;
    };
  };
}
