return {
  {
    'stevearc/overseer.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = false,
    opts = {},

    keys = {
      {
        '<leader>mo',
        function()
          vim.cmd('OverseerOpen')
        end,
        desc = 'Overseer',
      },
      {
        '<leader>ml',
        function()
          vim.cmd('OverseerLoadBundle')
        end,
        desc = 'Overseer Load Bundle',
      },
      {
        '<leader>ms',
        function()
          vim.cmd('OverseerSaveBundle')
        end,
        desc = 'Overseer Save Bundle',
      },
      {
        '<leader>mr',
        function()
          vim.cmd('OverseerRun')
        end,
        desc = 'Overseer Run',
      },
    },
  },
}
