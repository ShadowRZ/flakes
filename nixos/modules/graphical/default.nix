{ pkgs, lib, ... }: {
  services = {
    upower.enable = true;
    dbus = {
      enable = true;
      packages = with pkgs; [ dconf gcr ];
    };
    xserver = {
      enable = true;
      # SDDM
      displayManager.sddm = {
        enable = true;
        settings = {
          General = {
            background = "${pkgs.nixos-artwork.wallpapers.nineish}/share/backgrounds/nixos/nix-wallpaper-nineish.png";
          };
        };
      };
      desktopManager.plasma5 = {
        enable = true;
        runUsingSystemd = true;
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
    gvfs = { enable = true; };
  };
  # rtkit
  security.rtkit.enable = true;

  # Fonts.
  fonts.fonts = with pkgs; [
    roboto # Roboto
    roboto-slab # Roboto Slab
    ibm-plex # IBM Plex
    iosevka-bin # Iosevka
    _3270font # Fonts of IBM 3270
    noto-fonts # Base Noto Fonts
    noto-fonts-cjk # CJK Noto Fonts
    noto-fonts-extra # Extra Noto Fonts
    noto-fonts-emoji # Noto Color Emoji
    sarasa-gothic # Sarasa Gothic
    # Iosevka Aile + Iosevka Etoile
    (iosevka-bin.override { variant = "aile"; })
    (iosevka-bin.override { variant = "etoile"; })
  ];

  environment.systemPackages = with pkgs; [
    # VA-API.
    intel-gpu-tools
    libva-utils
    # Graphical packages.
    arc-theme # Arc theme
    ffmpeg-full # FFmpeg
    imagemagick # ImageMagick
    papirus-icon-theme # Papirus
    gimp # GIMP
    inkscape # Inkscape
    dfeet # D-Feet
    pulseaudio # PulseAudio tools
    # Phinger Cursors
    phinger-cursors
    # Nordic
    nordic
    # Qt 5 tools
    libsForQt5.full
    # Others
    libreoffice # LibreOffice
    mediainfo-gui # MediaInfo GUI
    # IM Clients
    element-desktop # Element Desktop
    ### Above are Matrix clients.
    hexchat # HexChat
    dino # Dino
    # GTK
    gtk3.dev
    gtk4.dev
    vlc
    glxinfo
    vulkan-tools
    wayland-utils
    wl-clipboard
    renpy
    kdialog
    kdeconnect # KDE Connect
    material-kwin-decoration # KWin material decoration
    qtcurve
    libsForQt5.lightly
    nixos-artwork.wallpapers.nineish # NixOS wallpaper
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ vaapiIntel beignet intel-ocl ];
  };

  xdg.portal.enable = true;
}
