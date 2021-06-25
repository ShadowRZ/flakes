{ pkgs, ... }:

{
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [ vaapiIntel ];
  hardware.opengl.extraPackages32 = with pkgs; [ vaapiIntel ];
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [
    glxinfo
    firefox
    materia-theme
    ffmpeg-full
    gnome-themes-extra
    imagemagick
    libsForQt5.qtstyleplugins
    papirus-icon-theme
    qt5.qtgraphicaleffects
    xsel
    okular
    lxqt.lximage-qt
    krusader
    kinfocenter
    plasma-vault
    electron
    gimp
    inkscape
    dfeet
    mpv
    smplayer
    qmmp
    avidemux
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
    kgpg
    plasma-systemmonitor
    libreoffice
    vlc
    wine
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

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
