{
  flake.modules.nixos = {
    bluetooth = {
      hardware.bluetooth.enable = true;
    };
  };
}
