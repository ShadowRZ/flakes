{ pkgs, ... }:

{
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [ vaapiIntel ];
  hardware.opengl.extraPackages32 = with pkgs; [ vaapiIntel ];
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [
    glxinfo # GLX Info
    firefox # Firefox
    materia-theme # Materia GTK Theme
    ffmpeg-full # FFmpeg
    gnome-themes-extra
    imagemagick # ImageMagick
    libsForQt5.qtstyleplugins
    papirus-icon-theme # Papirus
    qt5.qtgraphicaleffects # Qt Graphical Effects
    xsel # xsel
    okular # Okular
    lxqt.lximage-qt # LXImage-Qt
    krusader # Krusader
    kinfocenter # Kinfocenter
    plasma-vault # Plasma Vault
    electron # Electron
    gimp # GIMP
    inkscape # Inkscape
    dfeet # D-Feet
    mpv # mpv
    smplayer # SMPlayer
    qmmp # QMMP
    avidemux # Avidemux
    # Emacs
    (pkgs.emacsUnstable.override {
      withGTK3 = true; # Use GTK+3
      withGTK2 = false; # Don't use GTK+2
    })
    # VA-API.
    vaapiIntel
    intel-gpu-tools
    libva-utils
    # Virtualisation
    virt-viewer
    virt-manager
    # Qt 5 tools
    libsForQt5.full
    material-decoration
    # Fcitx
    fcitx5-pinyin-moegirl
    fcitx5-pinyin-zhwiki
    # Others
    plasma-systemmonitor
    libreoffice
    vlc
    ark
    calibre
    # IM Clients
    element-desktop
    tdesktop
    hexchat
    dino
  ];

  services.xbanish.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager.sddm = { enable = true; };
    desktopManager.plasma5.enable = true;
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-chinese-addons ];
    };
  };

  # X11: Modesettings driver.
  services.xserver.videoDrivers = [ "modesettings" ];

  # Flatpak.
  services.flatpak.enable = true;
  xdg.portal.enable = true;

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
}
