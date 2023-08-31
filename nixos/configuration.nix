# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Modules.
    ./modules/environment.nix
    ./modules/graphical-environment.nix
    ./modules/networking.nix
  ];

  boot = {
    loader = {
      timeout = 0;
      # Use the systemd-boot EFI boot loader.
      systemd-boot = {
        enable = true;
        graceful = true;
      };
    };
    # Kernel.
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    kernelParams = lib.mkAfter [
      "quiet"
      "udev.log_priority=3"
      "vt.global_cursor_default=0"
    ];
    tmp.useTmpfs = true;
    initrd = {
      verbose = false;
      systemd.enable = true;
    };
    consoleLogLevel = 0;
    plymouth = { enable = true; };
  };

  # Configure Nix.
  nix = {
    channel.enable = false;
    settings = {
      trusted-users = [ "root" "@wheel" ];
      substituters = lib.mkForce [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.bfsu.edu.cn/nix-channels/store"
        "https://berberman.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://nix-community.cachix.org"
        "https://shadowrz.cachix.org"
        "https://cache.garnix.io"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "berberman.cachix.org-1:UHGhodNXVruGzWrwJ12B1grPK/6Qnrx2c3TjKueQPds="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "shadowrz.cachix.org-1:I+6FCWMtdGmN8zYVncKdys/LVsLkCMWO3tfXbwQPTU0="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
      builders-use-substitutes = true;
      flake-registry = "/etc/nix/registry.json";
      auto-optimise-store = true;
      allowed-users = [ "@wheel" ];
      keep-derivations = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
        "auto-allocate-uids"
        "cgroups"
      ];
      auto-allocate-uids = true;
      use-cgroups = true;
      use-xdg-base-directories = true;
    };
  };

  # Configure console.
  console = {
    packages = with pkgs; [ terminus_font ];
    earlySetup = true;
    font = "ter-132b";
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Hostname
  networking.hostName = "hanekokoroos";

  # Sops-Nix
  sops = {
    defaultSopsFile = ./secrets.yaml;
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
        passwordFile = config.sops.secrets.passwd.path;
        shell = pkgs.zsh;
        description = "羽心印音";
        extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
        packages = with pkgs; [
          blender_3_6 # Blender 3.6.* (Binary)
          graphviz # Graphviz
          hugo # Hugo
          krusader # Krusader
          mindustry # Mindustry
          libsForQt5.plasma-sdk # Plasma SDK
          konversation
          geany
          libreoffice-fresh # LibreOffice Fresh
          kdialog
          pipenv # Pipenv
          yarn-berry # Yarn Berry
          virt-viewer # Virt Viewer
          ffmpeg-full # FFmpeg
          imagemagick # ImageMagick
          featherpad
          kate
          aria2
          helvum
          keepassxc
          yt-dlp
          kdenlive
          fluffychat # FluffyChat
          nheko
          gnome.geary
          logseq
          calibre
          jetbrains.idea-community
        ];
      };
    };
  };

  # Getty
  services = {
    getty = {
      greetingLine = with config.system.nixos; ''
        Hanekokoro OS
        Configuration Revision = ${config.system.configurationRevision}

        Based on NixOS ${release} (${codeName})
        Revision = ${revision}
      '';
    };
    # Udev
    udev.packages = with pkgs; [ android-udev-rules ];
    fwupd.enable = true;
    zram-generator = {
      enable = true;
      settings.zram0 = {
        compression-algorithm = "zstd";
        zram-size = "ram";
      };
    };
  };

  # Home Manager
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit (config) nur; };
    users = { shadowrz = import ./shadowrz/home-environment.nix; };
  };

  # Persistent files
  environment.persistence."/.persistent" = {
    directories = [ "/var/log" "/var/lib" "/var/cache" "/root" ];
    files = [ "/etc/machine-id" ];
  };
  # As Age keys takes part in Sops-Nix early user password provisioning,
  # mark containing folders as required for boot.
  fileSystems."/var/lib".neededForBoot = true;

  # Misc
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ (import ./modules/overrides/package-overlay.nix) ];
  };

  # Libvirtd
  virtualisation = {
    waydroid.enable = true;
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
  };

  # Rtkit
  security.rtkit.enable = true;

  # Disable all HTML documentations.
  documentation.doc.enable = lib.mkForce false;

  i18n = {
    # Build all Glibc supported locales as defined in:
    # https://sourceware.org/git/?p=glibc.git;a=blob;f=localedata/SUPPORTED
    # This is because Home Manager actually configures a locale archive
    # which is built with all supported locales and exports
    # LOCALE_ARCHIVE_2_27.
    # Unfortunately this means other users, especially root with sudo,
    # various applications stop supporting user's current locale as they
    # lost LOCALE_ARCHIVE_2_27 and taken LOCALE_ARCHIVE which is not built
    # with all locales like Home Manager.
    # Especially Perl which gave warning if it can't use such locale.
    supportedLocales = [ "all" ];
    # Fcitx 5
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-chinese-addons
        fcitx5-pinyin-moegirl
        fcitx5-pinyin-zhwiki
      ];
    };
  };

  # XXX: Kill generated Systemd service for Fcitx 5
  # Required to make sure KWin can bring a Fcitx 5 up to support Wayland IME protocol
  systemd.user.services.fcitx5-daemon = lib.mkForce { };

  # DO NOT FIDDLE WITH THIS VALUE !!!
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  # Before changing this value (which you shouldn't do unless you have
  # REALLY NECESSARY reason to do this) read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html)
  # and release notes, SERIOUSLY.
  system.stateVersion = "23.05"; # Did you read the comment?
}
