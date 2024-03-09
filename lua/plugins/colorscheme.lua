return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					operators = false,
					folds = false,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
			vim.cmd("colorscheme gruvbox")
		end,
	},
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	name = "kanagawa",
	-- 	opts = {
	-- 		commentStyle = { italic = false },
	-- 		keywordStyle = { italic = false, bold = true },
	-- 		theme = "dragon",
	-- 		background = {
	-- 			dark = "dragon",
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("kanagawa").setup(opts)
	-- 		vim.cmd("colorscheme kanagawa-dragon")
	-- 	end,
	-- },
}
