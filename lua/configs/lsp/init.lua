local M = {}
local keymap = vim.keymap.set

local cmp_lsp = require('cmp_nvim_lsp')
local codelens = require('configs.lsp.lspconfig')

M.capabilities = vim.tbl_deep_extend(
  'force',
  {},
  vim.lsp.protocol.make_client_capabilities(),
  cmp_lsp.default_capabilities()
)

vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
vim.keymap.set('n', 'ge', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'gp', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

local function lsp_keymaps(bufnr)
  local buf_opts = { buffer = bufnr, silent = true }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, buf_opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, buf_opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, buf_opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, buf_opts)
  -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, buf_opts)
  -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, buf_opts)
  vim.keymap.set('n', '<leader>wl', function()
    vim.api.nvim_notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, buf_opts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, buf_opts)
  vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename, buf_opts)
  vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, buf_opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, buf_opts)

  keymap('i', '<C-h>', function()
    vim.lsp.buf.signature_help()
  end, buf_opts)

  keymap('n', '<leader>lh', function()
    if vim.lsp.inlay_hint.is_enabled(0) then
      vim.cmd('lua=vim.lsp.inlay_hint.enable(0, false)')
    else
      vim.cmd('lua=vim.lsp.inlay_hint.enable(0, true)')
    end
  end, { silent = true })
end

-- Highlight symbol under cursor
local function lsp_highlight(client, bufnr)
  if client.supports_method('textDocument/documentHighlight') then
    vim.api.nvim_create_augroup('lsp_document_highlight', {
      clear = false,
    })
    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = 'lsp_document_highlight',
    })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

M.on_attach = function(client, bufnr)
  codelens.setup_codelens_refresh(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_highlight(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil
end

return M
