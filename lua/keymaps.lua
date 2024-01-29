local keymap = vim.keymap
local fn = vim.fn

-------------------------------------------------------------------------------
-- Paste non-linewise text above or below current line
-- see https://stackoverflow.com/a/1346777/6064933
keymap.set('n', '<leader>p', 'm`o<ESC>p``', { desc = 'Paste below current line' })
keymap.set('n', '<leader>P', 'm`O<ESC>p``', { desc = 'Paste above current line' })

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

-- copy [l]ast ex[c]ommand
keymap.set('n', '<leader>lc', function()
  local lastCommand = fn.getreg ':'
  if lastCommand == '' then
    vim.notify('No last command available')
    return
  end
  fn.setreg('+', lastCommand)
  vim.notify('COPIED\n' .. lastCommand)
end, { desc = '󰘳 Copy last command' })

keymap.set('n', '~', '~h', { desc = '~ without moving)' })

-- moving lines
keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

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
