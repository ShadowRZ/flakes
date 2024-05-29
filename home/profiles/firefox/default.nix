{ pkgs, nur, ... }: {
  programs = {
    ### Firefox
    firefox = {
      enable = true;
      package = pkgs.firefox.override {
        nativeMessagingHosts = with pkgs; [
          # Plasma Integration
          kdePackages.plasma-browser-integration
          # KeePassXC
          keepassxc
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
        };
      };
      # Profiles
      profiles = {
        default = {
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
          extensions = with nur.repos.rycee.firefox-addons;
            [
              clearurls
              cliget
              container-proxy
              don-t-fuck-with-paste
              ghosttext
              keepassxc-browser
              link-gopher
              localcdn
              multi-account-containers
              no-pdf-download
              offline-qr-code-generator
              open-in-browser
              plasma-integration
              sidebery
              single-file
              stylus
              tabliss
              (ublock-origin.override rec {
                version = "1.52.2";
                url =
                  "https://github.com/gorhill/uBlock/releases/download/${version}/uBlock0_${version}.firefox.signed.xpi";
                sha256 = "sha256-6O4/nVl6bULbnXP+h8HVId40B1X9i/3WnkFiPt/gltY=";
              })
              vimium-c
              violentmonkey
              vue-js-devtools
            ] ++ (let
              addons = pkgs.callPackage ./addons.nix {
                buildFirefoxXpiAddon =
                  nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon;
              };
            in with addons; [
              copy-linktab-name-and-url
              custom-scrollbars
              emoji-sav
              foxyimage
              measure-it
              textarea-cache
              tranquility-reader
            ]);
        } // (let theme = pkgs.callPackage ./firefox-gnome-theme.nix { };
        in {
          userChrome = ''
            @import "${theme}/lib/firefox-gnome-theme/userChrome.css";
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
        });
      };
    };
  };
}
