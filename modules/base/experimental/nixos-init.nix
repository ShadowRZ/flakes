{
  flake.modules.nixos.base = _: {
    system.nixos-init.enable = true;
  };
}
