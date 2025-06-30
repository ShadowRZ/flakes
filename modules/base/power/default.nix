{ lib, ... }:
{
  flake.modules.nixos = {
    base = {
      powerManagement = {
        enable = true;
        powertop.enable = true;
        cpuFreqGovernor = lib.mkDefault "powersave";
      };
    };
  };
}
