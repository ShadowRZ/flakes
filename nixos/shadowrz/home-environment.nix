{ config, pkgs, lib, nur, ... }: {

  home = {
    stateVersion = "22.11";
    sessionVariables = {
      GTK_CSD = "0";
      XAPIAN_CJK_NGRAM = "1";
    };
    packages = with pkgs; [
      w3m
      nwjs
      rclone
      assimp
      lsof
      renpy
      # VS Code
      vscode-fhs
      # For using Notmuch in Emacs
      notmuch.emacs
    ];
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
    ### OBS
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [ wlrobs ];
    };
    ### Git
    git = {
      enable = true;
      package = pkgs.gitFull; # git-send-email TBD
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
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      autocd = true;
      defaultKeymap = "emacs";
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
      };
      initExtraFirst = lib.mkBefore ''
        # Subreap
        { zmodload lilydjwg/subreap && subreap; } >/dev/null 2>&1
        # Enable terminal cursor
        ${pkgs.util-linux}/bin/setterm -cursor on
        ${pkgs.coreutils}/bin/stty -ixon
        # Powerlevek10k Instant prompt
        if [[ -r "${
          "\${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}"
        }.zsh" ]]; then
          source "${
            "\${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}"
          }.zsh"
        fi
      '';
      initExtra = with pkgs; ''
        export GPG_TTY=$TTY
        . ${oh-my-zsh}/share/oh-my-zsh/plugins/git/git.plugin.zsh
        . ${oh-my-zsh}/share/oh-my-zsh/plugins/sudo/sudo.plugin.zsh
        . ${zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh
        . ${zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
        . ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        . ${./files/p10k.zsh}
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
        catppuccin-nvim
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
            localcdn
            multi-account-containers
            no-pdf-download
            offline-qr-code-generator
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
          ];
        } // (let theme = pkgs.callPackage ./files/firefox-gnome-theme.nix { };
        in {
          userChrome = ''
            @import "${theme}/lib/firefox-gnome-theme/userChrome.css";
          '';
          userContent = ''
            @import "${theme}/lib/firefox-gnome-theme/userContent.css";
          '';
        });
      };
    };
    ### Alacritty
    alacritty = {
      enable = true;
      settings = {
        import = [ ./files/catppuccin-mocha.yml ];
        env.TERM = "xterm-256color";
        window = {
          decoration = "full";
          dynamic_title = true;
        };
        font = {
          normal.family = "Sarasa Term SC";
          size = 16;
          builtin_box_drawing = true;
        };
        cursor.shape = {
          shape = "Block";
          blinking = "Off";
        };
        shell.program = "${config.programs.tmux.package}/bin/tmux";
      };
    };
    ### Tmux
    tmux = {
      enable = true;
      baseIndex = 1;
      escapeTime = 0;
      keyMode = "vi";
      secureSocket = true;
      terminal = "tmux-256color";
      sensibleOnTop = true;
      shortcut = "a";
      extraConfig = builtins.readFile ./files/tmux.conf;
    };
    ### Msmtp
    msmtp.enable = true;
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
    ### Afew
    afew = {
      enable = true;
      extraConfig = builtins.readFile ./files/afew.config;
    };
  };
  ###### End of program configs.
  ###### Services configs start here.
  services = {
    ### GnuPG Agent
    gpg-agent = {
      enable = true;
      # Zsh has $TTY
      enableZshIntegration = false;
      extraConfig = ''
        allow-loopback-pinentry
        allow-emacs-pinentry
      '';
      pinentryFlavor = "qt";
    };
  };
  ###### End of service configs.

  ###### Account configs.
  accounts.email.accounts = {
    "ShadowRZ" = {
      address = "shadowrz@disroot.org";
      gpg.key = "3237D49E8F815A45213364EA4FF35790F40553A9";
      msmtp = { enable = true; };
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
      notmuch = { enable = true; };
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
    };
  };
  ###### End of Account configs.

  # Session variables for Systemd user units.
  # Plasma (+systemd) & GDM launched session reads these too.
  systemd.user.sessionVariables = {
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

  # Fontconfig.
  fonts.fontconfig.enable = true;
  xdg.configFile = {
    "fontconfig/conf.d/99-fontconfig.conf".source = ./files/fontconfig.conf;
  };
}
