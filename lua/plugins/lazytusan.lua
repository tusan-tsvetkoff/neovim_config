return {
  { "nvim-tree/nvim-web-devicons", lazy = true },
  "eandrju/cellular-automaton.nvim",
  "github/copilot.vim",
  { "numToStr/Comment.nvim", opts = {} },
  { "b0o/schemastore.nvim" },
  { "justinsgithub/wezterm-types" },
  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
  },
  {
    "saecki/crates.nvim",
    tag = "stable",
    config = function()
      require("crates").setup()
    end,
  },
  { "tpope/vim-sleuth" },
  {
    "2kabhishek/nerdy.nvim",
    cmd = "Nerdy",
    keys = {
      { "<leader>ci", "<cmd>Nerdy<cr>", desc = "Pick Icon" },
    },
  },
  -- inline function signatures
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      -- Get signatures (and _only_ signatures) when in argument lists.
      require("lsp_signature").setup({
        doc_lines = 0,
        handler_opts = {
          border = "rounded",
        },
      })
    end,
  },
  -- better %
  {
    "andymass/vim-matchup",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  { "windwp/nvim-autopairs", disabled = true },
  { "cespare/vim-toml" },
}
