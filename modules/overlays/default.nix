{ inputs, ... }:
{
  flake.overlays.default = final: prev: {
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
