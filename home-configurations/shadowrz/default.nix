{ config, lib, pkgs, ezModules, ... }: {

  imports = [
    ezModules.firefox
    ezModules.thunderbird
    ezModules.shadowrz
  ];

  programs = {
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
