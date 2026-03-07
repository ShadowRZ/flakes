{
  flake.modules = {
    nixos = {
      nix = _: {
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

          registry = {
            # A constrained set of flake registry in https://channels.nixos.org/flake-registry.json
            nix = {
              from = {
                id = "nix";
                type = "indirect";
              };
              to = {
                owner = "NixOS";
                repo = "nix";
                type = "github";
              };
            };
            templates = {
              from = {
                id = "nix";
                type = "indirect";
              };
              to = {
                owner = "NixOS";
                repo = "templates";
                type = "github";
              };
            };
            ## Use inpure path instead of exact path to minimize rebuilds
            hanekokoro-flake = {
              from = {
                id = "hanekokoro-flake";
                type = "indirect";
              };
              to = {
                owner = "ShadowRZ";
                repo = "hanekokoro-flake";
                type = "github";
              };
            };
          };
        };
      };
    };
  };
}
