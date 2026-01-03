vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {".git/COMMIT_EDITMSG"},
  callback = function(ev) vim.bo.textwidth = 72 end
})
