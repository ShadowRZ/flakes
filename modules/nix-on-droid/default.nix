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
          modules =
            with config.flake.modules.nix-on-droid;
            [
              base
              nix
            ]
            + [
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
