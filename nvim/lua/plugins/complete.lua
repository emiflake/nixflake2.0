return {
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    opts = {
      keymap = { preset = 'default' },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },

      completion = {
        accept = { auto_brackets = { enabled = false } },
        -- Show documentation when selecting a completion item
        documentation = { auto_show = true, auto_show_delay_ms = 500, window = { border = 'single' } },

        -- Display a preview of the selected item on the current line
        ghost_text = { enabled = true },
      },
      signature = { enabled = false },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
    opts_extend = { 'sources.default' },
  },
  {
    'echasnovski/mini.snippets',
    config = function()
      local gen_loader = require('mini.snippets').gen_loader
      require('mini.snippets').setup({
        snippets = {
          gen_loader.from_file('~/.config/nvim/snippets/global.json'),
        },
      })
    end,
  },
  {
    'saghen/blink.cmp',
    dependencies = 'echasnovski/mini.snippets',
    opts = {
      snippets = { preset = 'mini_snippets' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
  },
}
