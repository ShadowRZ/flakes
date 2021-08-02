{ config, pkgs, ... }: {

  imports = [
    ../pieces/graphical
    ../pieces/graphical/packages.nix
    ../pieces/graphical/videoaccel.nix
    ../pieces/network.nix
    ../pieces/system.nix
    # Users
    ../pieces/users
  ];

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
  boot.kernelPackages = pkgs.linuxPackages;
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

  environment.pathsToLink = [ "/share/zsh" ];
  # Virtualisation
  virtualisation = {
    # Libvirt
    libvirtd.enable = true;
    # VitrualBox
    virtualbox.host.enable = true;
    # LXC
    lxc.enable = true;
  };

  # Firewall
  networking.firewall.enable = false;

  # Hostname
  networking.hostName = "futaba-g480";

  # System State Version
  system.stateVersion = "21.05";
}
