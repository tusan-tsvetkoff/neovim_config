local opt = vim.opt

vim.scriptencoding = 'utf-8'

--------------------------------------------------------
opt.hlsearch = true
opt.incsearch = true
opt.showmode = false
opt.winblend = 10
vim.opt.list = true
opt.pumblend = 10
opt.smoothscroll = true
opt.mouse = 'a'
opt.mousemoveevent = true
opt.cursorline = true
opt.cmdheight = 1
vim.opt.listchars:append({ tab = '⇥ ', eol = '↲', trail = '~', nbsp = '␣' })
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
vim.opt.shortmess:append('c') -- do not pass messages to ins-completion-menu
vim.opt.whichwrap:append('<,>,[,],h,l')

opt.wrap = false
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
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
vim.opt.splitright = true
vim.opt.splitbelow = true
opt.scrolloff = 4
opt.sidescrolloff = 4
opt.signcolumn = 'yes'
opt.showmatch = true
opt.wildmode = 'list:longest'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.inccommand = 'split'
opt.colorcolumn = '80'
opt.completeopt = { 'menuone' }
opt.termguicolors = true

-- make all keyamps silent
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end
