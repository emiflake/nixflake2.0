require('neovide')

require('config.lazy')

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.autochdir = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.wo.number = true

vim.keymap.set({ 'n', 'v' }, '<leader>z', function()
  require('ssr').open()
end, { desc = 'Treesitter search and replace' })

vim.api.nvim_set_keymap('i', '<C-Enter>', '<C-y>', {})
