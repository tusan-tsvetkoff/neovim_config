return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

		local Tusan_fugitive = vim.api.nvim_create_augroup("Tusan_fugitive", {})

		local autocmd = vim.api.nvim_create_autocmd
		autocmd("BufWinEnter", {
			group = Tusan_fugitive,
			pattern = "*",
			callback = function()
				if vim.bo.ft ~= "fugitive" then
					return
				end

				local bufnr = vim.api.nvim_get_current_buf()
				local opts = { buffer = bufnr, remap = false }
				vim.keymap.set("n", "<leader>gp", function()
					vim.cmd.Git("push")
				end, opts)

				-- rebase
				vim.keymap.set("n", "<leader>gP", function()
					vim.cmd.Git({ "pull", "--rebase" })
				end, opts)

				vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
			end,
		})
		vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
		vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
	end,
}
