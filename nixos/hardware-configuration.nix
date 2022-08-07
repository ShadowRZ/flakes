{ config, lib, pkgs, ... }: {

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ "i915" ];
  # wl is in brodacom_sta.
  boot.kernelModules = [ "wl" "kvm-intel" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ broadcom_sta ];
  boot.kernelParams = lib.mkAfter [ "i915.fastboot=1" ];

  # Force the builder to think we can't touch EFI variables.
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;

  # Tmpfs /
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=32M" "mode=0755" ];
  };

  boot.initrd.luks.devices."root".device =
    "/dev/disk/by-uuid/d23c435d-c81a-4bed-91ff-b10f9aeae1e0";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/732E-5189";
    fsType = "vfat";
  };

  fileSystems."/.persistent" = {
    device = "/dev/disk/by-uuid/dc3dad35-273d-4619-a694-4faf8b4debe5";
    fsType = "btrfs";
    options = [ "subvolid=530" ];
    neededForBoot = true;
  };
  fileSystems."/etc/ssh".neededForBoot = true;

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/dc3dad35-273d-4619-a694-4faf8b4debe5";
    fsType = "btrfs";
    options = [ "subvolid=291" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/dc3dad35-273d-4619-a694-4faf8b4debe5";
    fsType = "btrfs";
    options = [ "subvolid=256" ];
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/04342f1b-0f87-4a25-bc92-7a9b0268d9b1"; }];

  # System networks that only avaliable to this machine.
  systemd.network.networks = {
    # Wired network
    "10-wired" = {
      name = "enp4s0";
      address = [ "10.16.1.1/24" ];
      DHCP = "yes";
      networkConfig = {
        IPForward = true;
      };
      dhcpV4Config = {
        UseDNS = false;
        RouteMetric = 2048;
      };
      dhcpV6Config = {
        UseDNS = false;
        RouteMetric = 2048;
      };
      dhcpServerConfig = {
        EmitDNS = true;
        # https://www.dnspod.cn/Products/publicdns
        DNS = [ "119.29.29.29" ];
      };
      # dhcpServerConfig.ServerAddress doesn't work.
      extraConfig = ''
        [DHCPServer]
        ServerAddress=10.16.1.1/24
      '';
    };
    # Wireless interface
    "15-wireless" = {
      name = "wlp3s0";
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
}
