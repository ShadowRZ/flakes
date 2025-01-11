{ inputs, withSystem, ... }:
{
  flake = {
    nixOnDroidConfigurations = {
      akasha = withSystem "x86_64-linux" (
        { pkgs, ... }:
        inputs.nix-on-droid.lib.nixOnDroidConfiguration {
          inherit pkgs;
          modules = [ ./configuration.nix ];
        }
      );
    };
  };
}
