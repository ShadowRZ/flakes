{ pkgs, ... }: {
  services = {
    upower.enable = true;
    dbus = {
      enable = true;
      packages = with pkgs; [ dconf ];
    };
    # X11 Server
    xserver = {
      enable = true;
      # Configure keymap in X11
      layout = "us";
      libinput.enable = true;
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
  };
  # rtkit
  security.rtkit.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

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
    wayfire # Wayfire
    # VA-API.
    vaapiIntel
    intel-gpu-tools
    libva-utils
    # Graphical packages.
    ardour # Ardour
    sonic-visualiser # Sonic Visualiser
    glxinfo # GLX Info
    firefox # Firefox
    materia-theme # Materia GTK Theme
    ffmpeg-full # FFmpeg
    gnome-themes-extra # Extra GNOME themes like HighContrast
    imagemagick # ImageMagick
    papirus-icon-theme # Papirus
    qt5.qtgraphicaleffects # Qt Graphical Effects
    qt5.qtwayland # Qt Wayland
    xsel # xsel clipboard tool
    ark # Ark
    feh # Feh
    gimp # GIMP
    inkscape # Inkscape
    dfeet # D-Feet
    smplayer # SMPlayer
    avidemux # Avidemux
    emacs # Emacs
    kate # Kate / KWrite
    # Bibata
    bibata-cursors
    bibata-extra-cursors
    bibata-cursors-translucent
    # Qt 5 tools
    libsForQt5.full
    # KWin Material Decoration
    material-kwin-decoration
    # Others
    libreoffice # LibreOffice
    vlc # VLC
    lightly-qt # Lightly Qt theme
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
  ];

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [ vaapiIntel ];
  hardware.opengl.extraPackages32 = with pkgs; [ vaapiIntel ];

  # Wayland programs.
  programs = {
    wayfire.enable = true;
    waybar.enable = true;
  };

}
