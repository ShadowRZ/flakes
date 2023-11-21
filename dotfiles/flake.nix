{
  description = "Hanekokoro OS / Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      shared = import ./home-configuration.nix;
    in {
      hmModules = {
        inherit shared;
        shadowrz = import ./shadowrz/home-configuration.nix;
      };
      homeConfigurations = {
        root = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            self.hmModules.shared
            {
              home = {
                username = "root";
                homeDirectory = "/root";
              };
            }
          ];
        };
        shadowrz = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            self.hmModules.shared
            self.hmModules.shadowrz
            {
              home = {
                username = "shadowrz";
                homeDirectory = "/home/shadowrz";
              };
            }
          ];
        };
      };
    };
}
