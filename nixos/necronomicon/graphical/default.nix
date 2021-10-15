{ pkgs, ... }:

{

  imports = [ ./packages.nix ./audios.nix ];

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

  systemd.services.upower.enable = true;

  environment.systemPackages = with pkgs; [
    # VA-API.
    vaapiIntel
    intel-gpu-tools
    libva-utils
  ];

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [ vaapiIntel ];
  hardware.opengl.extraPackages32 = with pkgs; [ vaapiIntel ];

}
