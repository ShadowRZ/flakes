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
      # LightDM
      displayManager.lightdm = {
        enable = true;
        # GTK Greeter
        greeters.gtk = {
          enable = true;
          clock-format = "%H:%M:%S";
          cursorTheme = {
            name = "Bibata-Modern-Amber";
            package = pkgs.bibata-cursors;
            size = 24;
          };
          iconTheme = {
            name = "Papirus";
            package = pkgs.papirus-icon-theme;
          };
          theme = {
            name = "adw-gtk3";
            package = pkgs.adw-gtk3;
          };
        };
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
    # VA-API.
    vaapiIntel
    intel-gpu-tools
    libva-utils
    # Graphical packages.
    ardour # Ardour
    sonic-visualiser # Sonic Visualiser
    firefox # Firefox
    materia-theme # Materia GTK Theme
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
    # Bibata
    bibata-cursors
    bibata-extra-cursors
    bibata-cursors-translucent
    # Qt 5 tools
    libsForQt5.full
    # Others
    libreoffice # LibreOffice
    vlc # VLC
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
    xfce.orage
    xfce.parole
    xfce.ristretto
    xfce.xfce4-appfinder
    synapse
  ];

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [ vaapiIntel ];
  hardware.opengl.extraPackages32 = with pkgs; [ vaapiIntel ];

  # Wayland programs.
  programs = {
    hikari.enable = true;
    spacefm = {
      enable = true;
      settings = {
        tmp_dir = "/tmp";
        terminal_su = "${pkgs.sudo}/bin/sudo";
      };
    };
  };

}
