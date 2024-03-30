{ inputs }:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = { inherit inputs; };
  modules = [
    ./nixos-wsl.nix
    inputs.home-manager.nixosModules.default
    {
      nix = {
        settings.nix-path = [ "nixpkgs=${inputs.nixpkgs}" ];
        registry = { nixpkgs.flake = inputs.nixpkgs; };
      };
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.shadowrz = {
          imports = with inputs; [
            self.homeModules.default
            self.homeModules.shadowrz
          ];
        };
      };
    }
  ];
}
