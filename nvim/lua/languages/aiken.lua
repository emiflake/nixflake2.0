return {
  {
    "aiken-lang/editor-integration-nvim",
    dependencies = {
      'neovim/nvim-lspconfig',
    }
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        aiken = {},
      }
    }
  },
}
