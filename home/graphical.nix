{ config, pkgs, lib, ... }: {
  programs = {
    ### Wezterm
    wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./files/wezterm.lua;
    };
    ### OBS
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [ wlrobs ];
    };
    ### mpv
    mpv = {
      enable = true;
      config = {
        # OSD configs.
        osd-font = "Iosevka Aile Minoko";
        osd-font-size = 40;
        osd-on-seek = "msg-bar";

        # Enable builtin OSC
        osc = true;

        # Subtitles.
        sub-align-x = "right";
        sub-font-size = 45;
        sub-justify = "auto";
        sub-font = "Iosevka Aile Minoko";
        sub-border-size = 3;
        sub-color = "#DE8148";

        # Prefer hardware decoding.
        hwdec = "vulkan,vaapi";

        gpu-hwdec-interop = "vaapi";
        vo = "gpu-next";
        tone-mapping = "auto";
        af = "dynaudnorm=g=45:p=0.5:m=1:s=0";
        hwdec-codecs = "all";
        sub-auto = "fuzzy";
        vd-lavc-dr = "yes";
        replaygain = "album";
        gpu-api = "vulkan";
        native-keyrepeat = true;
      };
      scriptOpts = {
        osc = {
          scalewindowed = 1.5;
          scalefullscreen = 1.5;
          vidscale = false;
          visibility = "always";
          seekbarstyle = "knob";
          seekrangestyle = "slider";
        };
        console = {
          font = "Iosevka Minoko";
          font_size = 22;
        };
        stats = {
          font = "Iosevka Aile Minoko";
          font_mono = "Iosevka Minoko";
        };
      };
      scripts = with pkgs.mpvScripts; [ mpris ];
    };
  };

  # Enable a Qt pinentry
  services.gpg-agent.pinentryPackage = lib.mkForce pkgs.pinentry-qt;

  # Fontconfig.
  fonts.fontconfig.enable = true;
  xdg.configFile = {
    "fontconfig/conf.d/99-fontconfig.conf".source = ./files/fontconfig.conf;
  };

  gtk = let
    gtkIni = {
      gtk-application-prefer-dark-theme = false;
      gtk-decoration-layout = "icon,menu:minimize,maximize,close";
      gtk-enable-animations = true;
      gtk-primary-button-warps-slider = true;
      gtk-sound-theme-name = "ocean";
    };
  in {
    enable = true;
    cursorTheme = {
      name = "graphite-light";
      size = 32;
    };
    font = {
      name = "Montserrat Alternates";
      size = 12;
    };
    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      extraConfig = ''
        gtk-can-change-accels = 1
        gtk-sound-theme-name = "ocean"
        gtk-enable-animations = 1
        gtk-primary-button-warps-slider = 1
        gtk-toolbar-style = 3
        gtk-menu-images = 1
        gtk-button-images = 1
      '';
    };
    gtk3.extraConfig = gtkIni;
    gtk4.extraConfig = gtkIni;
    iconTheme = { name = "klassy"; };
    theme = { name = "adw-gtk3"; };
  };

  # Dconf
  dconf.settings = {
    "io/github/celluloid-player/celluloid" = {
      always-show-title-buttons = false;
      csd-enable = false;
      mpv-config-enable = true;
      mpv-config-file = "file:///${./files/celluloid.options}";
    };
  };

  systemd.user = {
    sessionVariables = {
      GTK2_RC_FILES = config.home.sessionVariables.GTK2_RC_FILES;
    };
  };
}
