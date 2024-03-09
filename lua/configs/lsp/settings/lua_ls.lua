return {
	settings = {
		Lua = {
			completion = {
				callSnippet = "Both",
			},
			hint = {
				enable = true,
				setType = false,
				paramType = true,
				paramName = "Disable",
				semiColon = "Disable",
				arrayIndex = "Disable",
			},
			type = {
				castNumberToInteger = true,
			},
			diagnostics = {
				globals = { "vim" },
				disable = { "missing-fields", "incomplete-signature-doc" },
				groupFileStatus = {
					["ambiguity"] = "Opened",
					["await"] = "Opened",
					["codestyle"] = "None",
					["duplicate"] = "Opened",
					["global"] = "Opened",
					["luadoc"] = "Opened",
					["redefined"] = "Opened",
					["strict"] = "Opened",
					["strong"] = "Opened",
					["type-check"] = "Opened",
					["unbalanced"] = "Opened",
					["unused"] = "Opened",
				},
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
			format = {
				enable = true,
			},
		},
	},
}
