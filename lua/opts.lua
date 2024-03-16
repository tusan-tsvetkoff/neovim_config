local opt = vim.opt

vim.scriptencoding = 'utf-8'

--------------------------------------------------------

opt.hlsearch = true

opt.incsearch = true

-- Do not show mode
opt.showmode = false

-- Pseudo transparency for floating window
opt.winblend = 10

vim.opt.list = true

--- except in Rust where the rule is 100 characters
-- show more hidden characters
-- also, show tabs nicer

-- Pseudo transparency for completion menu
opt.pumblend = 10

opt.smoothscroll = true

-- Enable mouse mode
opt.mouse = 'a'
opt.mousemoveevent = true
opt.cursorline = true

opt.cmdheight = 1
opt.listchars =
  vim.opt.listchars:append({ tab = '⇥ ', eol = '↲', trail = '~', space = '_', nbsp = '␣' })
opt.fillchars = [[eob: ,fold:󰇘,foldopen:,foldsep: ,foldclose:]]
-- Soy
opt.clipboard = 'unnamedplus'
opt.wildignore = {
  '*.DS_Store',
  '*.bak',
  '*.gif',
  '*.jpeg',
  '*.jpg',
  '*.png',
  '*.swp',
  '*.zip',
  '*/.git/*',
}
opt.shortmess = vim.opt.shortmess:append('c') -- do not pass messages to ins-completion-menu
opt.whichwrap = vim.opt.whichwrap:append('<,>,[,],h,l')

-- Enable break indent
opt.wrap = false
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Always block cursor
opt.guicursor = 'n-v-c-i:block'

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

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

opt.scrolloff = 4
opt.sidescrolloff = 4

-- Keep signcolumn on by default
opt.signcolumn = 'yes'
opt.showmatch = true

-- Set wildmenu to longest
opt.wildmode = 'list:longest'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.inccommand = 'split'

opt.colorcolumn = '80'

-- Set completeopt to have a better completion experience
opt.completeopt = { 'menu', 'menuone' }
opt.termguicolors = true

-- make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end
