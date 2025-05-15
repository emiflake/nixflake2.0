return {
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      table.insert(opts.servers.efm.filetypes, 'haskell')

      local fourmolu = require('efmls-configs.formatters.fourmolu')

      opts.servers.efm.settings.languages.haskell = { fourmolu }
    end,
  },
}
