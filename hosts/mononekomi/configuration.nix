{
  pkgs,
  lib,
  ...
}: {
  imports = [
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

  networking.hostName = "mononekomi";

  boot.loader.timeout = 0;

  # fwupd, also deals with UEFI capsule updates used by the host machine.
  services.fwupd.enable = true;

  # Enable NVIDIA
  services.xserver.videoDrivers = ["nvidia"];

  networking.stevenblack.enable = true;
  services.system76-scheduler.enable = true;
  services.power-profiles-daemon.enable = true;
  services.thermald.enable = true;

  # Kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;

  # Unfree configs
  nixpkgs.config = {
    # Solely allows some packages
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) ["vscode" "code"]
      || pkgs.lib.any
      (prefix: pkgs.lib.hasPrefix prefix (pkgs.lib.getName pkg)) [
        "steam"
        "nvidia"
        "android-studio"
        "android-sdk"
        "libXNVCtrl" # ?
      ];
    # Solely allows Electron
    allowInsecurePredicate = pkg:
      builtins.elem (pkgs.lib.getName pkg) ["electron"];
    # https://developer.android.google.cn/studio/terms
    android_sdk.accept_license = true;
  };

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
