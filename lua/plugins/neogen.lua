return {
	"danymat/neogen",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
  keys = {
			{ "<leader>gd", "<cmd>Neogen<CR>", desc = "Generate func|class|type documentation" },
  },
	opts = {
		snippet_engine = "luasnip",
	},
	config = function(_, opts)
		local neogen = require("neogen")
		neogen.setup(opts or {})

		-- vim.keymap.set("n", "<leader>df", function()
		-- 	neogen.generate({ type = "func" })
		-- end)
		--
		-- vim.keymap.set("n", "<leader>dt", function()
		-- 	neogen.generate({ type = "type" })
		-- end)
		--
		-- vim.keymap.set("n", "<leader>dc", function()
		-- 	neogen.generate({ type = "class" })
		-- end)
	end,
}
