if vim.fn.exists('g:vscode') ~= 0 then
  return {
    {},
  }
end

return {
  {
    'nvim-neotest/neotest',
    lazy = false,
    keys = {
      {
        '<leader>gt',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run tests',
      },
      {
        '<leader>tt',
        function()
          require('neotest').output.open({ enter = true, quit_on_focus_loss = true })
        end,
        desc = 'Show output',
      },
      {
        '<leader>tT',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Toggle summary',
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
