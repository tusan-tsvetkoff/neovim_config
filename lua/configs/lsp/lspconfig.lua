local signs = { Error = '', Warn = '', Hint = '󰌵', Info = '' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local config = {
  -- Enable virtual text
  virtual_text = true,
  -- show signs
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
}

vim.diagnostic.config(config)

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

vim.lsp.handlers['textDocument/codeLens'] = vim.lsp.with(vim.lsp.handlers.codeLens, {
  dynamicRegistration = true,
})

vim.lsp.handlers['workspace/workspaceFolders'] = vim.lsp.with(vim.lsp.handlers.workspaceFolders, {
  library = {
    [vim.fn.expand '$VIMRUNTIME/lua'] = true,
    [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
  },
})

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = {
    spacing = 5,
    severity_limit = 'Warning',
  },
  update_in_insert = true,
})

-- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
--   border = 'rounded',
-- })
