{ config, lib, pkgs, ... }: {

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ ];

  # Tmpfs /
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=32M" "mode=0755" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D3F9-2B2";
    fsType = "vfat";
  };

  fileSystems."/.persistent" = {
    device = "/dev/disk/by-uuid/0f9eb06e-653d-47a9-94ae-cde838ec3581";
    fsType = "btrfs";
    options = [ "subvolid=256" "compress-force=zstd" ];
    neededForBoot = true;
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/0f9eb06e-653d-47a9-94ae-cde838ec3581";
    fsType = "btrfs";
    options = [ "subvolid=262" "compress-force=zstd" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/0f9eb06e-653d-47a9-94ae-cde838ec3581";
    fsType = "btrfs";
    options = [ "subvolid=257" "compress-force=zstd" ];
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
