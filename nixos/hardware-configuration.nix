{ config, lib, pkgs, ... }: {

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ ];

  # Tmpfs /
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=128M" "mode=0755" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D3F9-2B2C";
    fsType = "vfat";
  };

  fileSystems."/.persistent" = {
    device = "/dev/disk/by-uuid/4df96150-4528-4ad3-a82e-c9612e0525ec";
    fsType = "btrfs";
    options = [ "subvolid=256" "compress-force=zstd" ];
    neededForBoot = true;
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/4df96150-4528-4ad3-a82e-c9612e0525ec";
    fsType = "btrfs";
    options = [ "subvolid=262" "compress-force=zstd" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/4df96150-4528-4ad3-a82e-c9612e0525ec";
    fsType = "btrfs";
    options = [ "subvolid=257" "compress-force=zstd" ];
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/8677f316-df6e-4459-ab19-04572d624d9b"; }];

  boot.initrd.luks.devices."luks-e9804028-c8df-4b5b-8557-9aaac7e363d9".device =
    "/dev/disk/by-uuid/e9804028-c8df-4b5b-8557-9aaac7e363d9";

  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
