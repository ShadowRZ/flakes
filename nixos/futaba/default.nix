{ config, pkgs, lib, ... }: {
  imports = [
    ./modules/git
    ./modules/neovim
    ./modules/shell
    ./modules/email
    ./modules/firefox
    ./modules/terminal
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "futaba";
  home.homeDirectory = "/home/futaba";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    bubblewrap
    w3m
    nwjs
    optipng
    nix-prefetch-github
    nix-prefetch-git
    fontforge-gtk
    android-tools
    rclone
    assimp
    gnome.dconf-editor
    lsof
    helvum
    # VS Code
    vscode-fhs
    asciinema
    wine-staging
    winetricks
    strawberry
  ];

  # Fcitx 5
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-pinyin-moegirl
      fcitx5-pinyin-zhwiki
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
        keyserver = "hkps://keyserver.ubuntu.com";
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
    ### Qutebrowser
    qutebrowser = {
      enable = true;
      loadAutoconfig = true;
    };
    ### OBS
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        #wlrobs
      ];
    };
    ### Password store
    password-store = { enable = true; };
    ### Ncmpcpp
    ncmpcpp = {
      enable = true;
      package = pkgs.ncmpcpp;
      settings = {
        ncmpcpp_directory = "~/.local/share/ncmpcpp";
        mpd_host = "${config.services.mpd.network.listenAddress}";
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
    ### Music Player Daemon
    mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Music";
      # Use a socket
      network = { listenAddress = "/run/user/1000/mpd.socket"; };
      extraConfig = ''
        zeroconf_enabled "yes"
        zeroconf_name "Music Player Daemon @ %h"
        # Output to PulseAudio directly
        audio_output {
          type "pulse"
          name "Music Player Daemon [PulseAudio]"
        }
      '';
    };
  };
  ###### End of service configs.

  # XXX: Kill generated Systemd service for Fcitx 5
  # Required to make sure KWin can bring a Fcitx 5 up to support Wayland IME protocol
  systemd.user.services.fcitx5-daemon = lib.mkForce {};

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
    PASSWORD_STORE_DIR = config.home.sessionVariables.PASSWORD_STORE_DIR;
    GNUPGHOME = config.home.sessionVariables.GNUPGHOME;
  };
}
