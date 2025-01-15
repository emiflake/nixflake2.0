return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    event = 'BufRead',
    build = ':TSUpdate',
    opts = {
      -- todo: slow on typescript files?
      highlight = {
        -- only enable if we're not profiling
        enable = os.getenv('NVIM_PROFILE') == nil,
        disable = {},
      },
      indent = { enable = false },
      incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = 'v',
          node_decremental = 'V',
        },
      },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
          },
        },
        move = {
          enable = true,
        },
      },

      auto_install = true,
      ensure_installed = {
        'c',
        'c_sharp',
        'cpp',
        'diff',
        'graphql',
        'haskell',
        'nix',
        'php',
        'python',
        'query',
        'regex',
        'rust',
        'scala',
        'vim',
        'vimdoc',
        -- shells
        'bash',
        'fish',
        -- config langs
        'json',
        'json5',
        'jsonc',
        'yaml',
        'toml',
        'ini',
        'csv',
        'tsv',
        -- doc langs
        'latex',
        'bibtex',
        'rst',
        'markdown',
        'markdown_inline',
        -- git
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
