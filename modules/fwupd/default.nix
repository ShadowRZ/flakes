{
  flake.modules.nixos = {
    fwupd = _: {
      services.fwupd.enable = true;
    };
  };
}
