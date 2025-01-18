return {

  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      table.insert(opts.servers.efm.filetypes, 'zig')
      local fs = require('efmls-configs.fs')
      local formatter = fs.executable('zig')
      local command = string.format('fmt %s', formatter)

      -- opts.servers.efm.settings.languages.zig = { formatCommand = formatter, formatStdin = false }
    end,
    ft = 'zig',
  },
  -- {
  --   'nvim-neotest/neotest',
  --   dependencies = {
  --     { 'lawrence-laz/neotest-zig' }, -- Installation
  --     'nvim-lua/plenary.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --     'antoinemadec/FixCursorHold.nvim',
  --   },
  --   config = function()
  --     require('neotest').setup({
  --       adapters = {
  --         -- Registration
  --         require('neotest-zig')({
  --           dap = {
  --             adapter = 'lldb',
  --           },
  --         }),
  --       },
  --     })
  --   end,
  -- },
}
