{ config, lib, pkgs, ... }: {

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" ];
  boot.kernelModules = [ ];

  # Tmpfs /
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=32M" "mode=0755" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8335-2589";
    fsType = "vfat";
  };

  fileSystems."/.persistent" = {
    device = "/dev/disk/by-uuid/d41ca4e0-9548-45c4-a276-f02cbac446f7";
    fsType = "btrfs";
    options = [ "subvolid=258" "compress-force=zstd" ];
    neededForBoot = true;
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/d41ca4e0-9548-45c4-a276-f02cbac446f7";
    fsType = "btrfs";
    options = [ "subvolid=256" "compress-force=zstd" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/d41ca4e0-9548-45c4-a276-f02cbac446f7";
    fsType = "btrfs";
    options = [ "subvolid=257" "compress-force=zstd" ];
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/b232112e-d34a-4460-9fd1-993f584a2bb9"; }];

  systemd.network.networks = {
    "10-wired" = {
      name = "ens33";
      DHCP = "yes";
      dhcpV4Config = {
        UseDNS = false;
        RouteMetric = 1024;
      };
      dhcpV6Config = {
        UseDNS = false;
        RouteMetric = 1024;
      };
    };
  };

  virtualisation.vmware.guest.enable = true;
}
