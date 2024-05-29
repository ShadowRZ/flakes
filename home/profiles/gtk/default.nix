{ config, ... }: {
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
      name = "Iosevka Aile Minoko SmEx";
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

  systemd.user.sessionVariables.GTK2_RC_FILES =
    config.home.sessionVariables.GTK2_RC_FILES;
}
