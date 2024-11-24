{ withSystem, inputs, ... }:
{
  flake = {
    nixosConfigurations = {
      herrscher-seele = withSystem "x86_64-linux" (
        { inputs', ... }:
        inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs inputs';
          };
          modules = [ ./configuration.nix ];
        }
      );
    };
  };
}
