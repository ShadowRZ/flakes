{ pkgs, specialArgs, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      extraPolicies = {
        PasswordManagerEnabled = true;
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
        name = "Minoko";
        settings = {
          "fission.autostart" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.rdd-ffmpeg.enabled" = true;
          # Force enable account containers
          "privacy.userContext.enabled" = true;
          "privacy.userContext.ui.enabled" = true;
        };
      };
    };
    # Firefox extensions
    # TODO: Add links to https://addons.mozilla.org
    extensions = with specialArgs.nur.repos.rycee.firefox-addons;
      [
        add-custom-search-engine
        auto-tab-discard
        behind-the-overlay-revival
        clearurls
        cookies-txt
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
        single-file
        stylus
        tabliss
        # tree-style-tab TODO
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
  };
}
