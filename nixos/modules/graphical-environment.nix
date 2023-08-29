{ config, pkgs, lib, ... }: {

  imports = [ ./overrides/sddm-breeze-background.nix ];

  services = {
    upower.enable = true;
    dbus = {
      enable = true;
      packages = with pkgs; [ dconf gcr ];
    };
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
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

  # Fonts.
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      liberation_ttf # Liberation Fonts
      iosevka # Iosevka (Source Build)
      noto-fonts # Base Noto Fonts
      noto-fonts-cjk # CJK Noto Fonts
      noto-fonts-cjk-serif # Noto Serif CJK
      noto-fonts-extra # Extra Noto Fonts
      noto-fonts-emoji # Noto Color Emoji
      sarasa-gothic # Sarasa Gothic
      # Iosevka Aile + Iosevka Etoile
      (iosevka-bin.override { variant = "aile"; })
      (iosevka-bin.override { variant = "etoile"; })
      jost # Jost
    ];
    fontconfig.defaultFonts = lib.mkForce {
      serif = [ "Noto Serif" "Noto Serif CJK SC" ];
      sansSerif = [ "Noto Sans" "Noto Sans CJK SC" ];
      monospace = [ "Iosevka Extended" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  environment.systemPackages = with pkgs; [
    # Graphical packages.
    papirus-icon-theme # Papirus
    gimp # GIMP
    inkscape # Inkscape
    d-spy # D-Spy
    # Phinger Cursors
    phinger-cursors
    # Qt 5 tools
    libsForQt5.qttools.dev
    # Others
    material-kwin-decoration # KWin material decoration
    celluloid
    adw-gtk3
    libsForQt5.krecorder
    kcalc
    # Plasma themes
    plasma-overdose-kde-theme
    graphite-kde-theme
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
