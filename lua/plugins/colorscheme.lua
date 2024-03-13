return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      local gruvbox = require 'gruvbox'
      gruvbox.setup {
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true, -- windows sadge
        underline = true,
        bold = false,
        italic = {
          strings = false,
          emphasis = false,
          comments = false,
          operators = false,
          folds = false,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = 'hard', -- can be "hard", "soft" or empty string
        palette_overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      }
      vim.cmd 'colorscheme gruvbox'
      vim.cmd 'highlight SignColumn guibg=NONE'

      local bools = vim.api.nvim_get_hl(0, { name = 'Boolean' })
      vim.api.nvim_set_hl(0, 'Comment', bools)
      -- Make it clearly visible which argument we're at.
      local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
      vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { fg = marked.fg, bg = marked.bg, ctermfg = marked.fg, ctermbg = marked.bg, bold = true })
    end,
  },
}
