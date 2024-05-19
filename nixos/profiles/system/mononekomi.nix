{ config, lib, ... }: {

  networking.hostName = "mononekomi";
  services.getty = {
    greetingLine = with config.system.nixos; ''
      Mononekomi @ Revision = ${config.system.configurationRevision}
      https://github.com/ShadowRZ/flakes

      Based on NixOS ${release} (${codeName})
      NixOS Revision = ${revision}
    '';
  };
  # Host configs
  boot = {
    kernelModules = [ ];
    initrd = {
      availableKernelModules =
        [ "xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    };
  };

  # Enable NVIDIA
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    cpu.intel.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
    nvidia = {
      nvidiaSettings = false;
      dynamicBoost.enable = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = false;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  sops = {
    defaultSopsFile = ./secrets/mononekomi.yaml;
    age.keyFile = "/var/lib/sops.key";
    secrets = { passwd = { neededForUsers = true; }; };
  };

  users.users.shadowrz.hashedPasswordFile = config.sops.secrets.passwd.path;
  fileSystems."/persist".neededForBoot = true;
}
