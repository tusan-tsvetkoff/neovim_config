return {
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		opts = {
			commentStyle = { italic = false },
			keywordStyle = { italic = false, bold = true },
			theme = "dragon",
			background = {
				dark = "dragon",
			},
		},
		config = function(_, opts)
			require("kanagawa").setup(opts)
			vim.cmd("colorscheme kanagawa-dragon")
		end,
	},
}
