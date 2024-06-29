{
  config,
  pkgs,
  lib,
  ...
}: {
  services.desktopManager.plasma6 = {
    enable = true;
    enableQt5Integration = true;
  };

  environment = {
    systemPackages = with pkgs; [
      config.nur.repos.shadowrz.klassy-qt6
      aha # aha
      clinfo # clinfo
      mesa-demos # glxinfo, eglinfo
      vulkan-tools # vulkaninfo
      wayland-utils # wayland-info
      kdePackages.krecorder
      (catppuccin-kde.override {
        flavour = ["mocha" "macchiato" "frappe" "latte"];
        accents = [
          "rosewater"
          "pink"
          "red"
          "yellow"
          "green"
          "teal"
          "sky"
          "sapphire"
          "blue"
          "lavender"
        ];
      })
    ];
    plasma6.excludePackages = with pkgs; [konsole khelpcenter];
  };

  # KDE Connect
  programs.kdeconnect.enable = true;

  # Kill generated Systemd service for Fcitx 5
  # Required to make sure KWin can bring a Fcitx 5 up to support Wayland IME protocol
  systemd.user.services.fcitx5-daemon = lib.mkForce {};

  home-manager.sharedModules = [
    ({config, ...}: {
      systemd.user.services."app-org.fcitx.Fcitx5@autostart" = lib.mkForce {};

      # Fix some HiDPI problems with QtWebEngine
      home.sessionVariables.QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
      systemd.user.sessionVariables.QT_SCALE_FACTOR_ROUNDING_POLICY = config.home.sessionVariables.QT_SCALE_FACTOR_ROUNDING_POLICY;
    })
  ];
}
