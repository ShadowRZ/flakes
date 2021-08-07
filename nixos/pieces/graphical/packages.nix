{ pkgs, ... }:

{
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
    lxqt.lximage-qt # LXImage-Qt
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
    libreoffice
    vlc
    ark
    # IM Clients
    element-desktop
    tdesktop
    hexchat
    dino
  ];

  # SpaceFM
  programs.spacefm = {
    enable = true;
  };
}
