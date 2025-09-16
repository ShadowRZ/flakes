{
  flake.modules.homeManager = {
    desktop =
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
                  # Disable builtin MPRIS support in favor of Plasma Integration's one
                  "media.hardwaremediakeys.enabled" = false;
                  # Force enable account containers
                  "privacy.userContext.enabled" = true;
                  "privacy.userContext.ui.enabled" = true;
                  # Enable customChrome.css
                  "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
                  # Enable SVG context-propertes
                  "svg.context-properties.content.enabled" = true;
                };
                # Firefox extensions
                extensions.packages = [
                  pkgs.firefox-addons.auto-tab-discard
                  pkgs.firefox-addons.behind-the-overlay-revival
                  pkgs.firefox-addons.bitwarden
                  pkgs.firefox-addons.clearurls
                  pkgs.firefox-addons.cliget
                  pkgs.firefox-addons.copy-selection-as-markdown
                  pkgs.firefox-addons.don-t-fuck-with-paste
                  pkgs.firefox-addons.fediact
                  pkgs.firefox-addons.firefox-color
                  pkgs.firefox-addons.ghosttext
                  pkgs.firefox-addons.link-gopher
                  pkgs.firefox-addons.linkhints
                  pkgs.firefox-addons.localcdn
                  pkgs.firefox-addons.multi-account-containers
                  pkgs.firefox-addons.no-pdf-download
                  pkgs.firefox-addons.offline-qr-code-generator
                  pkgs.firefox-addons.open-in-browser
                  pkgs.firefox-addons.plasma-integration
                  pkgs.firefox-addons.qr-code-address-bar
                  pkgs.firefox-addons.re-enable-right-click
                  pkgs.firefox-addons.react-devtools
                  pkgs.firefox-addons.reduxdevtools
                  pkgs.firefox-addons.side-view
                  pkgs.firefox-addons.sidebery
                  pkgs.firefox-addons.single-file
                  pkgs.firefox-addons.streetpass-for-mastodon
                  pkgs.firefox-addons.stylus
                  pkgs.firefox-addons.tabliss
                  pkgs.firefox-addons.tranquility-1
                  pkgs.firefox-addons.ublock-origin
                  pkgs.firefox-addons.violentmonkey
                  pkgs.firefox-addons.vue-js-devtools
                  pkgs.firefox-addons.webhint
                  pkgs.shadowrz.firefox-addons.copy-linktab-name-and-url
                  pkgs.shadowrz.firefox-addons.custom-scrollbars
                  pkgs.shadowrz.firefox-addons.emoji-sav
                  pkgs.shadowrz.firefox-addons.foxyimage
                  pkgs.shadowrz.firefox-addons.measure-it
                  pkgs.shadowrz.firefox-addons.textarea-cache
                  pkgs.shadowrz.firefox-addons.pwas-for-firefox
                ];
              };
            };
          };
        };
      };
  };
}
