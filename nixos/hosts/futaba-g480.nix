{ config, pkgs, ... }: {

  imports = [
    ../saekmi/graphical.nix
    ../saekmi/network.nix
    ../saekmi/system.nix
    # Users
    ../saekmi/users
  ];

  nixpkgs.config.allowUnfree = true;

  # Bootup.
  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/1e8c1a3a-45aa-4eaf-81f2-faa32d8b1215";
    fsType = "btrfs";
    options = [ "subvol=@nixos" ];
  };

  boot.initrd.luks.devices."root".device =
    "/dev/disk/by-uuid/6e895378-e749-4142-9b56-6eade08b0266";

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/1e8c1a3a-45aa-4eaf-81f2-faa32d8b1215";
    fsType = "btrfs";
    options = [ "subvol=@nix" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/FF84-0190";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/1e8c1a3a-45aa-4eaf-81f2-faa32d8b1215";
    fsType = "btrfs";
    options = [ "subvol=@home" ];
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/f69e9399-f438-4ca4-b9ce-216d3314e327"; }];

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

  console = {
    font = "Lat2-Terminus24";
    keyMap = "us";
  };

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
