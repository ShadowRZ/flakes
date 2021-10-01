{ config, pkgs, ... }: {
  imports = [ ./profiles/git ./profiles/neovim ./profiles/shell ];

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

  # Packages.
  home.packages = with pkgs; [
    # KDE Connect (started by Plasma systemd startup)
    kdeconnect
  ];

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
      gitProtocol = "ssh";
    };
    ### mpv
    mpv = {
      enable = true;
      config = {
        # OSD configs.
        osd-font = "等距更纱黑体 Slab SC";
        osd-font-size = 40;
        osd-on-seek = "msg-bar";

        # Enable builtin OSC
        osc = true;
        script-opts = "osc-vidscale=false,osc-bar=true,osc-layout=silmbox";

        # Subtitles.
        sub-align-x = "right";
        sub-font-size = 45;
        sub-justify = "auto";
        sub-font = "等距更纱黑体 Slab SC";
        sub-border-size = 3;
        sub-color = "#DE8148";
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
      plugins = with pkgs.obs-studio-plugins; [ obs-gstreamer ];
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
    ### Emacs Daemon
    emacs = {
      enable = true;
      socketActivation.enable = true;
    };
    ### FluidSynth
    fluidsynth = {
      enable = true;
      soundService = "pipewire-pulse";
    };
    ### EasyEffects
    easyeffects = { enable = true; };
  };
  ###### End of service configs.

  # Session variables.
  systemd.user.sessionVariables = {
    LESSHISTFILE = "-";
    GST_VAAPI_ALL_DRIVERS = "1";
    MOZ_X11_EGL = "1";
  };

  # Fcitx 5
  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-chinese-addons
        fcitx5-pinyin-moegirl
        fcitx5-pinyin-zhwiki
      ];
    };
  };
}