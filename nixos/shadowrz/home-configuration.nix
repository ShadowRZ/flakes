{ config, pkgs, lib, nur, ... }: {

  home = {
    stateVersion = "23.05";
    sessionVariables = {
      GTK_CSD = "0";
      XAPIAN_CJK_NGRAM = "1";
    };
  };

  ###### Program configs start here.
  programs = {
    ### GnuPG
    gpg = {
      enable = true;
      settings = {
        personal-digest-preferences = "SHA512";
        cert-digest-algo = "SHA512";
        default-preference-list =
          "SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed";
        personal-cipher-preferences = "TWOFISH CAMELLIA256 AES 3DES";
        keyid-format = "0xlong";
        with-fingerprint = true;
        trust-model = "tofu";
        utf8-strings = true;
        keyserver = "hkps://keys.openpgp.org";
        verbose = false;
      };
    };
    ### Gh
    gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
    ### mpv
    mpv = {
      enable = true;
      config = {
        # OSD configs.
        osd-font = "小赖字体 SC";
        osd-font-size = 40;
        osd-on-seek = "msg-bar";

        # Enable builtin OSC
        osc = true;
        script-opts = "osc-vidscale=no";

        # Subtitles.
        sub-align-x = "right";
        sub-font-size = 45;
        sub-justify = "auto";
        sub-font = "小赖字体 SC";
        sub-border-size = 3;
        sub-color = "#DE8148";

        # (Try to) prefer hardware decoding.
        hwdec = "auto-safe";
      };
      scripts = with pkgs.mpvScripts; [ mpris ];
    };
    ### Git
    git = {
      enable = true;
      package = pkgs.gitFull;
      # Basic
      userEmail = "23130178+ShadowRZ@users.noreply.github.com";
      userName = "夜坂雅";
      signing = {
        signByDefault = true;
        key = "3237D49E8F815A45213364EA4FF35790F40553A9";
      };
      # Delta highlighter
      delta = {
        enable = true;
        options = {
          decorations = {
            commit-decoration-style = "bold yellow box ul";
            file-decoration-style = "none";
            file-style = "bold yellow ul";
          };
          features = "decorations";
          whitespace-error-style = "22 reverse";
        };
      };
      extraConfig = {
        init.defaultBranch = "master";
        sendemail.identity = "ShadowRZ";
      };
    };
    # Zsh
    zsh = {
      enable = true;
      autocd = true;
      shellGlobalAliases = {
        "..." = "../..";
        "...." = "../../..";
        "....." = "../../../..";
        "......" = "../../../../..";
        "......." = "../../../../../..";
      };
      history = {
        extended = true;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
        size = 50000;
        path = "${config.xdg.dataHome}/zsh/zsh_history";
      };
      historySubstringSearch.enable = true;
      initExtraFirst = lib.mkBefore ''
        # Subreap
        { zmodload lilydjwg/subreap && subreap; } >/dev/null 2>&1
        # Enable terminal cursor
        ${pkgs.util-linux}/bin/setterm -cursor on
        ${pkgs.coreutils}/bin/stty -ixon # Disable flow control
      '';
      initExtra = with pkgs; ''
        . ${oh-my-zsh}/share/oh-my-zsh/plugins/git/git.plugin.zsh
        . ${zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh

        ${builtins.readFile ./files/zshrc}
      '';
    };
    ### Neovim
    neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      vimdiffAlias = true;
      extraLuaConfig = builtins.readFile ./files/nvim.lua;
      plugins = with pkgs.vimPlugins; [
        lualine-nvim
        everforest
        nvim-lspconfig
        nvim-cmp
        cmp-nvim-lsp
        luasnip
        editorconfig-nvim
        # Tree Sitter
        (nvim-treesitter.withPlugins (plugins:
          with plugins; [
            tree-sitter-nix
            tree-sitter-lua
            tree-sitter-rust
            tree-sitter-c
            tree-sitter-cpp
            tree-sitter-python
          ]))
      ];
    };
    ### GNU Emacs
    emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
      extraPackages = epkgs: with epkgs; [ treesit-grammars.with-all-grammars ];
    };
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
    ### Mbsync
    mbsync.enable = true;
    ### Notmuch
    notmuch = {
      enable = true;
      hooks = {
        preNew = "mbsync -a";
        postNew = with pkgs; "${afew}/bin/afew -a -t";
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
    ### Aria2
    aria2 = { enable = true; };
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
  };
  ###### End of program configs.
  ###### Services configs start here.
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
  ###### End of service configs.

  ###### Account configs.
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
  ###### End of Account configs.

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
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
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
      dark-theme-enable = false;
      mpv-config-enable = true;
      mpv-config-file = "file:///${./files/celluloid.options}";
    };
  };

  # Fontconfig.
  fonts.fontconfig.enable = true;
  xdg.configFile = {
    "fontconfig/conf.d/99-fontconfig.conf".source = ./files/fontconfig.conf;
  };
}
