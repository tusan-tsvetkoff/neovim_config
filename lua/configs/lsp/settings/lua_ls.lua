return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      runtime = { vesion = "LuaJIT" },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config" .. "/lua")] = true,
        },
        checkThirdParty = false,
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
      diagnostics = {
        globals = { "vim" },
        disabled = { "missing-fields" },
      },
    },
  },
}
