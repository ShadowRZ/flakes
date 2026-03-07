{
  flake.modules.nixos = {
    base = _: {
      # Podman
      virtualisation.podman = {
        enable = true;
      };
    };
  };
}
