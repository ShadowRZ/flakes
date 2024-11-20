{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    # Global Flake Inputs
    inputs.nixpkgs.nixosModules.notDetected
    inputs.nixos-sensible.nixosModules.default
    inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops
    # Foundation
    ../../nixos/foundation-configuration.nix
    # OS
    ../../nixos/modules/graphical
    ../../nixos/modules/hardening
    ../../nixos/modules/networking
    ../../nixos/modules/nix
    # Imports
    ../../imports/templates/plasma-desktop.nix
    ../../imports/templates/virtualisation.nix
    ../../imports/templates/nftables-firewall.nix
    ../../imports/networkmanager.nix
    ../../imports/fido2-login.nix
    ../../imports/silent-boot.nix
    # Hardware
    ./hardware-configuration.nix
    ./disk-configuration.nix
    ../../imports/lanzaboote.nix
    ../../imports/impermanence.nix
    # Users
    ./users/shadowrz.nix
    ./users/root.nix
  ];

  services.getty.greetingLine = with config.system.nixos; ''
    NixOS ${release} (${codeName})
    https://github.com/NixOS/nixpkgs/tree/${revision}

    \e{lightmagenta}Codename Hanekokoro
    https://github.com/ShadowRZ/flakes/tree/${config.system.configurationRevision}\e{reset}
  '';

  nixpkgs.overlays = [
    inputs.blender.overlays.default
    inputs.self.overlays.default
  ];

  networking.hostName = "mononekomi";

  boot.loader.timeout = 0;

  # fwupd, also deals with UEFI capsule updates used by the host machine.
  services.fwupd.enable = true;

  # Enable NVIDIA
  services.xserver.videoDrivers = [ "nvidia" ];

  networking.stevenblack.enable = true;
  services.system76-scheduler.enable = true;
  services.power-profiles-daemon.enable = true;
  services.thermald.enable = true;

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age = {
      keyFile = "/var/lib/sops.key";
      sshKeyPaths = [ ];
    };
    gnupg.sshKeyPaths = [ ];
    secrets = {
      passwd = {
        neededForUsers = true;
      };
      dae = {};
    };
    templates = {
      "config.dae".content = ''
        ${builtins.readFile ../../nixos/modules/networking/dae.conf}
        ${config.sops.placeholder.dae}
      '';
    };
  };

  # Kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;

  # Unfree configs
  nixpkgs.config = {
    # Solely allows some packages
    allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "vscode"
        "code"
        "fcitx5-pinyin-moegirl"
      ]
      || pkgs.lib.any (prefix: pkgs.lib.hasPrefix prefix (pkgs.lib.getName pkg)) [
        "steam"
        "nvidia"
        "android-studio"
        "android-sdk"
        "libXNVCtrl" # ?
      ];
    # Solely allows Electron
    allowInsecurePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [ "electron" ];
    # https://developer.android.google.cn/studio/terms
    android_sdk.accept_license = true;
  };

  # System programs
  programs = {
    adb.enable = true;
    nano.enable = false;
    vim.defaultEditor = false;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    zsh = {
      enable = true;
      enableLsColors = false;
    };
    ssh = {
      startAgent = true;
    };
    # Steam
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraArgs = "-forcedesktopscaling 1.5";
      };
      protontricks.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };

  environment = {
    systemPackages = [ pkgs.firefoxpwa ];

    # Link /share/zsh
    pathsToLink = [ "/share/zsh" ];

    variables = {
      VK_ICD_FILENAMES = "${pkgs.mesa.drivers}/share/vulkan/icd.d/intel_icd.x86_64.json";
      GSK_RENDERER = "gl";
    };
  };

  services = {
    # Generate ZRAM
    zram-generator = {
      enable = true;
      settings.zram0 = {
        compression-algorithm = "zstd";
        zram-size = "ram";
      };
    };
    fstrim.enable = true;
    dbus.implementation = "broker";
    pcscd.enable = true;
    dae = {
      enable = true;
      disableTxChecksumIpGeneric = false;
      configFile = config.sops.templates."config.dae".path;
    };
  };

  security.rtkit.enable = true;

  users.mutableUsers = false;
  powerManagement.powertop.enable = true;

  # DO NOT FIDDLE WITH THIS VALUE !!!
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  # Before changing this value (which you shouldn't do unless you have
  # REALLY NECESSARY reason to do this) read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html)
  # and release notes, SERIOUSLY.
  system.stateVersion = "24.05"; # Did you read the comment?
}
