-- Basics
vim.opt.title = true
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.background = 'dark'
vim.opt.termguicolors = true

-- Netrw
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 25

-- Tab / Spaces / Indent
vim.opt.tabstop = 8
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Space open / closes folds
vim.keymap.set('n', '<Space>', 'za')

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {".git/COMMIT_EDITMSG"},
    callback = function(ev) vim.bo.textwidth = 72 end
})
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"nix"},
    callback = function(ev)
        vim.bo.shiftwidth = 2
        vim.bo.softtabstop = 2
    end
})

-- Tree Sitter
require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
    },
    indent = {
        enable = true,
    }
})

-- Everforest

vim.g.everforest_background = 'soft'
vim.cmd.colorscheme('everforest')

require('lualine').setup {
    sections = {
        lualine_x = {},
        lualine_y = {}
    },
    inactive_sections = {
        lualine_x = {}
    },
}
