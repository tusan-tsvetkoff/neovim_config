return {
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		opts = {
			theme = "dragon",
			background = {
				dark = "dragon"
			},
		},
		config = function()
			require("kanagawa").setup(_, opts)
			vim.cmd("colorscheme kanagawa-dragon")
		end
	}
}
