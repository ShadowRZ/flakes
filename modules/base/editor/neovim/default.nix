{
  flake.modules = {
    nixos = {
      base = _: {
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
      base =
        { pkgs, ... }:
        {
          programs.neovim = {
            enable = true;
            vimAlias = true;
            viAlias = true;
            vimdiffAlias = true;
            extraLuaConfig = builtins.readFile ./nvim.lua;
            plugins = with pkgs.vimPlugins; [
              lualine-nvim
              nvim-lspconfig
              blink-cmp
              editorconfig-nvim
              rose-pine
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
        };
    };
  };
}
