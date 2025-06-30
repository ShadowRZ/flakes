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
                  # Required by ShyFox
                  "sidebar.revamp" = false;
                  "layout.css.has-selector.enabled" = true;
                  "browser.urlbar.suggest.calculator" = true;
                  "browser.urlbar.unitConversion.enabled" = true;
                  "browser.urlbar.trimHttps" = true;
                  "browser.urlbar.trimURLs" = true;
                  "widget.gtk.rounded-bottom-corners.enabled" = true;
                  "widget.gtk.ignore-bogus-leave-notify" = "1";
                  # ShyFox
                  "shyfox.larger.context.menu" = true;
                  "shyfox.enable.ext.mono.toolbar.icons" = true;
                  "shyfox.enable.ext.mono.context.icons" = true;
                  "shyfox.enable.context.menu.icons" = true;
                  "shyfox.fill.accent.with.icons.fill.color" = true;
                  "shyfox.force.native.controls" = true;
                };
                # Firefox extensions
                extensions.packages =
                  (with pkgs.firefox-addons; [
                    auto-tab-discard
                    behind-the-overlay-revival
                    bitwarden
                    clearurls
                    cliget
                    copy-selection-as-markdown
                    don-t-fuck-with-paste
                    fediact
                    firefox-color
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
                    side-view
                    sidebery
                    single-file
                    streetpass-for-mastodon
                    stylus
                    tabliss
                    tranquility-1
                    (ublock-origin.override rec {
                      version = "1.61.2";
                      url = "https://github.com/gorhill/uBlock/releases/download/${version}/uBlock0_${version}.firefox.signed.xpi";
                      sha256 = "sha256-7jpySkb/MsF9FyMHf+zG7ef9q3QhVAILUftiU93LuhQ=";
                    })
                    violentmonkey
                    vue-js-devtools
                    webhint
                  ])
                  ++ (with pkgs.shadowrz.firefox-addons; [
                    # Additional
                    copy-linktab-name-and-url
                    custom-scrollbars
                    emoji-sav
                    foxyimage
                    measure-it
                    textarea-cache
                    pwas-for-firefox
                  ]);
              };
            };
          };
        };
      };
  };
}
