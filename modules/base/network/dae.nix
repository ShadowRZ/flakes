{
  flake.modules.nixos = {
    base =
      { config, ... }:
      {
        services = {
          dae = {
            enable = true;
            disableTxChecksumIpGeneric = false;
            configFile = config.sops.templates."config.dae".path;
          };
        };
      };
  };
}
