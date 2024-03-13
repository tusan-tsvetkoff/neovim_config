local map = vim.keymap.set
local fn = vim.fn

-------------------------------------------------------------------------------
-- ref https://github.com/kevinm6/nvim/blob/0c2d0fcb04be1f0837ae8918b46131f649cba775/lua/config/keymaps.lua#L77C1-L82C2
map('n', '<C-s>', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace occurence from <cword>' })
-- Paste non-linewise text above or below current line
-- see https://stackoverflow.com/a/1346777/6064933
map('n', '<leader>p', 'm`o<ESC>p``', { desc = 'Paste below current line' })
map('n', '<leader>P', 'm`O<ESC>p``', { desc = 'Paste above current line' })

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

map('n', '<leader>sn', function()
  require('telescope').extensions.notify.notify {}
end, { silent = true, desc = 'Show notifications' })

map('n', '<leader>rp', '<cmd>so %<cr>', { silent = true })

-- copy [l]ast ex[c]ommand
map('n', '<leader>lc', function()
  local lastCommand = fn.getreg ':'
  if lastCommand == '' then
    vim.notify 'No last command available'
    return
  end
  fn.setreg('+', lastCommand)
  vim.notify('COPIED\n' .. lastCommand)
end, { desc = '󰘳 Copy last command' })

map('n', '~', '~h', { desc = '~ without moving)' })

-- Window navigation and splitting
map('n', '<leader>sx', '<cmd>q<cr>', { desc = 'Close current buffer' })
map('n', '<leader>sh', '<cmd>split<cr>', { desc = 'Split window horizontally' })
map('n', '<leader>sv', '<cmd>vsplit<cr>', { desc = 'Split window vertically' })
map('n', '<A-h>', '<C-w>h', { desc = 'Move to window left' })
map('n', '<A-j>', '<C-w>j', { desc = 'Move to window below' })
map('n', '<A-k>', '<C-w>k', { desc = 'Move to window above' })
map('n', '<A-l>', '<C-w>l', { desc = 'Move to window right' })

-- moving lines
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

map('n', 'Q', '<nop>')

-- Keep cursor centered
map('n', 'J', 'mzJ`z', { desc = 'Keep cursor centered' })

-- resize windows
map('n', '<S-Up>', function()
  vim.cmd.resize '+2'
end)
map('n', '<S-Down>', function()
  vim.cmd.resize '-2'
end)
map('n', '<S-Left>', function()
  vim.cmd 'vertical resize -2'
end)
map('n', '<S-Right>', function()
  vim.cmd 'vertical resize +2'
end)

-- Repeated V selects more lines
map('x', 'V', 'j', { desc = 'Repeated V selects more lines' })

-- Cursor positioning while moving
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Insert Mode (from @chrisgrieser)
map('i', '<C-e>', '<Esc>A', { desc = 'Go to EoL in I mode' }) -- EoL
map('i', '<C-a>', '<Esc>I', { desc = 'Go to BoL in I mode' }) -- BoL

map('n', 'i', function()
  if vim.api.nvim_get_current_line():find '^%s*$' then
    return [["_cc]]
  end
  return 'i'
end, { expr = true, desc = 'Better i' })

--- A lot of these are taken from @chrisgrieser, @folke, @jdhao and @theprimeagen
---
--- Harpoon
local harpoon = require 'harpoon'

map('n', '<C-a>', function()
  harpoon:list():append()
end)
map('n', '<C-e>', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

for i = 1, 5 do
  map('n', string.format('<space>%s', i), function()
    harpoon:list():select(i)
  end, { silent = true, desc = string.format('Go to bookmark %s', i) })
end
