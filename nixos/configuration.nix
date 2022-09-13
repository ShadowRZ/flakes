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

  boot = {
    loader = {
      timeout = 0;
      # Use the systemd-boot EFI boot loader.
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        graceful = true;
      };
    };
    # Kernel.
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    kernelParams = lib.mkAfter [
      "quiet"
      "noefi"
      "udev.log_priority=3"
      "vt.global_cursor_default=0"
    ];
    tmpOnTmpfs = true;
    initrd = {
      verbose = false;
      systemd.enable = true;
    };
    consoleLogLevel = 0;
  };

  # Configure console.
  console = {
    packages = with pkgs; [ terminus_font ];
    earlySetup = true;
    font = "ter-132b";
  };

  # Configure Systemd.
  systemd.extraConfig = ''
    DefaultLimitCORE=infinity
    ShowStatus=yes
  '';

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Link /share/zsh
  environment.pathsToLink = [ "/share/zsh" ];

  # Hostname
  networking.hostName = "medjedmonogatari";

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
    age.keyFile = "/var/lib/sops.key";
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
          blender_3_2 # Blender 3.2.* (Binary)
          qtcreator # Qt Creator
          graphviz # Graphviz
          hugo # Hugo
          yarn # Yarn
          electron # Electron
          keepassxc # KeePassXC
          gocryptfs # Gocryptfs
          plasma-vault # Plasma Vault
          kate # Kate
          krusader # Krusader
          emacsPgtkNativeComp # Emacs with Pure GTK + Native Compilation.
          mindustry # Mindustry
          # nheko # Nheko (TODO)
          alacritty # Alacritty
          libsForQt5.plasma-sdk # Plasma SDK
          nix-prefetch-github
          nix-prefetch-git
          fontforge-gtk
          android-tools
          gnome.dconf-editor
          helvum
          wine-staging
          winetricks
          strawberry
          config.nur.repos.shadowrz.mkxp-z # mkxp-z
          config.nur.repos.shadowrz.rvpacker
          config.nur.repos.shadowrz._86box
          config.nur.repos.rycee.mozilla-addons-to-nix
        ];
      };
    };
  };

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit (config) nur; };
    users = {
      futaba = import ./futaba;
      root = import ./root;
    };
  };

  # Persistent files
  environment.persistence."/.persistent" = {
    directories = [
      "/var/log"
      "/var/lib"
      "/var/cache"
    ];
    files = [ "/etc/machine-id" ];
  };
  # As Age keys takes part in Sops-Nix early user password provisioning,
  # mark containing folders as required for boot.
  fileSystems."/var/lib".neededForBoot = true;

  # Misc
  nixpkgs.config.allowUnfree = true;
  powerManagement.cpuFreqGovernor = lib.mkForce "performance";

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

  # DO NOT FIDDLE WITH THIS VALUE !!!
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  # Before changing this value (which you shouldn't do unless you have
  # REALLY NECESSARY reason to do this) read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html)
  # and release notes, SERIOUSLY.
  system.stateVersion = "22.11"; # Did you read the comment?
}
