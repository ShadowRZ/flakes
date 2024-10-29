{ inputs, ... }: {
  flake = {
    nixosConfigurations = {
      mononekomi = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [ ../hosts/mononekomi/configuration.nix ];
      };
    };
  };
}
