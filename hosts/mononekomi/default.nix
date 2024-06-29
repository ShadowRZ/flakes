{
  config,
  pkgs,
  ...
}: {
  imports = [
    # OS
    ../../nixos/profiles/desktop
    ../../nixos/templates/plasma-desktop.nix
    ../../nixos/templates/virtualisation.nix
    ../../nixos/profiles/common/opt-in/networkmanager.nix
    ../../nixos/profiles/common/opt-in/fido2-login.nix
    ../../nixos/profiles/common/opt-in/silent-boot.nix
    # Hardware
    ./hardware-configuration.nix
    ./anti-feature.nix
    ../../nixos/profiles/common/opt-in/lanzaboote.nix
    ../../nixos/profiles/common/opt-in/impermanence.nix
    ../../nixos/profiles/common/opt-in/disko.nix
  ];

  _module.args.disks = ["/dev/disk/by-path/pci-0000:06:00.0-nvme-1"];

  networking.hostName = "mononekomi";

  boot.loader.timeout = 0;

  # fwupd, also deals with UEFI capsule updates used by the host machine.
  services.fwupd.enable = true;

  # Enable NVIDIA
  services.xserver.videoDrivers = ["nvidia"];

  users.users.shadowrz = {
    packages = with pkgs; [
      fractal
      cinny-desktop
      nheko
      keepassxc
      blender_3_6 # Blender 3.6.* (Binary)
      hugo # Hugo
      onlyoffice-bin_latest
      ffmpeg-full # FFmpeg
      gammaray
      helvum
      yt-dlp
      blanket
      vscode # VS Code
      geany # Geany
      renpy
      gimp # GIMP
      inkscape # Inkscape
      d-spy # D-Spy
      meld # Meld
      mangohud
      logseq
      foliate
      celluloid
      audacity
      apostrophe
      jetbrains.idea-community
      libreoffice-fresh # LibreOffice Fresh
      (deadbeef-with-plugins.override {
        plugins = with deadbeefPlugins; [
          headerbar-gtk3
          mpris2
          musical-spectrum
          statusnotifier
        ];
      })
      waylyrics
      # mindustry-wayland
      ## KDE Packages
      kdePackages.kdenlive
      kdePackages.kcalc
      kdePackages.kcharselect
      kdePackages.kontact
      kdePackages.kmail
      kdePackages.plasma-sdk # Plasma SDK
    ];
    hashedPasswordFile = config.sops.secrets.passwd.path;
  };
}
