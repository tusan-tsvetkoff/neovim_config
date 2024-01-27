return
{
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "petertriho/cmp-git",
      }
    },
    { "j-hui/fidget.nvim", opts = {} }
  },
  config = function()
    local cmp_lsp = require("cmp_nvim_lsp")
    local cap = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities())
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "vimls",
        "lua_ls"
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = cap,
          }
        end,
        ["lua_ls"] = function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = cap,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          }
        end,

      }
    })

    local cmp = require("cmp")
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-Space>"] = cmp.mapping.complete(cmp_select),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-y>"] = cmp.mapping.confirm({
          select = true,
        }),
        ["<Tab>"] = nil,
        ["<S-Tab>"] = nil,
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "cmdline" },
        { name = "luasnip" },
        { name = "cmp-git" },
      },
    })

    vim.diagnostic.config({
      float = {
        source = "always",
        border = "rounded",
        header = "🐛  Diagnostics",
        prefix = " ",
        style = "minimal"
      },
      underline = true,
      virtual_text = true,
      signs = true,
      update_in_insert = true,
    })
  end
}
