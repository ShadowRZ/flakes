{ lib, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    package = pkgs.neovim-nightly;
    extraConfig = ''
      ${builtins.readFile ./vimrc.vim}
      " -- 8< -- Lua
      lua << EOF
      ${builtins.readFile ./nvim.lua}
      EOF
    '';
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      vim-fugitive
      lightline-vim
      base16-vim
      # nvim-cmp
      nvim-cmp
      cmp-nvim-lsp
      luasnip
      # Tree Sitter
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          tree-sitter-nix
          tree-sitter-lua
          tree-sitter-rust
        ]
      ))
    ];
  };
}
