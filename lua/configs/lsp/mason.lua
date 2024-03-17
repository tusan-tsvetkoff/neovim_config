local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local on_attach = require("configs.lsp").on_attach
local capabilities = require("configs.lsp").capabilities

local ok_neoconf, neoconf = pcall(require, "neoconf")
if ok_neoconf then
  neoconf.setup({})
end

mason.setup({
  ui = {
    -- Whether to automatically check for new versions when opening the :Mason window.
    check_outdated_packages_on_open = false,
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ",
    },
  },
  -- install_root_dir = path.concat { vim.fn.stdpath "config", "/lua/custom/mason" },
})

mason_lspconfig.setup({
  automatic_installation = true,
  ensure_installed = {
    -- Lua
    "lua_ls",
    "vimls",
    "cssls",
    "html",
    "tailwindcss",
    "clangd",
    "neocmake",
    "yamlls",
    "gopls",
    "omnisharp",
  },
})

local disabled_servers = {
  "jdtls",
  "tsserver",
}

mason_lspconfig.setup_handlers({
  -- Automatically configure the LSP installed
  function(server_name)
    for _, name in pairs(disabled_servers) do
      if name == server_name then
        return
      end
    end
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    if server_name == "lua_ls" then
      local ok_neodev, neodev = pcall(require, "neodev")
      if ok_neodev then
        neodev.setup({})
      end
    end

    local require_ok, server = pcall(require, "configs.lsp.settings." .. server_name)
    if require_ok then
      opts = vim.tbl_deep_extend("force", server, opts)
    end

    require("lspconfig")[server_name].setup(opts)
  end,
})
