return {
  { "folke/neodev.nvim", opts = {} },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
        cmd = {
          "Mason",
          "MasonInstall",
          "MasonInstallAll",
          "MasonUpdate",
          "MasonUninstall",
          "MasonUninstallAll",
          "MasonLog",
        },
        dependencies = {
          "williamboman/mason-lspconfig.nvim",
          config = function()
            require("configs.lsp.mason")
          end,
        },
      },
      {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdLineEnter" },
        config = function()
          local cmp = require("cmp")

          cmp.setup.cmdline(":", {
            autocomplete = { cmp.TriggerEvent.TextChanged },
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
              { name = "path", option = { trailing_slash = true } },
            }, {
              { name = "cmdline", length = 3 },
            }),
          })
          cmp.setup.filetype("help", {
            window = {
              documentation = cmp.config.disable,
            },
          })
          ---@diagnostic disable-next-line: different-requires
          require("configs.lsp.cmp")
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
        dependencies = {
          -- 'hrsh7th/cmp-nvim-lua',
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-cmdline",
          "saadparwaiz1/cmp_luasnip",
          "petertriho/cmp-git",
          "onsails/lspkind.nvim",
        },
      },
      {
        "stevearc/conform.nvim",
        event = { "BufWritePre", "BufNewFile" },
        opts = {
          formatters_by_ft = {
            ["markdown"] = { "prettier", "markdownlint" },
            ["lua"] = { "stylua" },
            ["json"] = { "prettier" },
            ["yaml"] = { "prettier" },
            ["toml"] = { "prettier" },
            ["html"] = { "prettier" },
            ["css"] = { "prettier" },
            ["scss"] = { "prettier" },
            ["javascript"] = { "prettier", "dprint" },
            ["cs"] = { "csharpier" },
          },
          formatters = {
            dprint = {
              condition = function(_, ctx)
                return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
              end,
            },
            csharpier = {
              command = "dotnet-csharpier",
              args = { "--write-stdout" },
            },
            prettierd = {
              command = "prettierd",
              args = { "-w" },
            },
          },
        },
        config = function(_, opts)
          require("conform").setup(opts)
          -- Customize the "injected" formatter
          require("conform").formatters.injected = {
            -- Set the options field
            options = {
              -- Set individual option values
              ignore_errors = true,
              lang_to_formatters = {
                json = { "jq" },
              },
            },
          }
          vim.keymap.set({ "n", "v" }, "<leader>f", function()
            require("conform").format({ async = false, timeout_ms = 500, lsp_fallback = true })
          end, { silent = true })
        end,
      },
      {
        "j-hui/fidget.nvim",
        config = function()
          require("fidget").setup({})
        end,
      },
    },
    config = function()
      require("configs.lsp.lspconfig")
    end,
  },
}
