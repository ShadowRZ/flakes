{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      hardware.graphics.enable = true;

      environment = {
        systemPackages = with pkgs; [
          adw-gtk3
          wl-clipboard
          numix-icon-theme-circle
        ];
      };

      services.gvfs.enable = true;

      users.users.shadowrz = {
        packages = with pkgs; [
          # keep-sorted start
          d-spy # D-Spy
          fractal
          gimp3 # GIMP 3
          godot_4
          inkscape # Inkscape
          nix-kotone.blender-bin.blender_5_1 # Blender 5.1.* (Binary)
          obsidian
          onlyoffice-desktopeditors # ONLYOFFICE Desktop editors
          pika-backup
          quodlibet-full
          ungoogled-chromium
          # keep-sorted end
        ];
      };

      hanekokoro.nixos.allowedUnfreePredicates = [ "obsidian" ];

      hanekokoro.nixos.preservation.user.directories = [
        {
          directory = ".ssh";
          mode = "0700";
        }

        # keep-sorted start
        ".config/GIMP"
        ".config/blender"
        ".config/borg"
        ".config/chromium"
        ".config/dconf"
        ".config/godot"
        ".config/inkscape"
        ".config/obsidian"
        ".config/onlyoffice"
        ".config/pika-backup"
        ".config/quodlibet"
        ".local/share/applications"
        ".local/share/fonts"
        ".local/share/fractal"
        ".local/share/godot"
        ".local/share/onlyoffice"
        ".local/share/pki"
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Projects"
        "Public"
        "Templates"
        "Videos"
        # keep-sorted end
      ];
    };

  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    {
      systemd.user.sessionVariables.QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
      home.sessionVariables.QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
      services.gpg-agent.pinentry.package = pkgs.pinentry-curses;

      xdg.userDirs = {
        enable = true;
        setSessionVariables = false;
      };
    };
}
