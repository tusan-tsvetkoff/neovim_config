local opt = vim.opt

vim.scriptencoding = "utf-8"

--------------------------------------------------------

opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

opt.incsearch = true

-- Do not show mode
opt.showmode = false

-- Pseudo transparency for floating window
opt.winblend = 10

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Pseudo transparency for completion menu
opt.pumblend = 10

opt.smoothscroll = true

-- Enable mouse mode
opt.mouse = "a"
opt.mousemoveevent = true
opt.cursorline = true

opt.cmdheight = 1

-- Soy
opt.clipboard = "unnamedplus"

-- Enable break indent
opt.wrap = false
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Always block cursor
opt.guicursor = "n-v-c-i:block"

opt.number = true
opt.relativenumber = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.shiftround = true

opt.smartindent = true
opt.smarttab = true

opt.backup = false
opt.swapfile = false

opt.scrolloff = 4
opt.sidescrolloff = 4

-- Keep signcolumn on by default
opt.signcolumn = "yes:1"

-- Decrease update time
opt.updatetime = 50

vim.opt.inccommand = 'split'

opt.colorcolumn = "80"

-- Set completeopt to have a better completion experience
opt.completeopt = { "menuone", "noselect" }
opt.termguicolors = true

-- make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end
