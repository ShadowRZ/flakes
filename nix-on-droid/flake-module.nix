{ inputs, withSystem, ... }:
{
  flake = {
    nixOnDroidConfigurations = {
      akasha = withSystem "aarch64-linux" (
        { pkgs, ... }:
        inputs.nix-on-droid.lib.nixOnDroidConfiguration {
          inherit pkgs;
          modules = [
            ./configuration.nix
            {
              nix = {
                nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
                registry = {
                  nixpkgs.flake = inputs.nixpkgs;
                };
              };
              home-manager = {
                useGlobalPkgs = true;
                config = {
                  imports = [
                    inputs.self.hmModules.default
                    inputs.self.hmModules.shell
                    inputs.nix-indexdb.hmModules.nix-index
                    (
                      { lib, ... }:
                      {
                        programs.nix-index-database.comma.enable = true;
                        programs.direnv.enable = lib.mkForce false;
                        manual.manpages.enable = false;
                      }
                    )
                  ];
                };
              };
            }
          ];
        }
      );
    };
  };
}
