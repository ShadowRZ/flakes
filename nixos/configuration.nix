# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Profiles.
    ./modules/core
    ./modules/networking
    ./modules/graphical
    ./modules/environment
    ./modules/virtualization
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  # Kernel.
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  boot.kernelParams = lib.mkAfter [
    "quiet"
    "udev.log_priority=3"
    "systemd.unified_cgroup_hierarchy=1"
    "systemd.show_status=true"
  ];
  boot.tmpOnTmpfs = true;
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Link /share/zsh
  environment.pathsToLink = [ "/share/zsh" ];

  # Hostname
  networking.hostName = "hermitmedjed-s";

  # libinput Touchpad.
  services.xserver.libinput = {
    touchpad = {
      disableWhileTyping = true;
      horizontalScrolling = false;
      scrollMethod = "edge";
    };
    mouse = {
      disableWhileTyping = true;
      horizontalScrolling = false;
      scrollMethod = "edge";
    };
  };

  # Sops-Nix
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets = { passwd.neededForUsers = true; };
  };

  # Users
  users = {
    mutableUsers = false;
    users = {
      futaba = {
        uid = 1000;
        isNormalUser = true;
        passwordFile = config.sops.secrets.passwd.path;
        shell = pkgs.zsh;
        description = "佐仓双叶";
        extraGroups = [ "wheel" ];
        packages = with pkgs; [
          kdenlive # Kdenlive
          blender # Blender
          qtcreator # Qt Creator
          graphviz # Graphviz
          hugo # Hugo
          yarn # Yarn
          electron # Electron
          aegisub # AegiSub
          keepassxc # KeePassXC
          gocryptfs # Gocryptfs
          kate # Kate
          falkon # Falkon
          krusader # Krusader
          emacsPgtkNativeComp # Emacs with Pure GTK + Native Compilation.
          feeluown # FeelUOwn
          mindustry # Mindustry
          nheko # Nheko
          qownnotes # QOwnNotes
          mkxp-z # mkxp-z
          rvpacker
          nur.repos.rycee.mozilla-addons-to-nix
        ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH2Y7fSAJgH4KJZYsKJo01SVCCoV0A4wmD0etDM394PO u0_a203@localhost"
        ];
      };
    };
  };
  home-manager.users = {
    futaba = import ./futaba;
    root = import ./root;
  };

  # Persistent files
  environment.persistence."/.persistent" = {
    directories = [
      "/var/log"
      "/var/lib"
      "/var/cache"
      # SSH
      "/etc/ssh"
    ];
    files = [
      "/etc/machine-id"
    ];
  };

  # Misc
  nixpkgs.config.allowUnfree = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  # ZRAM
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  # Enable polkit
  security.polkit.enable = true;

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
  i18n.supportedLocales = [ "all" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
