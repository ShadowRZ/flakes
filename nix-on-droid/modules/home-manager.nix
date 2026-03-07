{
  flake.modules = {
    nixOnDroid = {
      base = _: {
        ## Home Manager
        home-manager = {
          useGlobalPkgs = true;
          config = {
            imports = [
              {
                manual.manpages.enable = false;
              }
            ];
          };
        };
      };
    };
  };
}
