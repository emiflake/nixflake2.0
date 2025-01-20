return {
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
}
