{ pkgs, lib, ... }: {
  services.desktopManager.plasma6 = {
    enable = true;
    enableQt5Integration = true;
  };

  environment = {
    systemPackages = [ pkgs.klassy-qt6 ];
    plasma6.excludePackages = with pkgs; [ konsole khelpcenter ];
  };

  # KDE Connect
  programs.kdeconnect.enable = true;

  # Kill generated Systemd service for Fcitx 5
  # Required to make sure KWin can bring a Fcitx 5 up to support Wayland IME protocol
  systemd.user.services.fcitx5-daemon = lib.mkForce { };

  home-manager.sharedModules = [{
    systemd.user.services."app-org.fcitx.Fcitx5@autostart" = lib.mkForce { };
  }];
}
