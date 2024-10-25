{
  config,
  pkgs,
  ...
}:
{
  imports = [ ../../../users/shadowrz ];

  home-manager.users.shadowrz.imports = [
    ../../../home/modules/firefox
    ../../../home/modules/mpv
    ../../../home/modules/dconf
    ../../../home/modules/fontconfig
    ../../../home/modules/gtk
    ../../../home/modules/kitty
    ../../../home/modules/foot
    ../../../home/modules/emacs
    ../../../home/modules/obs
    ../../../home/modules/cursor
    ../../../home/modules/vscode
  ];

  users.users.shadowrz = {
    extraGroups = [
      "wheel"
      "networkmanager"
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
      foliate
      celluloid
      audacity
      apostrophe
      libreoffice-fresh # LibreOffice Fresh
      quodlibet-full # Quod Libet
      nextcloud-client
      waylyrics
      android-studio
      mindustry-wayland
      gnome-builder
      featherpad
      ungoogled-chromium
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
      kdePackages.akonadi-notes
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
