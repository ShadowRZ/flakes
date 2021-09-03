{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    glxinfo # GLX Info
    firefox # Firefox
    materia-theme # Materia GTK Theme
    ffmpeg-full # FFmpeg
    gnome-themes-extra # Extra GNOME themes like HighContrast
    imagemagick # ImageMagick
    papirus-icon-theme # Papirus
    qt5.qtgraphicaleffects # Qt Graphical Effects
    xsel # xsel clipboard tool
    lxqt.lximage-qt # LXImage-Qt
    lxqt.qps # Qps
    lxqt.lxqt-archiver # LXQt Archiver
    lxqt.pavucontrol-qt # Pavucontrol (Qt)
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
    # Virtualisation
    virt-viewer
    virt-manager
    # Qt 5 tools
    libsForQt5.full
    material-decoration
    # Others
    libreoffice # LibreOffice
    vlc # VLC
    mediainfo-gui # MediaInfo GUI
    # IM Clients
    element-desktop # Element Desktop
    nheko # Nheko
    ### Above are Matrix clients.
    tdesktop # Telegram Desktop
    hexchat # HexChat
    dino # Dino
  ];
}
