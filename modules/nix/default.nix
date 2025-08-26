{
  flake.modules = {
    nixos = {
      nix =
        _:
        {
          # Configure Nix.
          nix = {
            settings = {
              builders-use-substitutes = true;
              auto-optimise-store = true;
              trusted-users = [ "@wheel" ];
              keep-derivations = true;
              experimental-features = [
                "auto-allocate-uids"
                "cgroups"
              ];
              auto-allocate-uids = true;
              use-cgroups = true;
              use-xdg-base-directories = true;
              http-connections = 0;
              max-substitution-jobs = 128;
            };
          };
        };
    };
  };
}
