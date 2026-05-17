{
  flake.modules.nixos.base = _: {
    # Podman
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
  };
}
