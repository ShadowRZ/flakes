{ inputs }:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = { inherit inputs; };
  modules = [
    ./nixos-wsl.nix
    inputs.home-manager.nixosModules.default
    {
      nix = {
        nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
        registry = { nixpkgs.flake = inputs.nixpkgs; };
      };
      home-manager = {
        useGlobalPkgs = true;
        sharedModules = with inputs; [
          self.homeModules.default
          self.homeModules.shadowrz
        ];
      };
    }
  ];
}
