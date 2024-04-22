{ config, ... }: {

  networking.hostName = "mika-honey";
  services.getty = {
    greetingLine = with config.system.nixos; ''
      Mika Honey
      Configuration Revision = ${config.system.configurationRevision}
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
        [ "ata_piix" "mptspi" "uhci_hcd" "ehci_pci" "sd_mod" "sr_mod" ];
    };
  };

}
