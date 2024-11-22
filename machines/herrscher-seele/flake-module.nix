{ inputs, ... }: {
  flake = {
    nixosConfigurations = {
      herrscher-seele = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [ ./configuration.nix ];
      };
    };
  };
}
