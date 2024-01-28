return {
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		config = function()
			require("trouble").setup({
				icons = true,
			})
			local remap = vim.keymap.set
			remap("n", "<leader>tb", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true })
			remap("n", "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true })
			remap("n", "<leader>tt", "<cmd>TodoTrouble<cr>", { silent = true })
		end,
	},
}
