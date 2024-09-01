{
  config,
  pkgs,
  lib,
  ...
}:
{
  environment = {
    systemPackages = with pkgs; [
      adw-gtk3
      # wl-clipboard
      wl-clipboard
    ];
  };

  services = {
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

  # Clashes with system path
  users.users.shadowrz.packages = with pkgs; [ papirus-icon-theme ];

  i18n = {
    # Fcitx 5
    inputMethod = {
      enable = true;
      type = "fcitx5";
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

  hardware = {
    pulseaudio.enable = false;
    # Bluetooth
    bluetooth.enable = true;
    graphics.enable = true;
  };

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
      (google-fonts.override {
        fonts = [ "Space Grotesk" ];
      })
      (nerdfonts.override {
        fonts = [ "NerdFontsSymbolsOnly" ];
      })
      (iosevka-bin.override {
        variant = "Aile";
      })
      config.nur.repos.shadowrz.maoken-assorted-sans
      config.nur.repos.shadowrz.resource-han-rounded
      # Iosevka Builds
      config.nur.repos.shadowrz.iosevka-aile-minoko
      config.nur.repos.shadowrz.iosevka-minoko
      config.nur.repos.shadowrz.iosevka-minoko-term
      config.nur.repos.shadowrz.iosevka-minoko-e
    ];
    fontconfig = {
      defaultFonts = lib.mkForce {
        # XXX: Qt solely uses the first 255 fonts from fontconfig:
        # https://bugreports.qt.io/browse/QTBUG-80434
        # So put emoji font here.
        sansSerif = [
          "DejaVu Sans"
          "Source Han Sans SC VF"
          "Noto Color Emoji"
        ];
        serif = [
          "DejaVu Serif"
          "Source Han Serif SC VF"
          "Noto Color Emoji"
        ];
        monospace = [
          "Iosevka Minoko-E"
          "Sarasa Mono SC"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
      subpixel.rgba = "rgb";
      localConf = builtins.readFile ./fontconfig.conf;
      cache32Bit = true;
    };
  };
}
