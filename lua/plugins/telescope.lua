return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				enabled = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		opts = {
			pickers = {
				oldfiles = {
					promp_title = "Recent Files",
				},
				find_files = {
					hidden = true,
				},
			},
      extensions_list = {
        "harpoon",
        "projects"
      }
		},
		config = function(_, opts)
			require("telescope").setup(opts or {})

			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>sp", "<cmd>Telescope projects<cr>", { silent = true })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, {})
			vim.keymap.set("n", "<C-p>", builtin.git_files, {})
			vim.keymap.set("n", "<leader>sWg", function()
				local word = vim.fn.expand("<cWORD>")
				builtin.grep_string({ search = word })
			end)
			vim.keymap.set("n", "<leader>swg", function()
				local word = vim.fn.expand("<cword>")
				builtin.grep_string({ search = word })
			end)
			vim.keymap.set("n", "<leader>sw", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end)
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
		end,
	},
}
