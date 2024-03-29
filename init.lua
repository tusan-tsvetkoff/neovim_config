vim.g.mapleader = " "
vim.g.maplocalleader = " "
local U = require("utils")
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
require("lazy").setup({
  spec = "plugins",
  change_detection = {
    notify = false,
  },
  ---@diagnostic disable-next-line: assign-type-mismatch
  dev = {
    path = "C:\\Users\\User\\github\\nvim\\tusan",
    fallback = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        -- "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
})

require("opts")
require("keymaps")
require("autocmds")
require("globals")

local tele_hls = U.telescope_hls()
for group, colors in pairs(tele_hls.highlights.init()) do
  local set_hl = vim.api.nvim_set_hl
  set_hl(0, group, colors)
end
