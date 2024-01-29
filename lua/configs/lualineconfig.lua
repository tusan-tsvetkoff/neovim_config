-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#658594',
  cyan   = '#7aa89f',
  black  = '#16161D',
  white  = '#c8c093',
  red    = '#c34043',
  violet = '#957FB8',
  grey   = '#181616',
}

local git_blame = require("gitblame")
git_blame.setup({
	display_virtual_text = false,
	date_format = "%r",
	message_template = " <author> • <date> • <sha>",
	message_when_not_committed = " Commit Please !",
})

local bubbles_theme = {
	normal = {
		a = { fg = colors.black, bg = colors.violet },
		b = { fg = colors.white, bg = colors.grey },
		c = { fg = colors.black, bg = colors.black },
	},

	insert = { a = { fg = colors.black, bg = colors.blue } },
	visual = { a = { fg = colors.black, bg = colors.cyan } },
	replace = { a = { fg = colors.black, bg = colors.red } },

	inactive = {
		a = { fg = colors.white, bg = colors.black },
		b = { fg = colors.white, bg = colors.black },
		c = { fg = colors.black, bg = colors.black },
	},
}

local function lsp_progress()
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return
  end
  local status = {}
  for _, msg in pairs(messages) do
    table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
  end
  local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, " | ") .. " " .. spinners[frame + 1]
end

return {
	options = {
		theme = bubbles_theme,
		component_separators = "|",
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = {
			{
				"mode",
				separator = { left = "" },
				right_padding = 2,
				fmt = function(str)
					return " " .. str
				end,
			},
		},
		lualine_b = {
			"filename",
			"branch",
			{
				git_blame.get_current_blame_text,
				cond = git_blame.is_blame_text_available,
			},
		},
		lualine_c = {
			"fileformat",
		},
		lualine_x = {},
		lualine_y = { "filetype", "progress" },
		lualine_z = {
			{ "location", separator = { right = "" }, left_padding = 2 },
		},
	},
	-- inactive_sections = {
	-- 	lualine_a = { "filename" },
	-- 	lualine_b = {},
	-- 	lualine_c = {},
	-- 	lualine_x = {},
	-- 	lualine_y = {},
	-- 	lualine_z = { "location" },
	-- },
	globalstatus = true,
	tabline = {},
	extensions = {},
}
