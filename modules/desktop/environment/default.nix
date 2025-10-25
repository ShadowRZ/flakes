{
  flake.modules = {
    nixos = {
      desktop =
        { pkgs, ... }:
        {
          hardware.graphics.enable = true;

          environment = {
            systemPackages = with pkgs; [
              adw-gtk3
              wl-clipboard
              papirus-icon-theme
              tela-icon-theme
            ];
          };

          services.gvfs.enable = true;

          users.users.shadowrz = {
            packages = with pkgs; [
              fractal
              blender_4_5 # Blender 4.5.* (Binary)
              helvum
              gimp3 # GIMP 3
              inkscape # Inkscape
              d-spy # D-Spy
              libreoffice-fresh # LibreOffice Fresh
              android-studio
              featherpad
              sqlitebrowser
              pdfarranger
              telegram-desktop
              pika-backup
              gparted
              ungoogled-chromium
              ## KDE Packages
              krusader
              kdePackages.kdenlive
              kdePackages.kcalc
              kdePackages.kcharselect
              kdePackages.plasma-sdk # Plasma SDK
              kdePackages.kdevelop
            ];
          };
        };
    };

    homeManager = {
      desktop = _: {
        systemd.user.sessionVariables.QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
        home.sessionVariables.QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
      };
    };
  };
}
