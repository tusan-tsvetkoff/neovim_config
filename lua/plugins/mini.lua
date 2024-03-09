local header = require("dashboards")
local icons = require("icons")

local function truncate_text(text, max_length)
	if text == nil then
		return ""
	end
	if #text > max_length then
		return text:sub(1, max_length - 3) .. "..."
	end
	return text
end

return {
	{
		"echasnovski/mini.nvim",
		dependencies = {
			{ "lewis6991/gitsigns.nvim", opts = {} },
			{ "f-person/git-blame.nvim", opts = {} },
		},
		config = function()
			require("mini.ai").setup({ n_lines = 500 })
			require("mini.starter").setup({ header = header.get_day })

			vim.g.gitblame_display_virtual_text = 0
			local gb = require("gitblame")
			local s = require("mini.statusline")

			s.setup({
				content = {
					active = function()
						local mode, mode_hl = s.section_mode({ trunc_width = 120 })
						local git = s.section_git({ trunc_width = 75 })
						local git_blame = gb.is_blame_text_available() and gb.get_current_blame_text() or ""
						local diagnostics = s.section_diagnostics({ trunc_width = 75 })
						local filename = s.section_filename({ trunc_width = 75 })
						local fileinfo = s.section_fileinfo({ trunc_width = 120 })
						local location = s.section_location({ trunc_width = 75 })
						local search = s.section_searchcount({ trunc_width = 75 })

						return s.combine_groups({
							{ hl = mode_hl, strings = { icons.general.neovim .. " " .. mode } },
							{ hl = "MiniStatusLineDevInfo", strings = { git, diagnostics } },
							"%<",
							{ hl = "MiniStatuslineFilename", strings = { filename, truncate_text(git_blame, 30) } },
							"%=",
							{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
							{ hl = mode_hl, strings = { search, location } },
						})
					end,
				},
			})
		end,
	},
}
