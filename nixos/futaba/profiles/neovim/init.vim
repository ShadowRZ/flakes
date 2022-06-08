" Basics
set title
set number
set mouse=a
set background=light
colorscheme base16-summerfruit-light

" Leader
let mapleader = ';'
let maplocalleader = '\\'

" Netrw
let g:netrw_liststyle = 3 " tree style
let g:netrw_banner = 0 " no banner
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Under a environment where $DISPLAY is set
if has_key(environ(), "DISPLAY")
    set termguicolors
endif

" Under Termux
if has_key(environ(), "TERMUX_VERSION")
    set termguicolors
endif

" Tab / Spaces / Indent
set tabstop=8 shiftwidth=4 softtabstop=4 expandtab

" Space open / closes folds
nnoremap <Space> za

" Filetype specific settings
augroup filetypedetect
    " Mail
    autocmd BufRead,BufNewFile *mutt-* setfiletype mail
    autocmd BufRead,BufNewFile *mutt-* set tw=72
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
