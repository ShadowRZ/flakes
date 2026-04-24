{
  flake.modules.homeManager.desktop =
    {
      config,
      pkgs,
      ...
    }:
    {
      programs = {
        ### Firefox
        firefox = {
          enable = true;
          configPath = "${config.xdg.configHome}/mozilla/firefox";
          policies = {
            PasswordManagerEnabled = false;
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
              # Disable PPA
              # https://michael.kjorling.se/blog/2024/disabling-privacy-preserving-ad-measurement-in-firefox-128/
              "dom.private-attribution.submission.enabled" = false;
            };
          };
          # Profiles
          profiles = {
            default = {
              name = "Hanekokoro (はねこころ)";
              settings = {
                "media.hardwaremediakeys.enabled" = true;
                # Force enable account containers
                "privacy.userContext.enabled" = true;
                "privacy.userContext.ui.enabled" = true;
                # Enable customChrome.css
                "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
                # Enable SVG context-propertes
                "svg.context-properties.content.enabled" = true;
              };
              # Firefox extensions
              extensions.packages = with pkgs.firefox-addons; [
                # keep-sorted start sticky_comments=yes
                # https://addons.mozilla.org/firefox/addon/auto-tab-discard/
                auto-tab-discard
                # https://addons.mozilla.org/firefox/addon/behind-the-overlay-revival/
                behind-the-overlay-revival
                # https://addons.mozilla.org/firefox/addon/bitwarden/
                bitwarden
                # https://addons.mozilla.org/firefox/addon/clearurls/
                clearurls
                # https://addons.mozilla.org/firefox/addon/cliget/
                cliget
                # https://addons.mozilla.org/firefox/addon/copy-selection-as-markdown/
                copy-selection-as-markdown
                # https://addons.mozilla.org/firefox/addon/don-t-fuck-with-paste/
                don-t-fuck-with-paste
                # https://addons.mozilla.org/firefox/addon/fediact/
                fediact
                # https://addons.mozilla.org/firefox/addon/firefox-color/
                firefox-color
                # https://addons.mozilla.org/firefox/addon/ghosttext/
                ghosttext
                # https://addons.mozilla.org/firefox/addon/link-gopher/
                link-gopher
                # https://addons.mozilla.org/firefox/addon/linkhints/
                linkhints
                # https://addons.mozilla.org/firefox/addon/localcdn/
                localcdn
                # https://addons.mozilla.org/firefox/addon/multi-account-containers/
                multi-account-containers
                # https://addons.mozilla.org/firefox/addon/no-pdf-download/
                no-pdf-download
                # https://addons.mozilla.org/firefox/addon/offline-qr-code-generator/
                offline-qr-code-generator
                # https://addons.mozilla.org/firefox/addon/open-in-browser/
                open-in-browser
                # https://addons.mozilla.org/firefox/addon/plasma-integration/
                plasma-integration
                # https://addons.mozilla.org/firefox/addon/pywalfox/
                pywalfox
                # https://addons.mozilla.org/firefox/addon/qr-code-address-bar/
                qr-code-address-bar
                # https://addons.mozilla.org/firefox/addon/re-enable-right-click/
                re-enable-right-click
                # https://addons.mozilla.org/firefox/addon/react-devtools/
                react-devtools
                # https://addons.mozilla.org/firefox/addon/reduxdevtools/
                reduxdevtools
                # https://addons.mozilla.org/firefox/addon/side-view/
                side-view
                # https://addons.mozilla.org/firefox/addon/single-file/
                single-file
                # https://addons.mozilla.org/firefox/addon/streetpass-for-mastodon/
                streetpass-for-mastodon
                # https://addons.mozilla.org/firefox/addon/stylus/
                stylus
                # https://addons.mozilla.org/firefox/addon/tabliss/
                tabliss
                # https://addons.mozilla.org/firefox/addon/tranquility-1/
                tranquility-1
                # https://addons.mozilla.org/firefox/addon/ublock-origin-upstream/
                ublock-origin-upstream
                # https://addons.mozilla.org/firefox/addon/vimium/
                vimium
                # https://addons.mozilla.org/firefox/addon/violentmonkey/
                violentmonkey
                # https://addons.mozilla.org/firefox/addon/vue-js-devtools/
                vue-js-devtools
                # https://addons.mozilla.org/firefox/addon/wappalyzer/
                wappalyzer
                # https://addons.mozilla.org/firefox/addon/webhint/
                webhint
                # keep-sorted end
              ];
            };
          };
        };
      };
    };

  flake.modules.nixos.desktop = {
    hanekokoro.nixos.allowedUnfreePredicates = [ "wappalyzer" ];

    hanekokoro.nixos.preservation.user.directories = [ ".config/mozilla/firefox/default" ];
  };
}
