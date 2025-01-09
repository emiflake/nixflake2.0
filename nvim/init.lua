vim.keymap.set('n', '<Space>', '<nop>')
vim.g.mapleader = '<Space>'

require("config.lazy")

vim.opt.clipboard = 'unnamedplus'


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>bb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>lr', builtin.lsp_references)
vim.keymap.set('n', '<leader>ls', builtin.lsp_workspace_symbols)
vim.keymap.set('n', '<leader>lt', builtin.lsp_type_definitions)
vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions)
vim.keymap.set('n', '<leader>pf', builtin.git_files)

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.wo.number = true

local neogit = require('neogit')
vim.keymap.set('n', '<leader>gg', neogit.open, { desc = 'Open neogit' })
