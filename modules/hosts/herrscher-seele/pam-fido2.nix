{
  flake.modules.nixos = {
    "hosts/herrscher-seele" = {
      security.pam = {
        services = {
          login.u2fAuth = true;
          sudo.u2fAuth = true;
        };
        u2f = {
          enable = true;
          control = "sufficient";
          settings = {
            cue = true;
          };
        };
      };
    };
  };
}
