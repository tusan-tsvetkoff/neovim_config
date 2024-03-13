local M = {}

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

M.setup_codelens_refresh = function(client, bufnr)
  local status_ok, codelens_supported = pcall(function()
    return client.supports_method 'textDocument/codeLens'
  end)
  if not status_ok or not codelens_supported then
    return
  end

  vim.lsp.handlers['textDocument/codeLens'] = vim.lsp.with(vim.lsp.handlers.codeLens, {
    dynamicRegistration = true,
  })

  local group = 'lsp_code_lens_refresh'
  local cl_events = { 'BufEnter', 'CursorHold', 'InsertLeave' }
  local ok, cl_autocmds = pcall(vim.api.nvim_get_autocmds, {
    group = group,
    buffer = bufnr,
    event = cl_events,
  })
  if ok and #cl_autocmds > 0 then
    return
  end
  vim.api.nvim_create_augroup(group, { clear = false })
  vim.api.nvim_create_autocmd(cl_events, {
    group = group,
    buffer = bufnr,
    callback = function()
      vim.lsp.codelens.refresh()
    end,
  })
end

vim.diagnostic.config {
  on_init_callback = function(_)
    M.setup_codelens_refresh(_)
  end,
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
return M
