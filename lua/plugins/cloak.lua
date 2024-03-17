return {
  "laytan/cloak.nvim",
  event = "VeryLazy",
  config = function()
    require("cloak").setup({
      enabled = true,
      cloak_character = "*",
      highlight_group = "Comment",
      patterns = {
        {
          file_pattern = ".env*",
          cloak_pattern = "=.+",
        },
      },
    })
  end,
}
