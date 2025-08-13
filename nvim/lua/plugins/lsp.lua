if vim.fn.exists('g:vscode') ~= 0 then
  return {
    {},
  }
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local function map(key, command, opts)
      local mode = opts.mode or 'n'
      opts.mode = nil
      opts.buffer = ev.buf
      vim.keymap.set(mode, key, command, opts)
    end

    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true, { 0 })
    end

    map('<leader>cL', '<cmd>LspInfo<cr>', { desc = 'Lsp Info' })
    map('gd', function()
      require('telescope.builtin').lsp_definitions({ reuse_win = true })
    end, { desc = 'Goto Definition' })
    map('gr', '<cmd>Telescope lsp_references<cr>', { desc = 'References' })
    map('gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration' })
    map('gi', function()
      require('telescope.builtin').lsp_implementations({ reuse_win = true })
    end, { desc = 'Goto Implementation' })
    map('gI', 'gi', { noremap = true, desc = 'Go to last insert' })
    map('gy', function()
      require('telescope.builtin').lsp_type_definitions({ reuse_win = true })
    end, { desc = 'Goto Type Definition' })
    map('K', vim.lsp.buf.hover, { desc = 'Hover' })
    map('gK', vim.lsp.buf.signature_help, { desc = 'Signature Help' })
    map('<c-k>', vim.lsp.buf.signature_help, { mode = 'i', desc = 'Signature Help' })
    map('<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action', mode = { 'n', 'v' } })
    map('<leader>cA', function()
      vim.lsp.buf.code_action({
        context = {
          only = {
            'source',
          },
          diagnostics = {},
        },
      })
    end, { desc = 'Source Action' })
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Format on save',
  pattern = '*',
  callback = function(args)
    if not vim.api.nvim_buf_is_valid(args.buf) or vim.bo[args.buf].buftype ~= '' then
      return
    end
    if vim.g.disable_autoformat then
      return
    end
    vim.lsp.buf.format({
      filter = function(client)
        return client.name == 'efm'
      end,
    })
  end,
})

local function toggle_format_on_save()
  if vim.g.disable_autoformat == nil then
    vim.g.disable_autoformat = true
    print('Autoformat is now disabled')
  else
    vim.g.disable_autoformat = not vim.g.disable_autoformat
    print('Autoformat is now enabled')
  end
end

return {
  {
    'saecki/live-rename.nvim',
    keys = {
      {
        '<leader>gr',
        function()
          require('live-rename').rename()
        end,
        desc = '[G]o [R]ename symbol',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'creativenull/efmls-configs-nvim', 'saghen/blink.cmp' },
    keys = {
      {
        '<leader>gf',
        function()
          vim.lsp.buf.format({
            filter = function(client)
              return client.name == 'efm'
            end,
          })
        end,
        desc = '[G]o [F]ormat',
      },
      {
        '<leader>sd',
        vim.diagnostic.open_float,
        desc = '[S]how [D]iagnostics',
      },
      {
        '<leader>uf',
        toggle_format_on_save,
        desc = 'Toggle format on save',
      },
    },
    -- example using `opts` for defining servers
    opts = {
      inlay_hints = { enabled = true },
      servers = {
        -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
        efm = {
          filetypes = {},
          settings = {
            version = 2,
            rootMarkers = { '.git/' },
            languages = {
              haskell = {},
            },
          },
          init_options = {
            documentFormatting = true,
            documentRangeFormatting = true,
          },
        },
        zls = {},
        ts_ls = {},
        eslint = {},
        ---@type vim.lsp.ClientConfig
        lua_ls = {
          cmd = { 'lua-language-server' },
          ---@param client vim.lsp.Client
          on_init = function(client)
            local path = vim.split(package.path, ';')
            table.insert(path, 'lua/?.lua')
            table.insert(path, 'lua/?/init.lua')

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
              runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                path = path,
              },

              telemetry = { enable = false },
              -- Make the server aware of Neovim runtime files
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                  vim.fn.expand('$HOME/.local/share/nvim/lazy/blink.cmp/lua/'),
                  vim.fn.expand('$HOME/.local/share/nvim/lazy/avante.nvim/lua/'),
                  vim.fn.expand('$HOME/.local/share/nvim/lazy/nvim-lspconfig/lua/'),
                  vim.fn.stdpath('config'),
                },
                maxPreload = 100,
                preloadFileSize = 1000,
              },
              completion = {
                callSnippet = 'Replace',
              },
            })
          end,
          settings = {
            Lua = {
              hint = { enable = true },
              diagnostics = {
                globals = { 'vim' },
              },
            },
          },
        },
        hls = {
          cmd = { 'haskell-language-server', '--lsp' },
        },
      },
    },
    config = function(_, opts)
      local lspconfig = require('lspconfig')
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    lazy = false,
    keys = {
      {
        '<leader>!',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
    },
    opts = {
      modes = {
        diagnostics = {
          -- auto_open = true,
          -- auto_close = true,
        },
      },
    },
  },
  {
    'aznhe21/actions-preview.nvim',
    config = function()
      vim.keymap.set({ 'v', 'n' }, 'gf', require('actions-preview').code_actions)
    end,
  },
  {
    'hedyhli/outline.nvim',
    keys = {
      { '<leader>lo', mode = { 'n' }, '<cmd>Outline<CR>', desc = 'Toggle Outline' },
    },
    opts = {},
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({
        ui = {
          lightbulb = {
            enable = false,
            enable_in_insert = false,
          },
          code_action = '',
        },
      })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons', -- optional
    },
  },
}
