{
  flake.modules.nixos = {
    thunderbolt =
      _:
      {
        services.hardware.bolt.enable = true;
      };
  };
}
