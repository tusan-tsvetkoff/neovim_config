return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "benfowler/telescope-luasnip.nvim"
  },
  config = function()
    -- local ls = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip").filetype_extend("lua", { "luadoc" })
    -- vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
    --
    -- vim.keymap.set({"i", "s"}, "<leader>;", function() ls.jump(1) end, {silent = true})
    -- vim.keymap.set({"i", "s"}, "<leader>,", function() ls.jump(-1) end, {silent = true})
    --
    -- vim.keymap.set({"i", "s"}, "<C-E>", function()
    --   if ls.choice_active() then
    --     ls.change_choice(1)
    --   end
    -- end, {silent = true})
  end,
}
