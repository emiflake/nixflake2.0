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

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'Outline',
    'qf',
    'query',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
    'toggleterm',
    'neo-tree',
    'gitsigns-blame',
    'AvanteAsk',
    'AvanteInput',
    'markdown',
  },
  callback = function(event)
    local bo = vim.bo[event.buf]
    if bo.filetype ~= 'markdown' or bo.buftype == 'help' then
      bo.buflisted = false
      vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
    end
  end,
})
