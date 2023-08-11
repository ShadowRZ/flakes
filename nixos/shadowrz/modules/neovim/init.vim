" Basics
set title
set number
set mouse=a

" Leader
let mapleader = ';'
let maplocalleader = '\\'

" Netrw
let g:netrw_liststyle = 3 " tree style
let g:netrw_banner = 0 " no banner
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Tab / Spaces / Indent
set tabstop=8 shiftwidth=4 softtabstop=4 expandtab

" Space open / closes folds
nnoremap <Space> za

" Filetype specific settings
augroup filetypedetect
    " Mail
    autocmd BufRead,BufNewFile *mutt-* setfiletype mail
    autocmd BufRead,BufNewFile *mutt-* set tw=72
    autocmd BufRead,BufNewFile .git/COMMIT_EDITMSG set tw=72
    autocmd FileType nix set shiftwidth=2 softtabstop=2
augroup END

" Lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename' ] ],
      \   'right': [],
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFilename()
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let modified = &modified ? ' +' : ''
    return filename . modified
endfunction

set background=dark
" Under a environment where $DISPLAY or $WAYLAND_DISPLAY is set or under Termux
if has_key(environ(), "DISPLAY") || has_key(environ(), "WAYLAND_DISPLAY") || has_key(environ(), "TERMUX_VERSION")
    set termguicolors
    " Nord
    colorscheme nord
    let g:lightline.colorscheme = 'nord'
endif

" Tree Sitter
lua << EOF
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
        },
    incremental_selection = {
        enable = true,
        },
    indent = {
        enable = true,
        }
    }
EOF
