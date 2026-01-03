{
  flake.modules = {
    nixos = {
      dev = _: {
        programs.neovim = {
          enable = true;
          defaultEditor = true;
        };
      };
    };
    nixOnDroid = {
      shell = _: {
        environment.sessionVariables."EDITOR" = "nvim";
      };
    };
    homeManager = {
      dev =
        { pkgs, ... }:
        {
          programs.neovim = {
            enable = true;
            vimAlias = true;
            viAlias = true;
            vimdiffAlias = true;
            plugins = with pkgs.vimPlugins; [
              lualine-nvim
              nvim-lspconfig
              editorconfig-nvim
              catppuccin-nvim
              # Tree Sitter
              (nvim-treesitter.withPlugins (
                plugins: with plugins; [
                  tree-sitter-nix
                  tree-sitter-lua
                  tree-sitter-rust
                  tree-sitter-c
                  tree-sitter-cpp
                  tree-sitter-python
                ]
              ))
            ];
          };

          xdg.configFile = {
            "nvim/plugin" = {
              source = ./plugin;
              recursive = true;
            };
          };
        };
    };
  };
}
