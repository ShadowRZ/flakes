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
              fluent-icon-theme
              numix-icon-theme-circle
              numix-icon-theme-square
            ];
          };

          services.gvfs.enable = true;

          users.users.shadowrz = {
            packages = with pkgs; [
              # keep-sorted start
              android-studio
              blender_5_0 # Blender 5.0.* (Binary)
              d-spy # D-Spy
              featherpad
              fractal
              gimp3 # GIMP 3
              inkscape # Inkscape
              kdePackages.kcalc
              kdePackages.kcharselect
              kdePackages.kdenlive
              kdePackages.plasma-sdk # Plasma SDK
              ## KDE Packages
              krusader
              libreoffice-fresh # LibreOffice Fresh
              pdfarranger
              pika-backup
              qpwgraph
              sqlitebrowser
              # keep-sorted end
            ];
          };
        };
    };

    homeManager = {
      desktop = _: {
        systemd.user.sessionVariables.QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
        home.sessionVariables.QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
      };
      gnupg =
        { pkgs, ... }:
        {
          services.gpg-agent.pinentry.package = pkgs.pinentry-qt;
        };
    };
  };
}
