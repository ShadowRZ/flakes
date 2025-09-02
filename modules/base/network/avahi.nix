{
  flake.modules.nixos = {
    base = _: {
      services = {
        avahi = {
          enable = true;
          nssmdns4 = true;
        };
      };
    };
  };
}
