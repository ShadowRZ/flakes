{ pkgs, lib, ... }: {
  services = {
    upower.enable = true;
    dbus = {
      enable = true;
      packages = with pkgs; [ dconf gcr gnome.nautilus polkit_gnome ];
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
    gvfs = { enable = true; };
    # GNOME Keyring
    gnome.gnome-keyring = { enable = true; };
    # Tumbler
    tumbler = { enable = true; };
  };
  # rtkit
  security.rtkit.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";

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
    font-awesome_6 # Font Awesome 6
  ];

  systemd.services.upower.enable = true;

  environment.systemPackages = with pkgs; [
    # VA-API.
    vaapiIntel
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
    lollypop # Lollypop
    pavucontrol # PulseAudio control
    pulseaudio # PulseAudio tools
    # Phinger Cursors
    phinger-cursors
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
    xfce.ristretto
    xfce.xfce4-appfinder
    gnome.nautilus
    celluloid # Celluloid
    tilix # Tilix
    # Wayland base toolsets
    grim
    slurp
    wlogout
    wlr-randr
    wl-clipboard
    wlogout
    swaybg
    swaylock
    (deadbeef-with-plugins.override {
      plugins = with deadbeefPlugins; [
        headerbar-gtk3
        mpris2
        statusnotifier
        lyricbar
      ];
    })
  ];

  # Basic PAM for swaylock
  security.pam.services.swaylock = { };
  # Auto unlock GNOME keyring
  security.pam.services.gdm.enableGnomeKeyring = true;

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.extraPackages = with pkgs; [ vaapiIntel ];

  programs = {
    # Wayland programs.
    wayfire.enable = true;
    qt5ct.enable = true;
    seahorse.enable = true;
  };

  systemd.user.services = {
    # Start GNOME Polkit password prompt.
    "polkit-gnome-authentication-agent-1" = {
      enable = true;
      description = "GNOME PolicyKit Authentication Agent";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig.ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    };
  };

  nixpkgs.overlays = [ (import ./wayfire-overlay.nix) ];
}
