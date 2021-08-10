{ pkgs, ... }:

{
  services = {
    upower.enable = true;

    dbus = {
      enable = true;
      packages = with pkgs; [ gnome.dconf ];
    };

    xserver = {
      enable = true;
      # Configure keymap in X11
      layout = "us";
      libinput.enable = true;
      # SDDM
      displayManager.sddm = { enable = true; };
      # Plasma 5
      desktopManager.plasma5.enable = true;
      # Modesettings driver
      videoDrivers = [ "modesettings" ];
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Flatpak.
  services.flatpak.enable = true;
  xdg.portal.enable = true;

  # Fonts.
  fonts.fonts = with pkgs; [
    roboto # Roboto
    roboto-slab # Roboto Slab
    ibm-plex # IBM Plex
    iosevka # Iosevka
    _3270font # Fonts of IBM 3270
    noto-fonts # Base Noto Fonts
    noto-fonts-cjk # CJK Noto Fonts
    noto-fonts-extra # Extra Noto Fonts
    noto-fonts-emoji # Noto Color Emoji
    sarasa-gothic # Sarasa Gothic
  ];

  hardware.pulseaudio.enable = true;
  systemd.services.upower.enable = true;
}
