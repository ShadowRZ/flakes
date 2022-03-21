# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Profiles.
    ./modules/core
    ./modules/networking
    ./modules/graphical
    ./modules/environment
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  # Kernel.
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.extraModulePackages = with config.boot.kernelPackages; [ broadcom_sta ];
  boot.kernelParams = pkgs.lib.mkAfter [
    "quiet"
    "udev.log_priority=3"
    "add_efi_memmap"
    "threadirqs"
    "i915.fastboot=1"
    "systemd.unified_cgroup_hierarchy=1"
    "systemd.show_status=true"
  ];
  # wl is in brodacom_sta.
  boot.kernelModules = [ "wl" "kvm-intel" ];
  boot.initrd.kernelModules = [ "i915" ];
  boot.tmpOnTmpfs = true;
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Link /share/zsh
  environment.pathsToLink = [ "/share/zsh" ];

  # Firewall
  networking.firewall.enable = false;
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

  # Users
  users.users.futaba = {
    uid = 1000;
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "佐仓双叶";
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      kdenlive # Kdenlive
      blender # Blender
      qtcreator # Qt Creator
      graphviz # Graphviz
      hugo # Hugo
      yarn # Yarn
      claws-mail # Claws Mail
      electron # Electron
      aegisub # AegiSub
    ];
  };
  home-manager.users.futaba = import ./futaba;

  # Misc
  nixpkgs.config.allowUnfree = true;
  powerManagement.cpuFreqGovernor = pkgs.lib.mkDefault "performance";

  # ZRAM
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
