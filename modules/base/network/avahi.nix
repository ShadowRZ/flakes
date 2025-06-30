{
  flake.modules.nixos = {
    base = {
      services = {
        avahi = {
          enable = true;
          nssmdns4 = true;
        };
      };
    };
  };
}
