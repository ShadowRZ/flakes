# System local configs.

{ config, lib, pkgs, nur, ... }: {

  programs = {
    ### Firefox
    firefox = {
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
          extensions = with nur.repos.rycee.firefox-addons; [
            clearurls
            don-t-fuck-with-paste
            keepassxc-browser
            linkhints
            localcdn
            multi-account-containers
            no-pdf-download
            offline-qr-code-generator
            single-file
            stylus
            tabliss
            (ublock-origin.override {
              version = "1.52.2";
              url =
                "https://github.com/gorhill/uBlock/releases/download/1.52.2/uBlock0_1.52.2.firefox.signed.xpi";
              sha256 = "sha256-6O4/nVl6bULbnXP+h8HVId40B1X9i/3WnkFiPt/gltY=";
            })
            violentmonkey
          ];
        } // (let theme = pkgs.callPackage ./files/firefox-gnome-theme.nix { };
        in {
          userChrome = ''
            @import "${theme}/lib/firefox-gnome-theme/userChrome.css";
            @import "customChrome.css";
          '';
          userContent = ''
            @import "${theme}/lib/firefox-gnome-theme/userContent.css";
          '';
        });
      };
    };
    ### Wezterm
    wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./files/wezterm.lua;
    };
    ### GNU Emacs
    emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
      extraPackages = epkgs: with epkgs; [ treesit-grammars.with-all-grammars ];
    };
    ### Zathura
    zathura = { enable = true; };
    ### Thunderbird
    thunderbird = {
      enable = true;
      profiles = {
        default = {
          isDefault = true;
          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "svg.context-properties.content.enabled" = true;
            "gnomeTheme.hideTabbar" = true;
            "gnomeTheme.activeTabContrast" = true;
          };
          withExternalGnupg = true;
        } // (let
          theme = pkgs.callPackage ./files/thunderbird-gnome-theme.nix { };
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
    ### Mbsync
    mbsync.enable = true;
    ### Notmuch
    notmuch = {
      enable = true;
      hooks = {
        preNew = "mbsync -a";
        postNew = "${pkgs.afew}/bin/afew -a -t";
      };
      new.tags = [ "new" ];
    };
    ### Neomutt
    neomutt = {
      enable = true;
      sidebar = {
        enable = true;
        width = 26;
      };
      vimKeys = true;
      extraConfig = builtins.readFile ./files/neomutt.muttrc;
    };
    ### Afew
    afew = {
      enable = true;
      extraConfig = builtins.readFile ./files/afew.config;
    };
  };

  services = {
    ### GnuPG Agent
    gpg-agent = {
      enable = true;
      extraConfig = ''
        allow-loopback-pinentry
        allow-emacs-pinentry
      '';
      pinentryFlavor = "qt";
    };
    ### Emacs Client
    emacs = {
      enable = true;
      socketActivation.enable = true;
    };
  };

  systemd.user = {
    # Kill generated Systemd service for Fcitx 5
    # Required to make sure KWin can bring a Fcitx 5 up to support Wayland IME protocol
    services."app-org.fcitx.Fcitx5@autostart" = lib.mkForce { };
    # Session variables for Systemd user units.
    # Plasma (+systemd) & GDM launched session reads these too.
    sessionVariables = {
      LESSHISTFILE = "-";
      GST_VAAPI_ALL_DRIVERS = "1";
      # Fcitx 5
      XMODIFIERS = "@im=fcitx";
      # Inherits from home.sessionVariables
      GNUPGHOME = config.home.sessionVariables.GNUPGHOME;
      GTK_CSD = config.home.sessionVariables.GTK_CSD;
    };
  };

  dconf.settings = {
    "io/github/celluloid-player/celluloid" = {
      always-show-title-buttons = false;
      csd-enable = false;
      mpv-config-enable = true;
      mpv-config-file = "file:///${./files/celluloid.options}";
    };
  };

  accounts.email.accounts = {
    "ShadowRZ" = {
      address = "shadowrz@disroot.org";
      gpg.key = "3237D49E8F815A45213364EA4FF35790F40553A9";
      msmtp.enable = true;
      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
      };
      imap = {
        host = "disroot.org";
        port = 993;
        tls.enable = true;
      };
      notmuch = {
        enable = true;
        neomutt = {
          enable = true;
          virtualMailboxes = [{
            name = "Nixpkgs";
            query = "tag:nixpkgs";
            type = "threads";
          }];
        };
      };
      smtp = {
        host = "disroot.org";
        port = 465;
        tls.enable = true;
      };
      passwordCommand =
        "${pkgs.libsecret}/bin/secret-tool lookup email shadowrz@disroot.org";
      primary = true;
      realName = "夜坂雅";
      userName = "shadowrz@disroot.org";
      neomutt = { enable = true; };
    };
  };

}
