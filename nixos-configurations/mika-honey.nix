{ config, pkgs, lib, inputs, ... }: {

  nixpkgs.hostPlatform = "x86_64-linux";

  imports = [
    # Flake Inputs
    inputs.nixpkgs.nixosModules.notDetected
    inputs.impermanence.nixosModule
    inputs.nur.nixosModules.nur
    inputs.nix-indexdb.nixosModules.nix-index
  ];

  networking = {
    # Hostname
    hostName = "mika-honey";
  };

  # Users
  users = {
    mutableUsers = false;
    users = {
      shadowrz = {
        uid = 1000;
        isNormalUser = true;
        initialHashedPassword = "";
        shell = pkgs.zsh;
        description = "紫叶零湄";
        extraGroups = [ "wheel" "networkmanager" ];
        packages = with pkgs; [
          hugo # Hugo
          krusader
        ];
      };
    };
  };

  environment = {
    # System level packages.
    systemPackages = with pkgs; [
      kwrited
      config.nur.repos.shadowrz.klassy
      # Qt 5 tools
      libsForQt5.qttools.dev
      adw-gtk3
      # Plasma themes
      graphite-kde-theme
      # wl-clipboard
      wl-clipboard
      # Used to configure SDDM Breeze Theme
      (writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
        [General]
        background=${nixos-artwork.wallpapers.nineish}/share/backgrounds/nixos/nix-wallpaper-nineish.png
      '')
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
            ".cache"
            ".cargo"
            ".config"
            ".gnupg"
            ".java"
            ".local"
            ".mozilla"
            ".ssh"
            ".thunderbird"
            ".var"
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

  # VMware Guest
  virtualisation.vmware.guest.enable = true;
  # XXX: Disable password requirement for wheel
  security.sudo.wheelNeedsPassword = false;

  services = {
    # Getty
    getty = {
      greetingLine = with config.system.nixos; ''
        Mika Honey
        Configuration Revision = ${config.system.configurationRevision}
        https://github.com/ShadowRZ/flakes

        Based on NixOS ${release} (${codeName})
        NixOS Revision = ${revision}
      '';
    };
    xserver = {
      enable = true;
      videoDrivers = [ "vmware" ];
      # SDDM
      displayManager = {
        # Plasma Wayland session works for me.
        defaultSession = "plasmawayland";
        sddm = {
          enable = true;
          settings = {
            General.GreeterEnvironment = "QT_SCALE_FACTOR=1.5,QT_FONT_DPI=96";
            Theme = {
              Font = "Recursive Sn Lnr St";
              CursorTheme = "graphite-light";
              CursorSize = 36;
            };
          };
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
  };

  hardware = {
    pulseaudio.enable = false;
    # Bluetooth
    bluetooth.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  # Enable sounds
  sound.enable = true;

  xdg.portal = {
    enable = true;
    # Enable GTK portal
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Kill generated Systemd service for Fcitx 5
  # Required to make sure KWin can bring a Fcitx 5 up to support Wayland IME protocol
  systemd.user.services.fcitx5-daemon = lib.mkForce { };

  # Host configs
  boot = {
    kernelModules = [ ];
    initrd = {
      availableKernelModules =
        [ "ata_piix" "mptspi" "uhci_hcd" "ehci_pci" "sd_mod" "sr_mod" ];
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
      device = "/dev/disk/by-label/@EFI_BOOT";
      fsType = "vfat";
    };

    "/persist" = {
      device = "/dev/disk/by-label/@rootfs";
      fsType = "btrfs";
      options = [ "subvol=/@persist" "compress-force=zstd" ];
      neededForBoot = true;
    };

    "/nix" = {
      device = "/dev/disk/by-label/@rootfs";
      fsType = "btrfs";
      options = [ "subvol=/@nix" "compress-force=zstd" ];
    };
  };

  swapDevices =
    [{ device = "/dev/disk/by-label/@linux-swap"; }];
}
