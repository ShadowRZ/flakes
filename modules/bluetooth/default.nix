{
  flake.modules.nixos = {
    bluetooth = _: {
      hardware.bluetooth.enable = true;
    };
  };
}
