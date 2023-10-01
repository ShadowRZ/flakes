{ config, lib, pkgs, ... }: {

  boot = {
    kernelModules = [ ];
    initrd = {
      availableKernelModules =
        [ "xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      luks.devices."root".device =
        "/dev/disk/by-uuid/e9804028-c8df-4b5b-8557-9aaac7e363d9";
    };
  };

  fileSystems = {
    # Tmpfs /
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=2G" "mode=0755" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/D3F9-2B2C";
      fsType = "vfat";
    };

    "/persist" = {
      device = "/dev/disk/by-uuid/4df96150-4528-4ad3-a82e-c9612e0525ec";
      fsType = "btrfs";
      options = [ "subvolid=256" "compress-force=zstd" ];
      neededForBoot = true;
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/4df96150-4528-4ad3-a82e-c9612e0525ec";
      fsType = "btrfs";
      options = [ "subvolid=262" "compress-force=zstd" ];
    };
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/8677f316-df6e-4459-ab19-04572d624d9b"; }];

  hardware = {
    cpu.intel.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
    nvidia = {
      nvidiaSettings = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
