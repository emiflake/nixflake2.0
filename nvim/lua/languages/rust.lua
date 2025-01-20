return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'SmiteshP/nvim-navic' },
    opts = function(_, opts)
      table.insert(opts.servers.efm.filetypes, 'rust')
      opts.servers.efm.settings.languages.rust = { require('efmls-configs.formatters.rustfmt') }
    end,
  },
  {
    'nvim-neotest/neotest',
    dependencies = { 'mrcjkb/rustaceanvim' },
    opts = function(_, opts)
      opts.adapters = {
        require('rustaceanvim.neotest'),
      }
    end,
  },
  { 'mrcjkb/rustaceanvim', lazy = false },
  {
    'saecki/crates.nvim',
    dependencies = { 'saghen/blink.compat', opts = { impersonate_nvim_cmp = true } },
    tag = 'stable',
    opts = {
      completion = {
        crates = { enabled = true },
        cmp = { enabled = true },
      },
    },
    keys = {
      {
        '<leader>gd',
        function()
          vim.cmd('RustLsp openDocs')
        end,
        desc = '[G]o [D]ocs',
      },
    },
  },
  {
    'saghen/blink.cmp',
    dependencies = 'saecki/crates.nvim',
    opts = {
      sources = {
        default = { 'crates' },
        providers = {
          crates = {
            name = 'crates',
            module = 'blink.compat.source',
            fallbacks = { 'lsp' },
          },
        },
      },
    },
  },
}
