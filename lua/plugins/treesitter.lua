return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        commit = '6c30f3c8915d7b31c3decdfe6c7672432da1809d',
      },
      'nvim-treesitter/nvim-treesitter-textobjects',
      -- HACK: remove when https://github.com/windwp/nvim-ts-autotag/issues/125 closed.
      { 'windwp/nvim-ts-autotag', opts = { enable_close_on_slash = false } },
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'bash',
          'gitignore',
          'sql',
          'gitcommit',
          'http',
          'vimdoc',
          'javascript',
          'typescript',
          'c',
          'lua',
          'c_sharp',
          'rust',
          'diff',
          'jsdoc',
          'json',
          'jsonc',
          'html',
          'css',
          'yaml',
          'luadoc',
          'markdown',
          'markdown_inline',
        },
        sync_install = false,
        auto_install = true,
        autotag = { enable = true },
        context_commentstring = { enable = true, enable_autocmd = false },

        indent = {
          enable = true,
        },

        highlight = {
          enable = true,
        },

        textobjects = {
          swap = {
            enable = true,
            swap_next = {
              ['>K'] = { query = '@block.outer', desc = 'Swap next block' },
              ['>F'] = { query = '@function.outer', desc = 'Swap next function' },
              ['>A'] = { query = '@parameter.inner', desc = 'Swap next argument' },
            },
            swap_previous = {
              ['<K'] = { query = '@block.outer', desc = 'Swap previous block' },
              ['<F'] = { query = '@function.outer', desc = 'Swap previous function' },
              ['<A'] = { query = '@parameter.inner', desc = 'Swap previous argument' },
            },
          },
        },
      })

      local treesitter_parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      ---@diagnostic disable-next-line: inject-field
      treesitter_parser_config.templ = {
        install_info = {
          url = 'https://github.com/vrischmann/tree-sitter-templ.git',
          branch = 'master',
        },
      }
      vim.treesitter.language.register('templ', 'templ')
    end,
  },
}
