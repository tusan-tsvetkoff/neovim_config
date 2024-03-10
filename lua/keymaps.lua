local keymap = vim.keymap
local fn = vim.fn

-------------------------------------------------------------------------------
-- Paste non-linewise text above or below current line
-- see https://stackoverflow.com/a/1346777/6064933
keymap.set('n', '<leader>p', 'm`o<ESC>p``', { desc = 'Paste below current line' })
keymap.set('n', '<leader>P', 'm`O<ESC>p``', { desc = 'Paste above current line' })

keymap.set('n', '<leader>sn', function()
  require('telescope').extensions.notify.notify {}
end, { silent = true, desc = 'Show notifications' })

keymap.set('n', '<leader>rp', '<cmd>so %<cr>', { silent = true })

-- copy [l]ast ex[c]ommand
keymap.set('n', '<leader>lc', function()
  local lastCommand = fn.getreg ':'
  if lastCommand == '' then
    vim.notify 'No last command available'
    return
  end
  fn.setreg('+', lastCommand)
  vim.notify('COPIED\n' .. lastCommand)
end, { desc = '󰘳 Copy last command' })

keymap.set('n', '~', '~h', { desc = '~ without moving)' })

-- Window navigation and splitting
keymap.set('n', '<leader>sx', '<cmd>q<cr>', { desc = 'Close current buffer' })
keymap.set('n', '<leader>sh', '<cmd>split<cr>', { desc = 'Split window horizontally' })
keymap.set('n', '<leader>sv', '<cmd>vsplit<cr>', { desc = 'Split window vertically' })
keymap.set('n', '<A-h>', '<C-w>h', { desc = 'Move to window left' })
keymap.set('n', '<A-j>', '<C-w>j', { desc = 'Move to window below' })
keymap.set('n', '<A-k>', '<C-w>k', { desc = 'Move to window above' })
keymap.set('n', '<A-l>', '<C-w>l', { desc = 'Move to window right' })

-- moving lines
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

keymap.set('n', 'Q', '<nop>')

-- Keep cursor centered
keymap.set('n', 'J', 'mzJ`z', { desc = 'Keep cursor centered' })

-- Repeated V selects more lines
keymap.set('x', 'V', 'j', { desc = 'Repeated V selects more lines' })

-- Cursor positioning while moving
keymap.set('n', '<C-d>', '<C-d>zz')
keymap.set('n', '<C-u>', '<C-u>zz')
keymap.set('n', 'n', 'nzzzv')
keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Insert Mode (from @chrisgrieser)
keymap.set('i', '<C-e>', '<Esc>A', { desc = 'Go to EoL in I mode' }) -- EoL
keymap.set('i', '<C-a>', '<Esc>I', { desc = 'Go to BoL in I mode' }) -- BoL

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

for i = 1, 5 do
  vim.keymap.set('n', string.format('<space>%s', i), function()
    harpoon:list():select(i)
  end, { silent = true, desc = string.format('Go to bookmark %s', i) })
end
