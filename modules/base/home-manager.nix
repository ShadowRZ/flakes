{ inputs, ... }:
{
  flake.modules = {
    nixos = {
      base = {
        imports = [ inputs.home-manager.nixosModules.home-manager ];

        ## Home Manager
        home-manager = {
          useUserPackages = true;
          useGlobalPkgs = true;
        };
      };
    };

    nixOnDroid = {
      base = {
        ## Home Manager
        home-manager = {
          useGlobalPkgs = true;
        };
      };
    };

    homeManager = {
      base = {
        manual.manpages.enable = false;
      };
    };
  };
}
