{
  config,
  pkgs,
  lib,
  ...
}:
{

  boot = lib.mkMerge [
    # Enable Plymouth by default
    {
      plymouth = {
        enable = lib.mkDefault true;
        theme = "bgrt";
      };
    }
    # Enable silent boot if Plymouth is enabled
    (lib.mkIf config.boot.plymouth.enable {
      kernelParams = lib.mkAfter [
        "quiet"
        "udev.log_priority=3"
        "vt.global_cursor_default=0"
      ];
      initrd.verbose = false;
      consoleLogLevel = 0;
    })
  ];

  environment = {
    systemPackages = with pkgs; [
      adw-gtk3
      wl-clipboard
    ];
  };

  services = {
    pulseaudio.enable = false;
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

  security.rtkit.enable = true;

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
        fonts = [
          "Space Grotesk"
          "Outfit"
        ];
      })
      nerd-fonts.symbols-only
      (iosevka-bin.override {
        variant = "Aile";
      })
      # Iosevka Builds
      iosevka-aile-minoko
      iosevka-minoko
      iosevka-minoko-term
      iosevka-minoko-e
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
