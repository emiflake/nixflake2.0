return {
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      table.insert(opts.servers.efm.filetypes, 'lua')

      opts.servers.efm.settings.languages.lua = { require('efmls-configs.formatters.stylua') }
    end,
  },
}
