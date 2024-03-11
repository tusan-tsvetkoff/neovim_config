return {
  { 'folke/neoconf.nvim', opts = {} },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        cmd = {
          'Mason',
          'MasonInstall',
          'MasonInstallAll',
          'MasonUpdate',
          'MasonUninstall',
          'MasonUninstallAll',
          'MasonLog',
        },
        init = function()
          vim.keymap.set('n', '<leader>f', '<cmd>Format<cr>', { silent = true })
        end,
        dependencies = {
          'williamboman/mason-lspconfig.nvim',
          config = function()
            require 'configs.lsp.mason'
          end,
        },
      },
      {
        'nvimdev/lspsaga.nvim',
        init = function()
          vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<cr>', { silent = true })
          vim.keymap.set('v', '<leader>ca', '<cmd>Lspsaga code_action<cr>', { silent = true })
          vim.keymap.set('n', '<leader>rr', '<cmd>Lspsaga rename<cr>', { silent = true })
        end,
        opts = require 'configs.lsp.lspsaga',
      },
      {
        'hrsh7th/nvim-cmp',
        event = { 'InsertEnter', 'CmdLineEnter' },
        config = function()
          require 'configs.lsp.cmp'
        end,
        dependencies = {
          'hrsh7th/cmp-nvim-lua',
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-cmdline',
          'saadparwaiz1/cmp_luasnip',
          'petertriho/cmp-git',
          'onsails/lspkind.nvim',
        },
      },
      {
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        opts = {
          formatters_by_ft = {
            ['markdown'] = { { 'prettierd', 'prettier' }, 'markdownlint' },
            ['lua'] = { 'stylua' },
            ['json'] = { { 'prettierd', 'prettier' } },
            ['yaml'] = { 'prettierd', 'prettier' },
            ['toml'] = { 'prettierd', 'prettier' },
            ['html'] = { 'prettierd', 'prettier' },
            ['css'] = { 'prettierd', 'prettier' },
            ['scss'] = { 'prettierd', 'prettier' },
            ['javascript'] = { 'dprint', { 'prettierd', 'prettier' } },
            ['cs'] = { 'csharpier' },
          },
          formatters = {
            dprint = {
              condition = function(_, ctx)
                return vim.fs.find({ 'dprint.json' }, { path = ctx.filename, upward = true })[1]
              end,
            },
            csharpier = {
              command = 'dotnet-csharpier',
              args = { '--write-stdout' },
            },
            prettierd = {
              command = 'prettierd',
              args = { '-w' },
            },
          },
        },
      },
      {
        'j-hui/fidget.nvim',
        config = function()
          require('fidget').setup {}
        end,
      },
    },
    config = function()
      require 'configs.lsp.lspconfig'
    end,
  },
}
