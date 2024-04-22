{ config, pkgs, lib, ... }: {
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
    extraInit = ''
      # https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland#KDE_Plasma
      typeset +x GTK_IM_MODULE QT_IM_MODULE
      unset GTK_IM_MODULE QT_IM_MODULE
    '';
  };

  i18n = {
    # Fcitx 5
    inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        # Use Plasma 6
        plasma6Support = true;
        addons = with pkgs; [
          qt6Packages.fcitx5-chinese-addons
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
          General.GreeterEnvironment = "QT_SCALE_FACTOR=1.5,QT_FONT_DPI=96";
          Theme = {
            Font = "Recursive Sn Lnr St";
            CursorTheme = "graphite-light";
            CursorSize = 36;
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
    # Flatpak
    flatpak.enable = true;
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
      twitter-color-emoji # Twemoji
      sarasa-gothic # Sarasa Gothic
      source-han-sans-vf-otf # Source Han Sans Variable
      source-han-serif-vf-otf # Source Han Serif Variable
      jost # Jost
      dejavu_fonts # DejaVu
      recursive # Recursive fonts
      victor-mono
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
          [ "DejaVu Sans" "Source Han Sans SC VF" "Twitter Color Emoji" ];
        serif =
          [ "DejaVu Serif" "Source Han Serif SC VF" "Twitter Color Emoji" ];
        monospace = [ "Iosevka Minoko-E" "Sarasa Mono SC" ];
        emoji = [ "Twitter Color Emoji" ];
      };
      subpixel.rgba = "rgb";
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
          <!-- Add Sarasa Mono SC for Iosevka based fonts -->
          <match target="pattern">
            <test name="family" compare="contains">
              <string>Iosevka</string>
            </test>
            <edit binding="strong" mode="append" name="family">
              <string>Sarasa Mono SC</string>
            </edit>
          </match>
        </fontconfig>
      '';
      cache32Bit = true;
    };
  };
}
