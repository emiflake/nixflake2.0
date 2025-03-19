local choose_formatter = function()
  local cwd = vim.fn.getcwd()
  local has_biome = vim.fn.filereadable(cwd .. '/biome.json')
  return has_biome == 1 and { require('efmls-configs.formatters.biome') }
    or { require('efmls-configs.formatters.prettier_d') }
end

return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'marilari88/neotest-vitest',
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-vitest'),
        },
      })
    end,
  },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      -- formatting
      vim.list_extend(opts.servers.efm.filetypes, {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      })
      opts.servers.efm.settings.languages.javascript = choose_formatter()
      opts.servers.efm.settings.languages.javascriptreact = choose_formatter()
      opts.servers.efm.settings.languages.typescript = choose_formatter()
      opts.servers.efm.settings.languages.typescriptreact = choose_formatter()
    end,
  },

  {
    'mfussenegger/nvim-dap',
    commit = '7ff6936010b7222fea2caea0f67ed77f1b7c60dd',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'mxsdev/nvim-dap-vscode-js',
      -- build debugger from source
    },
    keys = {
      {
        '<leader>dB',
        function()
          require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end,
        desc = 'Breakpoint Condition',
      },
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Toggle Breakpoint',
      },
      {
        '<leader>dc',
        function()
          require('dap').continue()
        end,
        desc = 'Run/Continue',
      },
      {
        '<leader>dC',
        function()
          require('dap').run_to_cursor()
        end,
        desc = 'Run to Cursor',
      },
      {
        '<leader>dg',
        function()
          require('dap').goto_()
        end,
        desc = 'Go to Line (No Execute)',
      },
      {
        '<leader>di',
        function()
          require('dap').step_into()
        end,
        desc = 'Step Into',
      },
      {
        '<leader>dj',
        function()
          require('dap').down()
        end,
        desc = 'Down',
      },
      {
        '<leader>dk',
        function()
          require('dap').up()
        end,
        desc = 'Up',
      },
      {
        '<leader>dl',
        function()
          require('dap').run_last()
        end,
        desc = 'Run Last',
      },
      {
        '<leader>do',
        function()
          require('dap').step_out()
        end,
        desc = 'Step Out',
      },
      {
        '<leader>dO',
        function()
          require('dap').step_over()
        end,
        desc = 'Step Over',
      },
      {
        '<leader>dP',
        function()
          require('dap').pause()
        end,
        desc = 'Pause',
      },
      {
        '<leader>dr',
        function()
          require('dap').repl.toggle()
        end,
        desc = 'Toggle REPL',
      },
      {
        '<leader>ds',
        function()
          require('dap').session()
        end,
        desc = 'Session',
      },
      {
        '<leader>dt',
        function()
          require('dap').terminate()
        end,
        desc = 'Terminate',
      },
      {
        '<leader>dw',
        function()
          require('dap.ui.widgets').hover()
        end,
        desc = 'Widgets',
      },
    },
    config = function()
      require('dap-vscode-js').setup({
        debugger_path = vim.fn.stdpath('data') .. '/lazy/vscode-js-debug',
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      })

      for _, language in ipairs({ 'typescript', 'javascript', 'svelte' }) do
        require('dap').configurations[language] = {
          -- attach to a node process that has been started with
          -- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
          -- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
          {
            -- use nvim-dap-vscode-js's pwa-node debug adapter
            type = 'pwa-node',
            -- attach to an already running node process with --inspect flag
            -- default port: 9222
            request = 'attach',
            -- allows us to pick the process using a picker
            processId = require('dap.utils').pick_process,
            -- name of the debug action you have to select for this config
            name = 'Attach debugger to existing `node --inspect` process',
            -- for compiled languages like TypeScript or Svelte.js
            sourceMaps = true,
            -- resolve source maps in nested locations while ignoring node_modules
            resolveSourceMapLocations = {
              '${workspaceFolder}/**',
              '!**/node_modules/**',
            },
            -- path to src in vite based projects (and most other projects as well)
            cwd = '${workspaceFolder}/src',
            -- we don't want to debug code inside node_modules, so skip it!
            skipFiles = { '${workspaceFolder}/node_modules/**/*.js' },
          },
          {
            type = 'pwa-chrome',
            name = 'Launch Chrome to debug client',
            request = 'launch',
            url = 'http://localhost:5173',
            sourceMaps = true,
            protocol = 'inspector',
            port = 9222,
            webRoot = '${workspaceFolder}/src',
            -- skip files from vite's hmr
            skipFiles = { '**/node_modules/**/*', '**/@vite/*', '**/src/client/*', '**/src/*' },
          },
          -- only if language is javascript, offer this debug action
          language == 'javascript'
              and {
                -- use nvim-dap-vscode-js's pwa-node debug adapter
                type = 'pwa-node',
                -- launch a new process to attach the debugger to
                request = 'launch',
                -- name of the debug action you have to select for this config
                name = 'Launch file in new node process',
                -- launch current file
                program = '${file}',
                cwd = '${workspaceFolder}',
              }
            or {
              type = 'pwa-node',
              request = 'launch',
              name = 'Launch (Node)',
              program = '${file}',
              cwd = '${workspaceFolder}',
              runtimeExecutable = 'npx',
              runtimeArgs = { 'tsx', '--env-file=./.env' },
            },
        }
      end

      require('dapui').setup()
      local dap, dapui = require('dap'), require('dapui')
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open({ reset = true })
      end
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end,
  },
}
