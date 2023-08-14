{ config, pkgs, lib, ... }: {

  imports = [ ./sddm-breeze-background.nix ./nvidia.nix ];

  services = {
    upower.enable = true;
    dbus = {
      enable = true;
      packages = with pkgs; [ dconf gcr ];
    };
    xserver = {
      enable = true;
      # SDDM
      displayManager.sddm.enable = true;
      desktopManager.plasma5 = {
        enable = true;
        runUsingSystemd = true;
      };
    };
    # GVFS
    gvfs = { enable = true; };
    # Pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      jack.enable = true;
    };
    # Printing
    printing.enable = true;
  };
  # rtkit
  security.rtkit.enable = true;

  # Fonts.
  fonts.packages = with pkgs; [
    roboto # Roboto
    roboto-slab # Roboto Slab
    iosevka # Iosevka (Source Build)
    _3270font # Fonts of IBM 3270
    noto-fonts # Base Noto Fonts
    noto-fonts-cjk # CJK Noto Fonts
    noto-fonts-extra # Extra Noto Fonts
    noto-fonts-emoji # Noto Color Emoji
    sarasa-gothic # Sarasa Gothic
    # Iosevka Aile + Iosevka Etoile
    (iosevka-bin.override { variant = "aile"; })
    (iosevka-bin.override { variant = "etoile"; })
    jost # Jost
    material-icons # Material Icons
    material-design-icons
  ];

  environment.systemPackages = with pkgs; [
    intel-gpu-tools
    libva-utils
    # Graphical packages.
    arc-theme # Arc theme
    ffmpeg-full # FFmpeg
    imagemagick # ImageMagick
    papirus-icon-theme # Papirus
    gimp # GIMP
    kolourpaint # KolourPaint
    photoflare # PhotoFlare
    inkscape # Inkscape
    dfeet # D-Feet
    pulseaudio # PulseAudio tools
    # Phinger Cursors
    phinger-cursors
    # Nordic
    nordic
    # Qt 5 tools
    libsForQt5.qttools
    # Others
    libreoffice-fresh # LibreOffice Fresh (Newer)
    mediainfo-gui # MediaInfo GUI
    kdeconnect # KDE Connect
    # GTK
    gtk3.dev
    gtk4.dev
    glxinfo
    clinfo
    vulkan-tools
    wayland-utils
    xorg.xdpyinfo
    wl-clipboard
    kdialog
    material-kwin-decoration # KWin material decoration
    celluloid
    config.nur.repos.shadowrz.klassy # Klassy
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      intel-compute-runtime
    ];
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;

  # Bluetooth
  hardware.bluetooth.enable = true;

  xdg.portal.enable = true;
}
