{ config, pkgs, lib, ... }: {

  home-manager.users.shadowrz = import ./home;

  environment = {
    systemPackages = with pkgs; [
      adw-gtk3
      # wl-clipboard
      wl-clipboard
      # Used to configure SDDM Breeze Theme
      (writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
        [General]
        background=${nixos-artwork.wallpapers.nineish}/share/backgrounds/nixos/nix-wallpaper-nineish.png
      '')
      # Graphical packages.
      papirus-icon-theme # Papirus
      graphite-cursors
    ];
  };

  i18n = {
    # Fcitx 5
    inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        plasma6Support = true;
        waylandFrontend = true;
        addons = with pkgs; [
          kdePackages.fcitx5-chinese-addons
          fcitx5-pinyin-moegirl
          fcitx5-pinyin-zhwiki
        ];
      };
    };
  };

  services = {
    displayManager = {
      # SDDM
      sddm = {
        enable = true;
        settings = {
          General.GreeterEnvironment = "QT_SCALE_FACTOR=1.25,QT_FONT_DPI=96";
          Theme = {
            Font = "Cantarell";
            CursorTheme = "graphite-light";
            CursorSize = 24;
          };
        };
        wayland.enable = true;
      };
    };
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
    };
    # Pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      jack.enable = true;
    };
    gvfs.enable = true;
  };

  hardware = {
    pulseaudio.enable = false;
    # Bluetooth
    bluetooth.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  # Enable sounds
  sound.enable = true;

  xdg.portal = {
    enable = true;
    # Enable GTK portal
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.dconf.enable = true;

  # Fonts.
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      noto-fonts # Base Noto Fonts
      noto-fonts-color-emoji # Noto Color Emoji
      sarasa-gothic # Sarasa Gothic
      source-han-sans-vf-otf # Source Han Sans Variable
      source-han-serif-vf-otf # Source Han Serif Variable
      dejavu_fonts # DejaVu
      cantarell-fonts # Cantarell
      config.nur.repos.shadowrz.maoken-assorted-sans
      config.nur.repos.shadowrz.resource-han-rounded
      # Iosevka Builds
      config.nur.repos.shadowrz.iosevka-minoko
      config.nur.repos.shadowrz.iosevka-minoko-term
      config.nur.repos.shadowrz.iosevka-aile-minoko
      config.nur.repos.shadowrz.iosevka-minoko-e
    ];
    fontconfig = {
      defaultFonts = lib.mkForce {
        # XXX: Qt solely uses the first 255 fonts from fontconfig:
        # https://bugreports.qt.io/browse/QTBUG-80434
        # So put emoji font here.
        sansSerif =
          [ "DejaVu Sans" "Source Han Sans SC VF" "Noto Color Emoji" ];
        serif = [ "DejaVu Serif" "Source Han Serif SC VF" "Noto Color Emoji" ];
        monospace = [ "Iosevka Minoko-E" "Sarasa Mono SC" ];
        emoji = [ "Noto Color Emoji" ];
      };
      subpixel.rgba = "rgb";
      localConf = builtins.readFile ./fontconfig.conf;
      cache32Bit = true;
    };
  };
}
