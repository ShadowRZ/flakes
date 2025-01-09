{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixpkgs.nixosModules.notDetected
    inputs.nixos-sensible.nixosModules.zram
  ];

  hardware = {
    cpu.intel.updateMicrocode = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      open = true;
      nvidiaSettings = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = false;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
      powerManagement = {
        enable = true;
        finegrained = false;
      };
    };
    graphics = {
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        intel-media-driver
      ];
      enable32Bit = true;
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  boot = {
    kernelModules = [
      "i915"
      "legion-laptop"
    ];
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "legion-laptop"
      ];
    };
    extraModulePackages = [
      (config.boot.kernelPackages.lenovo-legion-module.overrideAttrs {
        env.NIX_CFLAGS_COMPILE = "-Wno-error=incompatible-pointer-types";
      })
    ];
  };

  # Bolt
  services.hardware.bolt.enable = true;

  # SSD TRIM
  services.fstrim.enable = true;

  # fwupd
  services.fwupd.enable = true;

  # Tweak SDDM for the machine's HiDPI
  services.displayManager.sddm.settings = {
    General.GreeterEnvironment = "QT_SCALE_FACTOR=1.25,QT_FONT_DPI=96";
  };
}
