return {
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      table.insert(opts.servers.efm.filetypes, 'rust')
      opts.servers.efm.settings.languages.rust = { require('efmls-configs.formatters.rustfmt') }
    end,
  },
}
