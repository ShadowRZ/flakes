{ pkgs, ... }:

{
  services = {
    gnome.gnome-keyring.enable = true;
    upower.enable = true;

    dbus = {
      enable = true;
      packages = [ pkgs.gnome.dconf ];
    };

    xserver = {
      enable = true;
      # Configure keymap in X11
      layout = "us";
      libinput = {
        enable = true;
        touchpad.disableWhileTyping = true;
      };
      # SDDM
      displayManager.sddm = { enable = true; };
      # Awesome
      windowManager.awesome.enable = true;
      # Modesettings driver
      videoDrivers = [ "modesettings" ];
    };
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-chinese-addons ];
    };
  };

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
