{
  inputs,
  inputs',
  config,
  pkgs,
  ...
}:
{
  home-manager.users.shadowrz = {
    imports = [
      inputs.self.hmModules.emacs
      inputs.self.hmModules.firefox
      inputs.self.hmModules.mpv
      inputs.self.hmModules.dconf
      inputs.self.hmModules.fontconfig
      inputs.self.hmModules.gtk
      inputs.self.hmModules.kitty
      inputs.self.hmModules.foot
      inputs.self.hmModules.obs
      inputs.self.hmModules.cursor
      inputs.self.hmModules.vscode
    ];

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
      inputs'.blender.packages.blender_3_6 # Blender 3.6.* (Binary)
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
      foliate
      celluloid
      audacity
      libreoffice-fresh # LibreOffice Fresh
      quodlibet-full # Quod Libet
      nextcloud-client
      waylyrics
      android-studio
      mindustry-wayland
      gnome-builder
      featherpad
      ungoogled-chromium
      dbeaver-bin
      jetbrains.idea-community
      ## KDE Packages
      kdePackages.kdenlive
      kdePackages.kcalc
      kdePackages.kcharselect
      kdePackages.kontact
      kdePackages.kmail
      kdePackages.kmail-account-wizard
      kdePackages.plasma-sdk # Plasma SDK
      ## Akonadi
      kdePackages.akonadi
      kdePackages.akonadi-mime
      kdePackages.akonadi-search
      kdePackages.akonadi-contacts
      kdePackages.akonadi-calendar
      kdePackages.akonadi-calendar-tools
      kdePackages.akonadi-import-wizard
      kdePackages.mbox-importer
      kdePackages.kdepim-runtime
      kdePackages.akonadiconsole
    ];
    hashedPasswordFile = config.sops.secrets.passwd.path;
  };
}
