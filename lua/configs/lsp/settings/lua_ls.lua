return {
	settings = {
		Lua = {
			completion = { callSnippet = "Replace" },
			hint = { enable = true },
			diagnostics = {
				globals = { "vim" },
				disable = { "missing-fields" },
			},
			telemetry = { enable = false },
			workspace = {
				library = {
					[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
				},
				checkThirdParty = false,
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
}
