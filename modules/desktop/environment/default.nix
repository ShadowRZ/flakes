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
              tela-icon-theme
              pkgs.gparted
            ];
          };

          services = {
            xserver = {
              enable = true;
              excludePackages = [ pkgs.xterm ];
            };
            gvfs.enable = true;
          };

          users.users.shadowrz = {
            packages = with pkgs; [
              fractal
              keepassxc
              blender_4_4 # Blender 4.4.* (Binary)
              helvum
              blanket
              gimp3 # GIMP 3
              inkscape # Inkscape
              d-spy # D-Spy
              libreoffice-fresh # LibreOffice Fresh
              android-studio
              featherpad
              sqlitebrowser
              pdfarranger
              thunderbird-latest
              plasma-overdose-kde-theme
              eclipses.eclipse-platform
              zed-editor
              telegram-desktop
              pika-backup
              github-desktop
              ## KDE Packages
              kdePackages.kdenlive
              kdePackages.kcalc
              kdePackages.kcharselect
              kdePackages.plasma-sdk # Plasma SDK
              kdePackages.kdevelop
              kdePackages.kleopatra
            ];
          };
        };
    };

    homeManager = {
      desktop = {
        systemd.user.sessionVariables.QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
        home.sessionVariables.QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
      };
    };
  };
}
