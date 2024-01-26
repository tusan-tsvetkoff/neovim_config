vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--BRANCH=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
require('opts')
require('keymaps')

local augroup = vim.api.nvim_create_augroup
local TusanGroup = augroup('Tusan', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightOnYank', {})

function R(name)
  return require("plenary.reload").reload_module(name)
end

vim.filetype.add({
  extension = {
    templ = "templ",
  }
})

autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40
    })
  end,
})

autocmd('BufWritePost', {
  group = TusanGroup,
  pattern = '*',
  command = [[%s/\s\+$//e]],
})
