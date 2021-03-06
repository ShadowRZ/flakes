{ lib, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    package = pkgs.neovim-nightly;
    extraConfig = ''
      set title
      set number
      set termguicolors
      set mouse=a
      set background=light
      let mapleader = ';'
      let maplocalleader = '\\'
      set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
      let g:netrw_liststyle = 3 " tree style
      let g:netrw_banner = 0 " no banner
      let g:netrw_browse_split = 3 " new tab
      let g:airline_theme = 'deus'
      if has_key(environ(), "DISPLAY")
          let g:airline_powerline_fonts = 1
      endif
      set tabstop=2 shiftwidth=2 expandtab smarttab
      " completion
      inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
      inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
      set completeopt=menuone,noinsert,noselect
      set shortmess+=c
    '';
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      completion-nvim
      vim-nix
      vim-lastplace
      vim-autoformat
      vim-airline
      vim-airline-themes
    ];
  };
}
