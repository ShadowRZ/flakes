{
  flake.modules.nixos = {
    base =
      { lib, ... }:
      {
        boot = {
          loader.timeout = 0;

          # Enable Systemd based initrd
          initrd.systemd.enable = true;

          tmp.useTmpfs = true;
          enableContainers = lib.mkDefault false;
        };
      };
  };
}
