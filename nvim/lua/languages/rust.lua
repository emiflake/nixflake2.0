return {
  {
    'neovim/nvim-lspconfig',
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
}
