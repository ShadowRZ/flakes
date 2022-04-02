" Basics
set title
set number
set mouse=a
set background=light

" Leader
let mapleader = ';'
let maplocalleader = '\\'

" Netrw
let g:netrw_liststyle = 3 " tree style
let g:netrw_banner = 0 " no banner
let g:netrw_browse_split = 3 " new tab

" Under a environment where $DISPLAY is set
if has_key(environ(), "DISPLAY")
    set termguicolors
endif

" Tab / Spaces / Indent
set tabstop=8 shiftwidth=4 softtabstop=4 expandtab

nnoremap <Space> za

set background=light
colorscheme base16-summerfruit-light
