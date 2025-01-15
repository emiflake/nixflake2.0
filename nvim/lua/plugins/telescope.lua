return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim', 'folke/trouble.nvim' },
    opts = {
      pickers = {
        buffers = {
          sort_mru = true,
        },
      },
    },
    keys = {
      {
        '<leader>ff',
        function()
          require('telescope.builtin').find_files()
        end,
        desc = 'Find files',
      },
      {
        '<leader>/',
        function()
          require('telescope.builtin').live_grep()
        end,
        desc = 'Live grep',
      },
      {
        '<leader>bb',
        function()
          require('telescope.builtin').buffers()
        end,
        desc = 'Buffers',
      },
      {
        '<leader>fh',
        function()
          require('telescope.builtin').help_tags()
        end,
        desc = 'Help tags',
      },
      {
        '<leader>lr',
        function()
          require('telescope.builtin').lsp_references()
        end,
        desc = 'LSP references',
      },
      {
        '<leader>ls',
        function()
          require('telescope.builtin').lsp_workspace_symbols()
        end,
        desc = 'LSP workspace symbols',
      },
      {
        '<leader>lt',
        function()
          require('telescope.builtin').lsp_type_definitions()
        end,
        desc = 'LSP type definitions',
      },
      {
        '<leader>gd',
        function()
          require('telescope.builtin').lsp_definitions()
        end,
        desc = 'LSP definitions',
      },
      {
        '<leader>pf',
        function()
          require('telescope.builtin').git_files()
        end,
        desc = 'Git files',
      },
      {
        '<leader>tt',
        function()
          require('telescope.builtin').diagnostics()
        end,
        desc = 'Diagnostics',
      },
      {
        '<leader>ed',
        function()
          vim.cmd(':e ~/.config/nvim/init.lua')
        end,
        desc = 'Edit init.lua',
      },
    },
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  },
  {
    'jvgrootveld/telescope-zoxide',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      {
        '<leader>pp',
        function()
          require('telescope').extensions.zoxide.list()
        end,
        desc = 'Zoxide',
      },
    },
  },
}
