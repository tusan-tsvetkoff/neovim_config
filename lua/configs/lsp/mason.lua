local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local on_attach = require("configs.lsp").on_attach
local capabilities = require("configs.lsp").capabilities

local ok_neoconf, neoconf = pcall(require, "neoconf")
if ok_neoconf then
	print("Neoconf loaded")
	neoconf.setup({})
end

local ok_neodev, neodev = pcall(require, "neodev")
if ok_neodev then
	print("Neodev loaded")
	neodev.setup(require("configs.lsp.neodev"))
end

mason.setup({
	ui = {
		-- Whether to automatically check for new versions when opening the :Mason window.
		check_outdated_packages_on_open = false,
		icons = {
			package_pending = " ",
			package_installed = " ",
			package_uninstalled = " ",
		},
	},
	-- install_root_dir = path.concat { vim.fn.stdpath "config", "/lua/custom/mason" },
})

mason_lspconfig.setup({
	automatic_installation = true,
	ensure_installed = {
		-- Lua
		"lua_ls",
		"vimls",

		-- Web Development
		-- "cssls",
		-- "html",
		-- "tsserver",
		-- "denols",
		-- "vuels",
		-- "tailwindcss",
		-- "emmet_language_server",

		-- PHP
		-- "intelephense",

		-- C/C++
		-- "clangd",

		-- CMake
		-- "neocmake",

		-- Java
		-- "jdtls",

		-- Yaml
		-- "yamlls",

		-- Python
		-- "pyright",

		-- Go
		-- "gopls",

		-- C#
		"omnisharp",
	},
})

local disabled_servers = {
	"jdtls",
	"tsserver",
}

mason_lspconfig.setup_handlers({
	-- Automatically configure the LSP installed
	function(server_name)
		for _, name in pairs(disabled_servers) do
			if name == server_name then
				return
			end
		end
		local opts = {
			on_attach = on_attach,
			capabilities = capabilities,
		}

		local require_ok, server = pcall(require, "configs.lsp.settings." .. server_name)
		if require_ok then
			opts = vim.tbl_deep_extend("force", server, opts)
		end

		require("lspconfig")[server_name].setup(opts)
	end,
})
