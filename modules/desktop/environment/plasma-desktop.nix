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
            # Plasma Login Manager
            plasma-login-manager = {
              enable = true;
              settings = {
                Greeter.Wallpaper = {
                  "org.kde.image" = {
                    General.Image = "file://${pkgs.nixos-artwork.wallpapers.nineish.src}";
                  };
                };
              };
            };
          };
        };

        environment = {
          systemPackages = with pkgs; [
            plasma-panel-colorizer
            klassy
            aha # aha
            clinfo # clinfo
            mesa-demos # glxinfo, eglinfo
            vulkan-tools # vulkaninfo
            wayland-utils # wayland-info
            bibata-cursors
            plasma-overdose-kde-theme
            haruna
            pkgs.shadowrz.silent-sddm
            (catppuccin-kde.override {
              flavour = [
                "latte"
                "mocha"
              ];
              accents = [
                "rosewater"
                "pink"
                "lavender"
              ];
            })
          ];
          plasma6.excludePackages = with pkgs; [
            kdePackages.discover
            kdePackages.elisa
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
