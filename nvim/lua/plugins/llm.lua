if vim.fn.exists('g:vscode') ~= 0 then
  return {
    {},
  }
end

return {
  {
    enabled = os.getenv('NVIM_DEV') == nil,
    'supermaven-inc/supermaven-nvim',
    event = 'InsertEnter',
    opts = {
      keymaps = {
        accept_suggestion = '<C-M-Enter>',
      },
      color = {
        -- TODO: use onedark.nvim
        suggestion_color = '#585b70',
      },
      log_level = 'off',
    },
    keys = {
      {
        '<leader>ts',
        function()
          local suggestion = require('supermaven-nvim.completion_preview')
          if suggestion.disable_inline_completion then
            suggestion.disable_inline_completion = false
            print('Enabled Supermaven')
          else
            suggestion.disable_inline_completion = true
            print('Disabled Supermaven')
          end
        end,
        desc = '[T]oggle [S]upermaven',
      },
    },
  },
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false,
    ---@type avante.Config
    opts = {
      provider = 'claude',
      providers = {
        claude = {
          endpoint = 'https://api.anthropic.com',
          model = 'claude-3-5-sonnet-20241022',
          extra_request_body = {
            max_tokens = 8192,
            temperature = 0,
          },
        },
      },
    },
    build = 'make',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- Optional dependencies
      'nvim-telescope/telescope.nvim', -- for file selector
      'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
      'nvim-tree/nvim-web-devicons', -- for file icons
      {
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        'MeanderingProgrammer/render-markdown.nvim',
        ---@type render.md.UserConfig
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
}
