{
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
      klassy-qt6
      kdePackages.qtstyleplugin-kvantum
      aha # aha
      clinfo # clinfo
      mesa-demos # glxinfo, eglinfo
      vulkan-tools # vulkaninfo
      wayland-utils # wayland-info
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
      (catppuccin-kvantum.override {
        variant = "Mocha";
        accent = "Pink";
      })
      (catppuccin-kvantum.override {
        variant = "Frappe";
        accent = "Pink";
      })
      (catppuccin-kvantum.override {
        variant = "Latte";
        accent = "Pink";
      })
      (catppuccin-kvantum.override {
        variant = "Macchiato";
        accent = "Pink";
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
    {
      systemd.user.services."app-org.fcitx.Fcitx5@autostart" = lib.mkForce {};
    }
  ];
}
