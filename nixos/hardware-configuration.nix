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
    device = "/dev/disk/by-uuid/D298-CE38";
    fsType = "vfat";
  };

  fileSystems."/.persistent" = {
    device = "/dev/disk/by-uuid/0f9eb06e-653d-47a9-94ae-cde838ec3581";
    fsType = "btrfs";
    options = [ "subvolid=258" "compress-force=zstd" ];
    neededForBoot = true;
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/0f9eb06e-653d-47a9-94ae-cde838ec3581";
    fsType = "btrfs";
    options = [ "subvolid=256" "compress-force=zstd" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/0f9eb06e-653d-47a9-94ae-cde838ec3581";
    fsType = "btrfs";
    options = [ "subvolid=257" "compress-force=zstd" ];
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/d0ec60bc-09f3-4dc3-8911-067e00962e8e"; }];

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
