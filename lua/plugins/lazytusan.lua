return {
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  'eandrju/cellular-automaton.nvim',
  'github/copilot.vim',
  { 'numToStr/Comment.nvim', opts = {} },
  { 'b0o/schemastore.nvim' },
  { 'justinsgithub/wezterm-types' },
  { 'Hoffs/omnisharp-extended-lsp.nvim', lazy = true },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
  },
  {
    'saecki/crates.nvim',
    tag = 'stable',
    config = function()
      require('crates').setup()
    end,
  },
  { 'tpope/vim-sleuth' },
  {
    '2kabhishek/nerdy.nvim',
    cmd = 'Nerdy',
    keys = {
      { '<leader>ci', '<cmd>Nerdy<cr>', desc = 'Pick Icon' },
    },
  },
}
