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

vim.cmd.colorscheme('nord')
--vim.cmd('highlight! Normal ctermbg=NONE guibg=NONE')

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

-- Lualine
require('lualine').setup {
  options = {
    theme = 'nord'
  },
  sections = {
    lualine_x = {},
    lualine_y = {}
  },
  inactive_sections = {
    lualine_x = {}
  },
}

-- LSP
local lspconfig = require('lspconfig')
vim.lsp.config(
  '*',
  --@type vim.lsp.Config
  {
    capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
  }
)
vim.lsp.enable({
  'rust_analyzer',
  'nixd',
  'clangd'
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
