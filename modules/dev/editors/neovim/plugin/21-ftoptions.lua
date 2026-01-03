vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = {"nix"},
  callback = function(ev)
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end
})
