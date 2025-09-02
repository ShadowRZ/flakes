{
  flake.modules.nixos = {
    base = _: {
      security.rtkit.enable = true;
    };
  };
}
