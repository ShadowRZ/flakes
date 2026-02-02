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
              numix-icon-theme-circle
              numix-icon-theme-square
            ];
          };

          services.gvfs.enable = true;

          users.users.shadowrz = {
            packages = with pkgs; [
              fractal
              blender-bin.blender_5_0 # Blender 5.0.* (Binary)
              helvum
              gimp3 # GIMP 3
              inkscape # Inkscape
              d-spy # D-Spy
              libreoffice-fresh # LibreOffice Fresh
              android-studio
              mindustry-wayland
              godot
              featherpad
              sqlitebrowser
              pdfarranger
              telegram-desktop
              pika-backup
              mkxp-z
              ## KDE Packages
              krusader
              #kdePackages.kdenlive
              kdePackages.kcalc
              kdePackages.kcharselect
              kdePackages.plasma-sdk # Plasma SDK
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
