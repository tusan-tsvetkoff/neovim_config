local augroup = vim.api.nvim_create_augroup
local TusanGroup = augroup("Tusan", {})

local fn = vim.fn

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightOnYank", { clear = true })

local general = augroup("General", { clear = true })

local command = vim.api.nvim_create_user_command

vim.filetype.add({
  extension = {
    templ = "templ",
  },
})

autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.opt.colorcolumn = "100"
  end,
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

autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
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
