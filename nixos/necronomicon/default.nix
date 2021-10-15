{ config, pkgs, ... }: {

  imports = [ ./core ./networking ./graphical ];

  nixpkgs.config.allowUnfree = true;

  # Bootup.
  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/dc3dad35-273d-4619-a694-4faf8b4debe5";
    fsType = "btrfs";
    options = [ "subvol=@nixos" ];
  };

  boot.initrd.luks.devices."root".device =
    "/dev/disk/by-uuid/d23c435d-c81a-4bed-91ff-b10f9aeae1e0";

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/dc3dad35-273d-4619-a694-4faf8b4debe5";
    fsType = "btrfs";
    options = [ "subvol=@home" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/732E-5189";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/04342f1b-0f87-4a25-bc92-7a9b0268d9b1"; }];

  powerManagement.cpuFreqGovernor = pkgs.lib.mkDefault "performance";

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
  networking.hostName = "futaba-necronomicon";

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
      krusader # Krusader
      kdenlive # Kdenlive
      blender # Blender
      qtcreator # Qt Creator
      easyrpg-player # EasyRPG Player
      graphviz # Graphviz
      hugo # Hugo
      yarn # Yarn
      claws-mail # Claws Mail
      electron # Electron
      aegisub # AegiSub
    ];
  };
  home-manager.users.futaba = import ./home;

  # System State Version
  system.stateVersion = "21.05";
}
