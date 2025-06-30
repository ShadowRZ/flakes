{
  flake.modules.nixos = {
    base = {
      security.sudo-rs.enable = true;
      security.sudo-rs.execWheelOnly = true;
    };
  };
}
