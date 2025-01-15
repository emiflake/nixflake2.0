return {
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      table.insert(opts.servers.efm.filetypes, 'nix')
      opts.servers.rnix = {}
      opts.servers.efm.settings.languages.nix = { require('efmls-configs.formatters.nixfmt') }
    end,
    ft = 'nix',
  },
}
