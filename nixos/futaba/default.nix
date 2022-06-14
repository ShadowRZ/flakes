{ config, pkgs, ... }: {
  imports = [
    ./profiles/git
    ./profiles/neovim
    ./profiles/shell
    ./profiles/email
    ./profiles/firefox
    ./profiles/waybar
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
  home.stateVersion = "21.05";

  home.packages = with pkgs; [
    bubblewrap
    w3m
    nwjs
    optipng
    nix-prefetch-github
    nix-prefetch-git
    fontforge-gtk
    android-tools
    nheko
    rclone
    assimp
    gnome.dconf-editor
    lsof
    helvum
    vscode
    wine-staging
    winetricks
    asciinema
  ];

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
        verbose = true;
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
      plugins = with pkgs.obs-studio-plugins; [ wlrobs ];
    };
    ### Password store
    password-store = { enable = true; };
    ### Mako
    mako = {
      enable = true;
      font = "小赖字体 SC 20";
    };
    ### Swaylock
    swaylock.settings = {
      image =
        "${config.home.homeDirectory}/Downloads/phantom_thieves_of_hearts_by_necrocainalx_ded7kks.png";
      indicator-caps-lock = true;
      show-keyboard-layout = true;
      indicator-idle-visible = true;
      font = "Iosevka Extended";
      font-size = 24;
      indicator-radius = 100;
      indicator-thickness = 20;
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
      pinentryFlavor = "gnome3";
    };
    ### Emacs Daemon
    emacs = {
      enable = true;
      client.enable = false; # Emacs now includes the client desktop file.
      package = pkgs.emacsPgtk;
      socketActivation.enable = true;
    };
    ### EasyEffects
    easyeffects = { enable = true; };
    ### Swayidle
    swayidle = {
      enable = true;
      events = with pkgs; [
        {
          event = "before-sleep";
          command = "${swaylock}/bin/swaylock";
        }
        {
          event = "lock";
          command = "${swaylock}/bin/swaylock";
        }
      ];
    };
  };
  ###### End of service configs.

  # Session variables for Systemd user units.
  systemd.user.sessionVariables = {
    LESSHISTFILE = "-";
    GST_VAAPI_ALL_DRIVERS = "1";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    # Wayland
    QT_QPA_PLATFORM = "wayland";
    CLUTTER_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    # Fcitx 5
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    # Inherits from home.sessionVariables
    PASSWORD_STORE_DIR = config.home.sessionVariables.PASSWORD_STORE_DIR;
    GNUPGHOME = config.home.sessionVariables.GNUPGHOME;
  };

  home.sessionVariables = { LANG = "zh_CN.UTF-8"; };

}
