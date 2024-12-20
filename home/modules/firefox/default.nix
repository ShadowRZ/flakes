{
  pkgs,
  ...
}:
{
  programs = {
    ### Firefox
    firefox = {
      enable = true;
      package = pkgs.firefox.override {
        nativeMessagingHosts = with pkgs; [
          # Plasma Integration
          kdePackages.plasma-browser-integration
          # Firefox PWA Plugin
          firefoxpwa
        ];
      };
      policies = {
        PasswordManagerEnabled = false;
        DisableFirefoxAccounts = true;
        DisablePocket = true;
        ExtensionUpdate = false;
        FirefoxHome = {
          Pocket = false;
          Snippets = false;
        };
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
          UrlbarInterventions = false;
          MoreFromMozilla = false;
        };
        Preferences = {
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.urlbar.autoFill.adaptiveHistory.enabled" = true;
          # Force enable VA-API
          "media.ffmpeg.vaapi.enabled" = true;
          # Enable "Not Secure" texts
          "security.insecure_connection_text.enabled" = true;
          "security.insecure_connection_text.pbmode.enabled" = true;
          # Set UI density to normal
          "browser.uidensity" = 0;
          # Disable PPA
          # https://michael.kjorling.se/blog/2024/disabling-privacy-preserving-ad-measurement-in-firefox-128/
          "dom.private-attribution.submission.enabled" = false;
        };
      };
      # Profiles
      profiles = {
        default =
          {
            name = "羽心印音";
            settings = {
              # Disable builtin MPRIS support in favor of Plasma Integration's one
              "media.hardwaremediakeys.enabled" = false;
              # Force enable account containers
              "privacy.userContext.enabled" = true;
              "privacy.userContext.ui.enabled" = true;
              # Enable customChrome.css
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
              # Enable SVG context-propertes
              "svg.context-properties.content.enabled" = true;
              # Disable private window dark theme
              "browser.theme.dark-private-windows" = false;
              ## Optional options provided by firefox-gnome-theme
              ## See https://github.com/rafaelmardojai/firefox-gnome-theme
              "gnomeTheme.hideSingleTab" = true;
              "gnomeTheme.activeTabContrast" = true;
            };
            # Firefox extensions
            extensions =
              with pkgs.nur.repos.rycee.firefox-addons;
              [
                auto-tab-discard
                behind-the-overlay-revival
                bitwarden
                clearurls
                cliget
                copy-selection-as-markdown
                don-t-fuck-with-paste
                fastforwardteam
                ghosttext
                link-gopher
                linkhints
                localcdn
                multi-account-containers
                no-pdf-download
                offline-qr-code-generator
                open-in-browser
                plasma-integration
                qr-code-address-bar
                re-enable-right-click
                react-devtools
                reduxdevtools
                sidebery
                single-file
                streetpass-for-mastodon
                stylus
                tabliss
                (ublock-origin.override rec {
                  version = "1.58.0";
                  url = "https://github.com/gorhill/uBlock/releases/download/${version}/uBlock0_${version}.firefox.signed.xpi";
                  sha256 = "sha256-RwxWmUpxdNshV4rc5ZixWKXcCXDIfFz+iJrGMr0wheo=";
                })
                violentmonkey
                vue-js-devtools
                webhint
              ]
              ++ (
                let
                  addons = pkgs.callPackage ./addons.nix {
                    inherit (pkgs.nur.repos.rycee.firefox-addons) buildFirefoxXpiAddon;
                  };
                in
                with addons;
                [
                  copy-linktab-name-and-url
                  custom-scrollbars
                  emoji-sav
                  foxyimage
                  measure-it
                  textarea-cache
                  tranquility-reader
                  pwas-for-firefox
                ]
              );
          }
          // (
            let
              theme = pkgs.callPackage ./firefox-gnome-theme.nix { };
            in
            {
              userChrome = ''
                @import "${theme}/lib/firefox-gnome-theme/userChrome.css";
                @import "firefox-gnome-theme/customChrome.css";
                @import "customChrome.css";

                #TabsToolbar {
                  display: none !important;
                }

                #sidebar-header {
                  display: none !important;
                }
              '';
              userContent = ''
                @import "${theme}/lib/firefox-gnome-theme/userContent.css";
              '';
            }
          );
      };
    };
  };
}
