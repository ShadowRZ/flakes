{
  flake.modules.nixos = {
    plasma-desktop =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        services = {
          desktopManager.plasma6 = {
            enable = true;
            enableQt5Integration = true;
          };
          displayManager = {
            # SDDM
            sddm = {
              enable = true;
              wayland.enable = true;
            };
          };
        };

        environment = {
          systemPackages = with pkgs; [
            plasma-panel-colorizer
            klassy-qt6
            aha # aha
            clinfo # clinfo
            mesa-demos # glxinfo, eglinfo
            vulkan-tools # vulkaninfo
            wayland-utils # wayland-info
            rose-pine-cursor
            # Used to configure SDDM Breeze Theme
            (writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
              [General]
              background=${nixos-artwork.wallpapers.nineish}/share/backgrounds/nixos/nix-wallpaper-nineish.png
            '')
          ];
          plasma6.excludePackages = with pkgs; [
            kdePackages.konsole
            kdePackages.khelpcenter
          ];
        };

        # KDE Connect
        programs.kdeconnect.enable = true;

        programs.kde-pim.enable = false;

        # Kill generated Systemd service for Fcitx 5
        # Required to make sure KWin can bring a Fcitx 5 up to support Wayland IME protocol
        systemd.user.services.fcitx5-daemon = lib.mkIf (config.i18n.inputMethod.type == "fcitx5") (
          lib.mkForce { }
        );

        home-manager.sharedModules = lib.mkIf (config.i18n.inputMethod.type == "fcitx5") [
          (_: {
            systemd.user.services."app-org.fcitx.Fcitx5@autostart" = lib.mkForce { };
          })
        ];
      };
  };
}
