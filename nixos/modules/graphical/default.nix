{ pkgs, lib, ... }: {
  services = {
    upower.enable = true;
    dbus = {
      enable = true;
      packages = with pkgs; [ dconf gcr gnome.nautilus ];
    };
    xserver = {
      enable = true;
      # GDM
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      # Modesettings driver
      videoDrivers = [ "modesettings" ];
    };
    # PipeWire
    pipewire = {
      enable = true;
      # ALSA
      alsa.enable = true;
      # PulseAudio
      pulse.enable = true;
      # JACK
      jack.enable = true;
    };
    # GVFS
    gvfs = {
      enable = true;
    };
  };
  # rtkit
  security.rtkit.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-pinyin-moegirl
      fcitx5-pinyin-zhwiki
    ];
  };

  # Fonts.
  fonts.fonts = with pkgs; [
    roboto # Roboto
    roboto-slab # Roboto Slab
    ibm-plex # IBM Plex
    iosevka # Iosevka
    _3270font # Fonts of IBM 3270
    noto-fonts # Base Noto Fonts
    noto-fonts-cjk # CJK Noto Fonts
    noto-fonts-extra # Extra Noto Fonts
    noto-fonts-emoji # Noto Color Emoji
    sarasa-gothic # Sarasa Gothic
  ];

  systemd.services.upower.enable = true;

  environment.systemPackages = with pkgs; [
    # VA-API.
    vaapiIntel
    intel-gpu-tools
    libva-utils
    # Graphical packages.
    ardour # Ardour
    sonic-visualiser # Sonic Visualiser
    firefox # Firefox
    materia-theme # Materia GTK Theme
    arc-theme # Arc theme
    ffmpeg-full # FFmpeg
    gnome-themes-extra # Extra GNOME themes like HighContrast
    imagemagick # ImageMagick
    papirus-icon-theme # Papirus
    qt5.qtgraphicaleffects # Qt Graphical Effects
    qt5.qtwayland # Qt Wayland
    gimp # GIMP
    inkscape # Inkscape
    dfeet # D-Feet
    smplayer # SMPlayer
    avidemux # Avidemux
    emacsPgtk # Emacs with Pure GTK.
    rhythmbox # Rhythmbox
    # Bibata
    bibata-cursors
    bibata-extra-cursors
    bibata-cursors-translucent
    # Qt 5 tools
    libsForQt5.full
    # Others
    libreoffice # LibreOffice
    mediainfo-gui # MediaInfo GUI
    # IM Clients
    element-desktop # Element Desktop
    nheko # Nheko
    ### Above are Matrix clients.
    hexchat # HexChat
    dino # Dino
    # GTK
    gtk3.dev
    gtk4.dev
    # Others
    xfce.mousepad
    xfce.xfce4-appfinder
    gnome.nautilus
    imv
    celluloid
    waybar
    # Polkit daemon
    polkit_gnome
  ];

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [ vaapiIntel ];
  hardware.opengl.extraPackages32 = with pkgs; [ vaapiIntel ];

  # Wayland programs.
  programs = {
    wayfire.enable = true;
    gnome-terminal.enable = true;
  };
}
