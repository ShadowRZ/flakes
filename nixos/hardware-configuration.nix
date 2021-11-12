# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/dc3dad35-273d-4619-a694-4faf8b4debe5";
    fsType = "btrfs";
    options = [ "subvol=@nixos" ];
  };

  boot.initrd.luks.devices."root".device =
    "/dev/disk/by-uuid/d23c435d-c81a-4bed-91ff-b10f9aeae1e0";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/732E-5189";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/dc3dad35-273d-4619-a694-4faf8b4debe5";
    fsType = "btrfs";
    options = [ "subvol=@home" ];
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/04342f1b-0f87-4a25-bc92-7a9b0268d9b1"; }];

}
