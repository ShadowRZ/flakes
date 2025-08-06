{
  config,
  inputs,
  withSystem,
  ...
}:
{
  flake = {
    nixOnDroidConfigurations = {
      akasha = withSystem "aarch64-linux" (
        { pkgs, ... }:
        inputs.nix-on-droid.lib.nixOnDroidConfiguration {
          inherit pkgs;
          modules = [
            {
              imports = with config.flake.modules.nixOnDroid; [
                base
                nix
                shell
              ];
            }
            {
              home-manager.config = {
                imports = with config.flake.modules.homeManager; [
                  base
                  dev
                  shell
                ];
              };
            }
          ];
        }
      );
    };
  };
}
