{ inputs, self, ... }:
{
  flake = {
    nixOnDroidConfigurations = {
      akasha = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [ ./nix-on-droid/configuration.nix ];
        pkgs = import inputs.nixpkgs {
          system = "aarch64-linux";
          overlays = [
            inputs.nur.overlay
            self.overlay
          ];
        };
      };
    };
  };
}
