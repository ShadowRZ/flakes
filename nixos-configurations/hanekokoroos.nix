{ config, pkgs, lib, inputs, ... }: {

  nixpkgs.hostPlatform = "x86_64-linux";

  imports = [
    # Flake Inputs
    inputs.nixpkgs.nixosModules.notDetected
    inputs.impermanence.nixosModule
    inputs.sops-nix.nixosModules.sops
    inputs.nur.nixosModules.nur
    inputs.nix-indexdb.nixosModules.nix-index
  ];

  networking = {
    # Hostname
    hostName = "hanekokoroos";
  };

  # Sops-Nix
  sops = {
    defaultSopsFile = ./secrets/hanekokoroos-secrets.yaml;
    age.keyFile = "/var/lib/sops.key";
    secrets = { passwd.neededForUsers = true; };
  };

  # Users
  users = {
    mutableUsers = true;
    users = {
      shadowrz = {
        uid = 1000;
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.passwd.path;
        shell = pkgs.zsh;
        description = "羽心印音";
        extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
        packages = with pkgs; [
          blender_3_6 # Blender 3.6.* (Binary)
          hugo # Hugo
          libsForQt5.plasma-sdk # Plasma SDK
          libreoffice-fresh # LibreOffice Fresh
          ffmpeg-full # FFmpeg
          keepassxc
          kdenlive
          fluffychat
          nheko
          cinny-desktop
          yt-dlp
          blanket
          vscode # VS Code
          renpy
          gimp # GIMP
          inkscape # Inkscape
          d-spy # D-Spy
          logseq
          celluloid
          eclipses.eclipse-java
          jetbrains.idea-community
          audacity
          gnome.gnome-font-viewer
          sweethome3d.application
          sweethome3d.textures-editor
          sweethome3d.furniture-editor
        ];
      };
    };
  };

  virtualisation = {
    # Libvirtd
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        # Enable UEFI
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
        # Enable virtual TPM support
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  environment = {
    # System level packages.
    systemPackages = with pkgs; [
      # Qt 5 tools
      libsForQt5.qttools.dev
      material-kwin-decoration # KWin material decoration
      adw-gtk3
      libsForQt5.krecorder
      # Plasma themes
      graphite-kde-theme
      # Virtiofsd
      virtiofsd
      # wl-clipboard
      wl-clipboard
    ];
    # Persistent files
    persistence."/persist" = {
      directories = [ "/var" "/root" ];
      files = [ "/etc/machine-id" ];
      users = {
        shadowrz = {
          directories = [
            "Documents"
            "Downloads"
            "Pictures"
            "Projects"
            "Maildir"
            "Music"
            "Public"
            "Videos"
            ".android"
            ".cache"
            ".cargo"
            ".config"
            ".eclipse"
            ".gnupg"
            ".local"
            ".logseq"
            ".mozilla"
            ".renpy"
            ".ssh"
            ".steam"
            ".thunderbird"
            ".var"
            ".vscode"
          ];
          files = [ ".gtkrc-2.0" ];
        };
        root = {
          home = "/root";
          directories = [ ".cache/nix" ];
        };
      };
    };
  };

  services = {
    # Getty
    getty = {
      greetingLine = with config.system.nixos; ''
        Hanekokoro OS
        Configuration Revision = ${config.system.configurationRevision}
        https://github.com/ShadowRZ/flakes

        Based on NixOS ${release} (${codeName})
        NixOS Revision = ${revision}
      '';
    };
    # Generate ZRAM
    zram-generator = {
      enable = true;
      settings.zram0 = {
        compression-algorithm = "zstd";
        zram-size = "ram";
      };
    };
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      # SDDM
      displayManager = {
        # Plasma Wayland session works for me.
        defaultSession = "plasmawayland";
        sddm = {
          enable = true;
          theme = "Graphite";
          wayland.enable = true;
        };
      };
      desktopManager.plasma5 = {
        enable = true;
        runUsingSystemd = true;
      };
    };
    # Pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      jack.enable = true;
    };
    # pykms
    pykms.enable = true;
    # Flatpak
    flatpak.enable = true;
  };

  # System programs
  programs = {
    # KDE Connect
    kdeconnect.enable = true;
    # Steam
    steam = {
      enable = true;
      package = pkgs.steam.override { extraArgs = "-forcedesktopscaling 1.5"; };
      remotePlay.openFirewall = true;
    };
    # Virt Manager
    virt-manager = { enable = true; };
  };

  hardware = {
    pulseaudio.enable = false;
    # Bluetooth
    bluetooth.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        intel-compute-runtime
      ];
    };
  };

  # Enable sounds
  sound.enable = true;

  xdg.portal = {
    enable = true;
    ## Enable GTK portal
    #extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Kill generated Systemd service for Fcitx 5
  # Required to make sure KWin can bring a Fcitx 5 up to support Wayland IME protocol
  systemd.user.services.fcitx5-daemon = lib.mkForce { };

  # Host configs
  boot = {
    kernelModules = [ ];
    initrd = {
      availableKernelModules =
        [ "xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      luks.devices."root".device =
        "/dev/disk/by-uuid/e9804028-c8df-4b5b-8557-9aaac7e363d9";
    };
  };

  fileSystems = {
    # Tmpfs /
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=2G" "mode=0755" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/D3F9-2B2C";
      fsType = "vfat";
    };

    "/persist" = {
      device = "/dev/disk/by-uuid/4df96150-4528-4ad3-a82e-c9612e0525ec";
      fsType = "btrfs";
      options = [ "subvolid=256" "compress-force=zstd" ];
      neededForBoot = true;
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/4df96150-4528-4ad3-a82e-c9612e0525ec";
      fsType = "btrfs";
      options = [ "subvolid=262" "compress-force=zstd" ];
    };
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/8677f316-df6e-4459-ab19-04572d624d9b"; }];

  hardware = {
    cpu.intel.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
    nvidia = {
      nvidiaSettings = false;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
