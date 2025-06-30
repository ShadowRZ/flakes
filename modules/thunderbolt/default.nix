{
  flake.modules.nixos = {
    thunderbolt = {
      services.hardware.bolt.enable = true;
    };
  };
}
