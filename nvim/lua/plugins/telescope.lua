return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim', 'folke/trouble.nvim' },
    opts = {
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
        buffers = {
          sort_mru = true,
        },
      },
    },
    keys = {
      {
        '<leader>ff',
        function()
          require('telescope.builtin').find_files()
        end,
        desc = '[F]ind [F]iles',
      },
      {
        '<leader>/',
        function()
          require('telescope.builtin').live_grep()
        end,
        desc = 'Live grep',
      },
      {
        '<leader>bb',
        function()
          require('telescope.builtin').buffers()
        end,
        desc = 'Find [B]uffers',
      },
      {
        '<leader>fh',
        function()
          require('telescope.builtin').help_tags()
        end,
        desc = '[F]ind [H]elp tags',
      },
      {
        '<leader>lr',
        function()
          require('telescope.builtin').lsp_references()
        end,
        desc = '[L]SP [R]eferences',
      },
      {
        '<leader>ls',
        function()
          require('telescope.builtin').lsp_workspace_symbols()
        end,
        desc = '[L]SP [S]ymbols',
      },
      {
        '<leader>lt',
        function()
          require('telescope.builtin').lsp_type_definitions()
        end,
        desc = '[L]SP [T]ype definitions',
      },
      {
        '<leader>pf',
        function()
          local utils = require('telescope.utils')
          local builtin = require('telescope.builtin')

          local project_files = function()
            local _, ret, _ = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' })
            if ret == 0 then
              builtin.git_files()
            else
              builtin.find_files()
            end
          end
          project_files()
        end,
        desc = '[P]roject [F]iles',
      },
      {
        '<leader>fd',
        function()
          require('telescope.builtin').diagnostics()
        end,
        desc = '[F]ind [D]iagnostics',
      },
      {
        '<leader>ed',
        function()
          vim.cmd.cd(vim.fn.expand('~/.config/nvim'))
          vim.cmd(':e ' .. vim.fn.expand('~/.config/nvim/init.lua'))
        end,
        desc = '[E]dit editor [D]efinitions',
      },
      {
        '<leader>fC',
        function()
          require('telescope.builtin').colorscheme()
        end,
        desc = '[F]ind [C]olorscheme',
      },
    },
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    command = 'Telescope file_browser',
  },
  {
    'jvgrootveld/telescope-zoxide',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      {
        '<leader>pp',
        function()
          local actions = require('telescope.actions')
          local action_state = require('telescope.actions.state')
          -- First we use zoxide to pick the project root, then we use telescope to find files in one go
          require('telescope').extensions.zoxide.list({
            attach_mappings = function(_, _)
              local default_action = actions.select_default
              actions.select_default:replace(function()
                -- We still want to select the entry
                vim.cmd.cd(action_state.get_selected_entry().value)
                require('telescope.builtin').find_files({
                  prompt_title = 'Project Files',
                  cwd = action_state.get_selected_entry().value,
                })
              end)
              return true
            end,
          })
        end,
        desc = '[P]roject [P]opup',
      },
    },
  },
}
