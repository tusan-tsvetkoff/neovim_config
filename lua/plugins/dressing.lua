return {
  'stevearc/dressing.nvim',
  opts = {
    input = {
      enabled = true,
      default_prompt = '➤ ',
      win_options = {
        winblend = 0,
        winhighlight = 'Normal:Normal,NormalNC:Normal',
      },
    },
    select = {
      enabled = true,
      backend = { 'telescope', 'builtin' },
      builtin = {
        win_options = {
          winblend = 0,
          winhighlight = 'Normal:Normal,NormalNC:Normal',
        },
      },
    },
  },
}
