local keymap = vim.keymap
local fn = vim.fn

-------------------------------------------------------------------------------
-- Paste non-linewise text above or below current line
-- see https://stackoverflow.com/a/1346777/6064933
keymap.set('n', '<leader>p', 'm`o<ESC>p``', { desc = 'Paste below current line' })
keymap.set('n', '<leader>P', 'm`O<ESC>p``', { desc = 'Paste above current line' })

-- vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })

--[[
keymap.set('n', '<leader>mp', function()
  local peek = require 'peek'

  if not peek.is_open() then
    peek.open()
  else
    peek.close()
  end
end, { desc = 'Preview Markdown' })
--]]

-- Hover keymaps
-- Setup keymaps
-- keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
-- keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })

-- Mouse support
-- keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = 'hover.nvim (mouse)' })

--[[
-- Nvim-tree
keymap.set('n', '<leader>e', require('nvim-tree.api').tree.toggle, {
  silent = true,
  desc = 'Toggle Nvim-Tree',
})
--]]

--[[
-- SSR Maps
keymap.set({ 'n', 'x' }, '<leader>sr', function()
  require('ssr').open()
end)
--]]

-- copy [l]ast ex[c]ommand
keymap.set('n', '<leader>lc', function()
  local lastCommand = fn.getreg ':'
  if lastCommand == '' then
    vim.notify('No last command available', u.warn)
    return
  end
  fn.setreg('+', lastCommand)
  vim.notify('COPIED\n' .. lastCommand)
end, { desc = '󰘳 Copy last command' })

-- Incr Rename
-- keymap.set('n', '<leader>rr', ':IncRename ')
-- this is for the clipboard stuff, not using it rn
-- key.set({ "n", "v" }, "<leader>y", [["+y]])
-- key.set("n", "<leader>Y", [["+Y]])

-- Keys are too damn hard to press
-- keymap.set('n', '<leader>bl', '^', { desc = 'Move to [b]eginning of [l]ine' })
-- keymap.set('n', '<leader>el', '$', { desc = 'Move to [e]ending of [l]ine' })

keymap.set('n', '~', '~h', { desc = '~ without moving)' })

-- paste man
keymap.set('x', '<leader>p', [["_dP]])

-- moving lines
keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Easier upper/lower case
-- keymap.set('n', '<leader>u', 'gUiw', { desc = 'Upper case word' })
-- keymap.set('n', '<leader>l', 'guiw', { desc = 'Lower case word' })

keymap.set('n', 'Q', '<nop>')

-- Keep cursor centered
keymap.set('n', 'J', 'mzJ`z')

-- Repeated V selects more lines
keymap.set('x', 'V', 'j', { desc = 'Repeated V selects more lines' })

-- Cursor positioning while moving
keymap.set('n', '<C-d>', '<C-d>zz')
keymap.set('n', '<C-u>', '<C-u>zz')
keymap.set('n', 'n', 'nzzzv')
keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Insert Mode (from @chrisgrieser)
keymap.set('i', '<C-e>', '<Esc>A') -- EoL
keymap.set('i', '<C-a>', '<Esc>I') -- BoL

keymap.set('n', 'i', function()
  if vim.api.nvim_get_current_line():find '^%s*$' then
    return [["_cc]]
  end
  return 'i'
end, { expr = true, desc = 'Better i' })

--- A lot of these are taken from @chrisgrieser, @folke, @jdhao and @theprimeagen
---
--- Harpoon
local harpoon = require 'harpoon'
vim.keymap.set('n', '<C-a>', function()
  harpoon:list():append()
end)
vim.keymap.set('n', '<C-e>', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set('n', '<C-h>', function()
  harpoon:list():select(1)
end)
vim.keymap.set('n', '<C-t>', function()
  harpoon:list():select(2)
end)
vim.keymap.set('n', '<C-n>', function()
  harpoon:list():select(3)
end)
vim.keymap.set('n', '<C-s>', function()
  harpoon:list():select(4)
end)

--[[
-- Trouble
vim.keymap.set('n', '<leader>xx', function()
  require('trouble').toggle()
end)
vim.keymap.set('n', '<leader>xw', function()
  require('trouble').toggle 'workspace_diagnostics'
end)
vim.keymap.set('n', '<leader>xd', function()
  require('trouble').toggle 'document_diagnostics'
end)
vim.keymap.set('n', '<leader>xq', function()
  require('trouble').toggle 'quickfix'
end)
vim.keymap.set('n', '<leader>xl', function()
  require('trouble').toggle 'loclist'
end)
vim.keymap.set('n', 'gR', function()
  require('trouble').toggle 'lsp_references'
end)
--]]
