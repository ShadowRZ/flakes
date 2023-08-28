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
      displayManager = {
        # Plasma Wayland session works for me.
        defaultSession = "plasmawayland";
        sddm = {
          enable = true;
          settings = {
            General = {
              DisplayServer = "wayland";
              InputMethod = "";
            };
            # XXX: Using Weston for now till https://github.com/NixOS/nixpkgs/pull/242009
            Wayland.CompositorCommand = let
              xcfg = config.services.xserver;
              westonIni = (pkgs.formats.ini { }).generate "weston.ini" {
                libinput = {
                  enable-tap = xcfg.libinput.mouse.tapping;
                  left-handed = xcfg.libinput.mouse.leftHanded;
                };
                keyboard = {
                  keymap_model = xcfg.xkbModel;
                  keymap_layout = xcfg.layout;
                  keymap_variant = xcfg.xkbVariant;
                  keymap_options = xcfg.xkbOptions;
                };
              };
            in "${pkgs.weston}/bin/weston --shell=fullscreen-shell.so -c ${westonIni}";
          };
        };
      };
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
    liberation_ttf # Liberation Fonts
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
  ];

  environment.systemPackages = with pkgs; [
    intel-gpu-tools
    libva-utils
    # Graphical packages.
    ffmpeg-full # FFmpeg
    imagemagick # ImageMagick
    papirus-icon-theme # Papirus
    gimp # GIMP
    kolourpaint # KolourPaint
    photoflare # PhotoFlare
    inkscape # Inkscape
    d-spy # D-Spy
    pulseaudio # PulseAudio tools
    # Phinger Cursors
    phinger-cursors
    # Qt 5 tools
    libsForQt5.qttools.dev
    # Others
    libreoffice-fresh # LibreOffice Fresh (Newer)
    mediainfo-gui # MediaInfo GUI
    gnome.dconf-editor
    # GTK
    glxinfo
    clinfo
    vulkan-tools
    wayland-utils
    xorg.xdpyinfo
    wl-clipboard
    kdialog
    material-kwin-decoration # KWin material decoration
    celluloid
    adw-gtk3
    tokodon
    foliate
    gnome-builder
    geany
    vvave
    gitg
    libsForQt5.krecorder
    kcalc
    libsForQt5.kamoso
    config.nur.repos.shadowrz.klassy # Klassy
    # KDE PIM
    kontact
    kmail
    kaddressbook
    korganizer
    akregator
    merkuro
    # End KDE PIM
    konversation
    # Plasma themes
    plasma-overdose-kde-theme
    materia-kde-theme
    catppuccin-kde
    graphite-kde-theme
    colloid-kde
    # Qt Styles
    libsForQt5.qtstyleplugins
    libsForQt5.qtstyleplugin-kvantum # kvantummanager
    qt6Packages.qtstyleplugin-kvantum
  ];

  environment.variables.VK_ICD_FILENAMES =
    "${pkgs.mesa.drivers}/share/vulkan/icd.d/intel_icd.x86_64.json";

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

  # KDE Connect
  programs.kdeconnect.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;

  # Bluetooth
  hardware.bluetooth.enable = true;

  xdg.portal = {
    enable = true;
    # Enable GTK portal
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
