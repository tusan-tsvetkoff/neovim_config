local augroup = vim.api.nvim_create_augroup
local TusanGroup = augroup("Tusan", {})

local fn = vim.fn

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightOnYank", {})

local general = augroup("General", { clear = true })

local command = vim.api.nvim_create_user_command

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

autocmd("BufReadPost", {
	callback = function()
		if fn.line("'\"") > 1 and fn.line("'\"") <= fn.line("$") then
			vim.cmd('normal! g`"')
		end
	end,
	group = general,
	desc = "Go To The Last Cursor Position",
})

autocmd("ModeChanged", {
	callback = function()
		if fn.getcmdtype() == "/" or fn.getcmdtype() == "?" then
			vim.opt.hlsearch = true
		else
			vim.opt.hlsearch = false
		end
	end,
	group = general,
	desc = "Highlighting matched words when searching",
})

autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
	group = general,
	desc = "Disable New Line Comment",
})

command("Format", function(args)
	local status_ok, conform = pcall(require, "conform")
	if not status_ok then
		return vim.notify("conform.nvim isn't installed!!!", vim.log.levels.ERROR)
	end

	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	conform.format({ async = true, lsp_fallback = true, range = range })
	vim.notify("Format Done", vim.log.levels.INFO, { title = "Format" })
end, { nargs = "*", desc = "Code Format", range = true })

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd("BufWritePost", {
	group = TusanGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- Fix conceallevel for json & help files
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "json", "jsonc" },
	callback = function()
		vim.wo.spell = false
		vim.wo.conceallevel = 0
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		local commentstrings = {
			dts = "// %s",
		}
		local ft = vim.bo.filetype
		if commentstrings[ft] then
			vim.bo.commentstring = commentstrings[ft]
		end
	end,
})
