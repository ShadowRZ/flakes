{ config, ... }:
{
  flake.modules = {
    homeManager = {
      dev =
        { pkgs, ... }:
        {
          home.packages = [
            pkgs.just
            pkgs.just-lsp
            pkgs.just-formatter
          ];
        };
    };

    nixos.dev = {
      imports = [
        config.partitions.nixvim.module.flake.modules.nixos.nixvim
      ];
    };
  };
}
