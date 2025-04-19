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
      blender_3_6 # Blender 3.6.* (Binary)
      hugo # Hugo
      ffmpeg-full # FFmpeg
      helvum
      blanket
      geany # Geany
      gimp # GIMP
      inkscape # Inkscape
      d-spy # D-Spy
      meld # Meld
      mangohud
      audacity
      libreoffice-fresh # LibreOffice Fresh
      waylyrics
      android-studio
      mindustry-wayland
      cmus
      ghostty
      featherpad
      sqlitebrowser
      pdfarranger
      thunderbird-latest
      plasma-overdose-kde-theme
      jetbrains.idea-community-bin
      eclipses.eclipse-platform
      zed-editor
      telegram-desktop
      ## KDE Packages
      kdePackages.kdenlive
      kdePackages.kcalc
      kdePackages.kcharselect
      kdePackages.plasma-sdk # Plasma SDK
      kdePackages.kdevelop
    ];
    hashedPasswordFile = config.sops.secrets.passwd.path;
  };
}
