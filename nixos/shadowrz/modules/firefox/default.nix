{ pkgs, lib, specialArgs, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      extraPolicies = {
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
        };
      };
      extraPrefs = ''
        lockPref("browser.newtabpage.activity-stream.feeds.topsites", false);
        lockPref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
        lockPref("security.identityblock.show_extended_validation", true);
      '';
    };
    # Profiles
    profiles = {
      default = {
        name = "羽心印音";
        settings = {
          "fission.autostart" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.rdd-ffmpeg.enabled" = true;
          # Force enable account containers
          "privacy.userContext.enabled" = true;
          "privacy.userContext.ui.enabled" = true;
          # Enable customChrome.css
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          # Set UI density to normal
          "browser.uidensity" = 0;
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
        # TODO: Add links to https://addons.mozilla.org
        extensions = with specialArgs.nur.repos.rycee.firefox-addons;
          [
            add-custom-search-engine
            auto-tab-discard
            behind-the-overlay-revival
            clearurls
            copy-selection-as-markdown
            display-_anchors
            don-t-fuck-with-paste
            export-tabs-urls-and-titles
            form-history-control
            keepassxc-browser
            linkhints
            localcdn
            multi-account-containers
            no-pdf-download
            offline-qr-code-generator
            org-capture
            plasma-integration
            single-file
            stylus
            tabliss
            tree-style-tab
            (ublock-origin.override {
              version = "1.42.4";
              url =
                "https://github.com/gorhill/uBlock/releases/download/1.42.4/uBlock0_1.42.4.firefox.signed.xpi";
              sha256 = "sha256-vDwzXJYSactA3RFVF4jQ2GdK78rNyPvfbBmEXq6jOc4=";
            })
            violentmonkey
            wappalyzer
          ] ++ (let
            extra-addons = pkgs.callPackage ./extra-addons.nix {
              buildFirefoxXpiAddon =
                specialArgs.nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon;
            };
          in with extra-addons; [ redirector custom-scrollbars measure-it ]);
      } // (let theme = pkgs.callPackage ./firefox-gnome-theme.nix { };
      in {
        userChrome = ''
          @import "${theme}/lib/firefox-gnome-theme/userChrome.css";
          @import "firefox-gnome-theme/customChrome.css";
        '';
        userContent = ''
          @import "${theme}/lib/firefox-gnome-theme/userContent.css";
        '';
      });
    };
  };

  # Populate a usable ~/.mozilla/firefox/*/chrome/firefox-gnome-theme
  # Used for Gradience
  home.activation = {
    ensureFirefoxGnomePath = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      for i in "$HOME/.mozilla/firefox"/*/chrome; do
        [[ -d $i/firefox-gnome-theme ]] || $DRY_RUN_CMD mkdir -p $VERBOSE_ARG $i/firefox-gnome-theme
      done
    '';
  };
}
