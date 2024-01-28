return {
	{ "folke/neoconf.nvim", opts = {} },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
			{
				"hrsh7th/nvim-cmp",
				event = { "InsertEnter", "CmdLineEnter" },
				dependencies = {
					"hrsh7th/cmp-nvim-lua",
					"hrsh7th/cmp-nvim-lsp",
					"hrsh7th/cmp-buffer",
					"hrsh7th/cmp-path",
					"hrsh7th/cmp-cmdline",
					"saadparwaiz1/cmp_luasnip",
					"petertriho/cmp-git",
					"folke/neodev.nvim",
				},
			},
			{
				"mfussenegger/nvim-lint",
				enabled = false,
				opts = {},
				config = function()
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						callback = function()
							require("lint").try_lint()
						end,
					})
				end,
			},
			{
				"stevearc/conform.nvim",
				event = { "BufWritePre" },
				opts = {
					formatters_by_ft = {
						lua = { "stylua" },
						json = { "prettier", "prettierd" },
					},
				},
			},
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			local cmp_lsp = require("cmp_nvim_lsp")
			local cap = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)
			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, silent = true }
				if client.supports_method("textDocument/documentHighlight") then
					vim.api.nvim_create_augroup("lsp_document_highlight", {
						clear = false,
					})
					vim.api.nvim_clear_autocmds({
						buffer = bufnr,
						group = "lsp_document_highlight",
					})
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						group = "lsp_document_highlight",
						buffer = bufnr,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						group = "lsp_document_highlight",
						buffer = bufnr,
						callback = vim.lsp.buf.clear_references,
					})
				end
				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, opts)
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover()
				end, opts)
				vim.keymap.set("n", "<leader>do", function()
					vim.diagnostic.open_float()
				end, opts)
				vim.keymap.set("n", "<leader>ca", function()
					vim.lsp.buf.code_action()
				end, opts)
				vim.keymap.set("n", "<leader>rr", function()
					vim.lsp.buf.rename()
				end, opts)
				vim.keymap.set("n", "<leader>rf", function()
					vim.lsp.buf.references()
				end, opts)
				vim.keymap.set("n", "gi", function()
					vim.lsp.buf.implementation()
				end, opts)
				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, opts)
				vim.keymap.set("n", "<leader>f", "<cmd>Format<cr>", { silent = true })
				-- vim.lsp.buf.format { async = true }
			end
			require("mason").setup()
			require("neodev").setup()

			require("mason-lspconfig").setup({
				ensure_installed = {
					"jsonls",
					"vimls",
					"lua_ls",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = cap,
							on_attach = on_attach,
						})
					end,
					["lua_ls"] = function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = cap,
							on_attach = on_attach,
							settings = {
								Lua = {
									-- semantic = { enable = false },
									hint = { enabled = true },
									workspace = { checkThirdParty = false },
									telemetry = { enable = false },
									diagnostics = {
										globals = { "vim" },
										disable = { "missing-fields" },
									},
								},
							},
						})
					end,
					["jsonls"] = function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = cap,
							on_attach = on_attach,
							settings = {
								json = {
									schemas = require("schemastore").json.schemas(),
									validate = { enable = true },
								},
							},
						})
					end,
				},
			})

			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-Space>"] = cmp.mapping.complete(cmp_select),
					["<C-e>"] = cmp.mapping.close(),
					["<C-l>"] = cmp.mapping.confirm({
						select = true,
					}),
				}),
				sources = {
					{ name = "nvim_lua" },
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "buffer", keyword_length = 5 },
					{ name = "cmdline" },
					{ name = "cmp-git" },
				},
			})

			local signs = { Error = "", Warn = "", Hint = "󰌵", Info = "" }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			vim.diagnostic.config({
				float = {
					focusabe = false,
					source = "always",
					border = "rounded",
					header = "🐛 Diagnostics",
					prefix = " ",
					style = "minimal",
				},
				severity_sort = true,
				underline = true,
				virtual_text = true,
				signs = {
					active = signs,
				},
				update_in_insert = true,
			})

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "rounded",
			})
		end,
	},
}
