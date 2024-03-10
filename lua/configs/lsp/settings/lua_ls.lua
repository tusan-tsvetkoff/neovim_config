return {
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
      runtime = { vesion = 'LuaJIT' },
      workspace = {
        library = {
          '${3rd}/luv/library',
          unpack(vim.api.nvim_get_runtime_file('', true)),
        },
        checkThirdParty = false,
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
      diagnostics = {
        globals = { 'vim' },
        disabled = { 'missing-fields' },
      },
    },
  },
}
