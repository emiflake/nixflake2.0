return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = function()
    local neogit = require('neogit')
    vim.keymap.set('n', '<leader>gg', neogit.open, { desc = 'Open neogit' })
  end

}
