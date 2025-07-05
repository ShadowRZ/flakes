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
              theme = pkgs.silent-sddm-customized.pname;
              extraPackages = pkgs.silent-sddm-customized.propagatedBuildInputs;
              settings = {
                General = {
                  GreeterEnvironment = "QML2_IMPORT_PATH=${pkgs.silent-sddm-customized}/share/sddm/themes/${pkgs.silent-sddm-customized.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard,QT_SCALE_FACTOR=1.25,QT_FONT_DPI=96";
                  InputMethod = "qtvirtualkeyboard";
                };
              };
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
            pkgs.silent-sddm-customized
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
