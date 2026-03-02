if require('utils').is_vscode() then
  return {}
end

return {
  {
    enabled = os.getenv('NVIM_DEV') == nil,
    'supermaven-inc/supermaven-nvim',
    event = 'InsertEnter',
    opts = {
      keymaps = {
        accept_suggestion = '<Tab>',
      },
      color = {
        suggestion_color = '#585b70',
      },
      log_level = 'off',
    },
    keys = {
      {
        '<leader>ts',
        function()
          local api = require('supermaven-nvim.api')
          if api.is_running() then
            api.stop()
            print('Disabled Supermaven')
          else
            api.start()
            print('Enabled Supermaven')
          end
        end,
        desc = '[T]oggle [S]upermaven',
      },
    },
  },
  {
    'folke/sidekick.nvim',
    event = 'BufReadPost',
    opts = {
      cli = {
        watch = true,       -- Explicitly enable file watching for CLI tool changes
        mux = {
          backend = 'tmux', -- Use zellij instead of old tmux
          enabled = true,
          create = 'split',
        },
      },
    },
    keys = {
      {
        '<leader>at',
        function()
          require('sidekick.cli').toggle()
        end,
        desc = 'Sidekick Toggle',
        mode = { 'n', 't', 'i', 'x' },
      },
      {
        '<leader>aa',
        function()
          require('sidekick.cli').toggle()
        end,
        desc = 'Sidekick Toggle CLI',
      },
      {
        '<leader>as',
        function()
          require('sidekick.cli').select({ filter = { installed = true } })
        end,
        desc = 'Select CLI',
      },
      {
        '<leader>ad',
        function()
          require('sidekick.cli').close()
        end,
        desc = 'Detach a CLI Session',
      },
      {
        '<leader>ai',
        function()
          require('sidekick.cli').send({ msg = '{this}' })
        end,
        mode = { 'x', 'n' },
        desc = 'Send This',
      },
      {
        '<leader>af',
        function()
          require('sidekick.cli').send({ msg = '{file}' })
        end,
        desc = 'Send File',
      },
      {
        '<leader>av',
        function()
          require('sidekick.cli').send({ msg = '{selection}' })
        end,
        mode = { 'x' },
        desc = 'Send Visual Selection',
      },
      {
        '<leader>ap',
        function()
          require('sidekick.cli').prompt()
        end,
        mode = { 'n', 'x' },
        desc = 'Sidekick Select Prompt',
      },
    },
  },
}
