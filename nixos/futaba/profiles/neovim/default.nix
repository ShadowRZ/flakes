{ lib, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    extraConfig = ''
      ${builtins.readFile ./init.vim}
    '';
    plugins = with pkgs.vimPlugins; [
      vim-fugitive
      lightline-vim
      base16-vim
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
