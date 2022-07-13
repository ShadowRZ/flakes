{ config, pkgs, lib, ... }: {
  imports = [
    ./profiles/git
    ./profiles/neovim
    ./profiles/shell
    ./profiles/email
    ./profiles/firefox
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
    # Fcitx 5
    (fcitx5-with-addons.override {
      addons = [
        fcitx5-chinese-addons
        fcitx5-pinyin-moegirl
        fcitx5-pinyin-zhwiki
      ];
    })
    nur.repos.rycee.firefox-addons-generator
  ];

  i18n.inputMethod = {
    enabled = "fcitx5";
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
      plugins = with pkgs.obs-studio-plugins; [ wlrobs ];
    };
    ### Password store
    password-store = { enable = true; };
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
    ### EasyEffects
    easyeffects = { enable = true; };
  };
  ###### End of service configs.

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

  home.sessionVariables = {
    LANG = "zh_CN.UTF-8";
  };
}
