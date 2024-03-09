return {
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "TroubleToggle", "Trouble" },
		keys = {
			{ "<leader>tb", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true } },
			{ "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true } },
			{ "<leader>tt", "<cmd>TodoTrouble<cr>", { silent = true } },
		},
		config = function()
			require("trouble").setup({
				icons = true,
			})
		end,
	},
}
