return {
  {
    'nvim-neotest/neotest',
    keys = {
      {
        '<leader>gt',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run tests',
      },
    },
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
}
