return {
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	"eandrju/cellular-automaton.nvim",
	"github/copilot.vim",
	{ "numToStr/Comment.nvim", opts = {} },
	{ "b0o/schemastore.nvim" },
	{ "justinsgithub/wezterm-types" },
	{
		-- Handle dotnet packages and references
		"JesperLundberg/projektgunnar.nvim",
		dependencies = {
			"echasnovski/mini.pick",
		},
		event = "VeryLazy",
	},
	{ "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
	{ "f-person/git-blame.nvim", opts = {} },
}
