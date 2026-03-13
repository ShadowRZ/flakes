{ inputs, config, ... }:
{
  flake.modules = {
    # Nixvim Defaults
    nixvim.default = _: {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
      vimdiffAlias = true;

      opts = {
        title = true;
        number = true;
        mouse = "a";
        background = "dark";
        termguicolors = true;

        tabstop = 8;
        shiftwidth = 4;
        softtabstop = 4;
        expandtab = true;
      };

      plugins = {
        treesitter = {
          enable = true;
          highlight.enable = true;
          indent.enable = true;
          folding.enable = true;
        };
        lualine = {
          enable = true;
        };
      };
    };

    # Used to import Nixvim.
    nixos.nixvim = {
      imports = [
        inputs.nixvim.nixosModules.nixvim
      ];

      programs.nixvim = {
        imports = [
          config.partitions.nixvim.module.flake.modules.nixvim.default
        ];

        nixpkgs.useGlobalPackages = true;
      };
    };

    # Used to import Nixvim.
    homeManager.nixvim = {
      imports = [
        inputs.nixvim.homeModules.nixvim
      ];

      programs.nixvim = {
        imports = [
          config.partitions.nixvim.module.flake.modules.nixvim.default
        ];

        nixpkgs.useGlobalPackages = true;
      };
    };
  };
}
