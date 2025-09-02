{
  flake.modules.nixos = {
    base = _: {
      services.orca.enable = false;
      services.speechd.enable = false;
    };
  };
}
