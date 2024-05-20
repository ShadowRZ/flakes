{ config, lib, pkgs, ... }: {

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
  fileSystems."/persist".neededForBoot = true;

  users.users.shadowrz = {
    packages = with pkgs; [
      fractal
      keepassxc
      blender_3_6 # Blender 3.6.* (Binary)
      hugo # Hugo
      kdePackages.plasma-sdk # Plasma SDK
      libreoffice-fresh # LibreOffice Fresh
      ffmpeg-full # FFmpeg
      kdenlive
      yt-dlp
      blanket
      vscode # VS Code
      geany # Geany
      renpy
      gimp # GIMP
      inkscape # Inkscape
      d-spy # D-Spy
      mangohud
      logseq
      foliate
      celluloid
      audacity
      jetbrains.idea-community
    ];
    hashedPasswordFile = config.sops.secrets.passwd.path;
  };
}
