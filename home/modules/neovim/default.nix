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
      nvim-cmp
      cmp-nvim-lsp
      luasnip
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
}
