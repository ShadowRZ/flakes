{ inputs }:
inputs.nix-on-droid.lib.nixOnDroidConfiguration {
  modules = [
    ./nix-on-droid.nix
    {
      nix = {
        nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
        registry = { nixpkgs.flake = inputs.nixpkgs; };
      };
      home-manager = {
        useGlobalPkgs = true;
        config.imports = with inputs; [
          self.homeModules.default
          self.homeModules.shadowrz
          nix-indexdb.hmModules.nix-index
          { programs.nix-index-database.comma.enable = true; }
        ];
      };
    }
  ];
}
