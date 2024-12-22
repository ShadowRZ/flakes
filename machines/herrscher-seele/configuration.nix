{
  config,
  pkgs,
  lib,
  inputs,
  inputs',
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
    inputs.self.nixosModules.default
    # OS core parts
    inputs.self.nixosModules.graphical
    inputs.self.nixosModules.hardening
    inputs.self.nixosModules.networking
    inputs.self.nixosModules.nix
    # Machine specific templates
    inputs.self.nixosModules.pam-fido2
    inputs.self.nixosModules.lanzaboote
    inputs.self.nixosModules.plasma-desktop
    # Core fragments
    ./fragments/disk-layout.nix
    ./fragments/hardware-configuration.nix
    # Secrets
    ./secrets
    # Machine specific modules
    ./modules/impermanence.nix
    ./modules/networking.nix
    ./modules/virtualisation.nix
    # Users
    ./users/root.nix
    ./users/shadowrz.nix
  ];

  services.getty.greetingLine = with config.system.nixos; ''
    NixOS ${release} (${codeName})
    https://github.com/NixOS/nixpkgs/tree/${revision}

    \e{lightmagenta}Codename Hanekokoro
    https://github.com/ShadowRZ/flakes/tree/${config.system.configurationRevision}
  '';

  nixpkgs.overlays = [
    inputs.self.overlays.default
  ];

  home-manager = {
    sharedModules = [
      inputs.self.hmModules.default
      inputs.self.hmModules.shell
    ];
  };

  # Kernel
  boot = {
    loader.timeout = 0;
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    # Set path for Lanzaboote
    lanzaboote.pkiBundle = "${config.users.users.shadowrz.home}/Documents/Secureboot";
  };

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
    systemPackages = [
      # For FirefoxPWA
      pkgs.firefoxpwa
      # Lightly
      inputs'.darkly.packages.darkly-qt5
      inputs'.darkly.packages.darkly-qt6
      # Kvantum
      pkgs.libsForQt5.qtstyleplugin-kvantum
      pkgs.kdePackages.qtstyleplugin-kvantum

      pkgs.colloid-icon-theme
      pkgs.tela-icon-theme
      pkgs.tela-circle-icon-theme
      pkgs.numix-icon-theme
      pkgs.fluent-icon-theme
      pkgs.beauty-line-icon-theme

      pkgs.plasma-panel-colorizer
    ];

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
    pcscd.enable = true;
    system76-scheduler.enable = true;
    # Userborn
    userborn.enable = true;
  };

  security.pam.loginLimits = [
    {
      domain = "*";
      type = "-";
      item = "memlock";
      value = "unlimited";
    }
  ];

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
