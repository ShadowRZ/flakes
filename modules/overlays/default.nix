{ inputs, ... }:
{
  flake.overlays.default = final: prev: {
    klassy = prev.klassy.overrideAttrs (finalAttrs: {
      version = "6.5";

      src = prev.fetchFromGitHub {
        owner = "paulmcauley";
        repo = "klassy";
        tag = "v${finalAttrs.version}";
        hash = "sha256-zf+RO+GolA9Gnf1/izIG7jCSu8Qlo0d0kRc90llMRIc=";
      };
    });
    shadowrz = {
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
