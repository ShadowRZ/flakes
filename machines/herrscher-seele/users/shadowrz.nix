{
  config,
  pkgs,
  ...
}:
{
  home-manager.users.shadowrz = {
    home = {
      username = "shadowrz";
      homeDirectory = "/home/shadowrz";
    };

    systemd.user.sessionVariables.QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
    home.sessionVariables.QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
  };

  users.users.shadowrz = {
    uid = 1000;
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "夜坂雅";

    extraGroups = [
      "wheel"
      "networkmanager"
      "wireshark"
    ];
    packages = with pkgs; [
      fractal
      keepassxc
      blender_4_4 # Blender 4.4.* (Binary)
      hugo # Hugo
      ffmpeg-full # FFmpeg
      helvum
      blanket
      gimp3 # GIMP 3
      inkscape # Inkscape
      d-spy # D-Spy
      libreoffice-fresh # LibreOffice Fresh
      android-studio
      cmus
      featherpad
      sqlitebrowser
      pdfarranger
      thunderbird-latest
      plasma-overdose-kde-theme
      jetbrains.idea-community-bin
      jetbrains.pycharm-community-bin
      eclipses.eclipse-platform
      zed-editor
      telegram-desktop
      pika-backup
      github-desktop
      ## KDE Packages
      kdePackages.kdenlive
      kdePackages.kcalc
      kdePackages.kcharselect
      kdePackages.plasma-sdk # Plasma SDK
      kdePackages.kdevelop
      kdePackages.kleopatra
      # Library
      temurin-bin-21
    ];
    hashedPasswordFile = config.sops.secrets.passwd.path;
  };
}
