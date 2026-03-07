{ lib, ... }:
{
  flake.modules.nixos = {
    base = _: {
      powerManagement = {
        enable = true;
        powertop.enable = true;
        cpuFreqGovernor = lib.mkDefault "powersave";
      };
    };
  };
}
