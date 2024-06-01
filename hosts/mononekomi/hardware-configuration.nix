{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixpkgs.nixosModules.notDetected
    inputs.nixos-sensible.nixosModules.zram
  ];

  hardware = {
    cpu.intel.updateMicrocode = true;
    nvidia = {
      open = true;
      nvidiaSettings = false;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = false;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
    opengl = {
      extraPackages = with pkgs; [intel-compute-runtime intel-media-driver];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        intel-compute-runtime
        intel-media-driver
      ];
    };
  };

  boot.kernelModules = ["nvidia-uvm"];
  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod"];

  nixpkgs.hostPlatform = "x86_64-linux";
}
