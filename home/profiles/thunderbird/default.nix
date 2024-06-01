{pkgs, ...}: {
  programs = {
    ### Thunderbird
    thunderbird = {
      enable = true;
      profiles = {
        default =
          {
            isDefault = true;
            settings = {
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
              "svg.context-properties.content.enabled" = true;
              "gnomeTheme.hideTabbar" = true;
              "gnomeTheme.activeTabContrast" = true;
            };
            withExternalGnupg = true;
          }
          // (let
            theme = pkgs.callPackage ./thunderbird-gnome-theme.nix {};
          in {
            userChrome = ''
              @import "${theme}/lib/thunderbird-gnome-theme/userChrome.css";
              @import "customChrome.css";
            '';
            userContent = ''
              @import "${theme}/lib/thunderbird-gnome-theme/userContent.css";
            '';
          });
      };
    };
  };
}
