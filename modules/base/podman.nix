{
  flake.modules.nixos = {
    base = {
      # Podman
      virtualisation.podman = {
        enable = true;
      };
    };
  };
}
