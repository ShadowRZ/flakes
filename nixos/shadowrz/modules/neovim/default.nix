{ lib, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    extraConfig = ''
      ${builtins.readFile ./init.vim}
    '';
    plugins = with pkgs.vimPlugins; [
      vim-fugitive
      lightline-vim
      catppuccin-nvim
      # Tree Sitter
      (nvim-treesitter.withPlugins (plugins:
        with plugins; [
          tree-sitter-nix
          tree-sitter-lua
          tree-sitter-rust
          tree-sitter-c
          tree-sitter-cpp
          tree-sitter-python
        ]))
    ];
  };
}
