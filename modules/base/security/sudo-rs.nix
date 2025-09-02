{
  flake.modules.nixos = {
    base = _: {
      security.sudo-rs.enable = true;
      security.sudo-rs.execWheelOnly = true;
    };
  };
}
