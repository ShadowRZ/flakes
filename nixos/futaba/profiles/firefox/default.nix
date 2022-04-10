{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland.override {
      extraPolicies = {
        PasswordManagerEnabled = false;
        DisableFirefoxAccounts = true;
        DisablePocket = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
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
        userChrome = ''
          /* Hide tab bar in FF Quantum */
          @-moz-document url("chrome://browser/content/browser.xul") {
            #TabsToolbar {
              visibility: collapse !important;
              margin-bottom: 21px !important;
            }

            #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
              visibility: collapse !important;
            }
          }
        '';
        userContent = ''
          /* Hide scrollbar in FF Quantum */
          * {
            scrollbar-width: none !important;
          }
        '';
      };
    };
    # Firefox extensions
    # TODO: Add links to https://addons.mozilla.org
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      add-custom-search-engine
      auto-tab-discard
      behind-the-overlay-revival
      clearurls
      cookies-txt
      copy-selection-as-markdown
      decentraleyes
      display-_anchors
      don-t-fuck-with-paste
      export-tabs-urls-and-titles
      firefox-color
      form-history-control
      multi-account-containers
      no-pdf-download
      offline-qr-code-generator
      single-file
      stylus
      tabliss
      tree-style-tab
      (ublock-origin.override {
        version = "1.42.4";
        url = "https://github.com/gorhill/uBlock/releases/download/1.42.4/uBlock0_1.42.4.firefox.signed.xpi";
        sha256 = "sha256-vDwzXJYSactA3RFVF4jQ2GdK78rNyPvfbBmEXq6jOc4=";
      })
      violentmonkey
      wappalyzer
    ];
  };
}
