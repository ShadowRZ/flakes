{ inputs, ... }:
{
  flake = {
    nixOnDroidConfigurations = {
      akasha = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [ ./configuration.nix ];
        pkgs = import inputs.nixpkgs {
          system = "aarch64-linux";
          overlays = [
            inputs.nur.overlay
          ];
        };
      };
    };
  };
}
