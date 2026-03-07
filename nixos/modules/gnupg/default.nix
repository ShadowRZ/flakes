{
  flake.modules.nixos.gnupg = _: {
    services.pcscd.enable = true;
  };
}
