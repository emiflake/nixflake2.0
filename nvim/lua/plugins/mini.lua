return {
  'echasnovski/mini.files',
  dependencies = {
    'echasnovski/mini.nvim',
  },
  opts = {
    windows = {
      preview = true,
    },
  },
  keys = {
    {
      '<leader>ft',
      function()
        require('mini.files').open()
      end,
      desc = '[F]ile [T]ree',
    },
  },
}
