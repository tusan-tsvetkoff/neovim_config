local H = require "highlights"
return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      -- Default options:
      require("kanagawa").setup({
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = false },
        functionStyle = {},
        keywordStyle = { italic = false, bold = false },
        statementStyle = { bold = false },
        typeStyle = {},
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        theme = "wave", -- Load "wave" theme when 'background' option is not set
        background = { -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus",
        },
      })

      -- setup must be called before loading
      -- TODO: Move this out of here
      vim.cmd("colorscheme kanagawa")
      vim.cmd("highlight SignColumn guibg=NONE")
      vim.cmd("highlight NormalFloat guibg=NONE guifg=NONE")
      vim.cmd("highlight FloatBorder guibg=NONE guifg=NONE")
      H.set_all_highlights()
      -- -- ref https://github.com/jonhoo/configs/blob/b1807b623b1ef00139f9cedd059f6a4f90b21736/editor/.config/nvim/init.lua#L255
      -- -- Comments are now VISIBLE (to my colorblidn ass)
      -- local macro = vim.api.nvim_get_hl(0, { name = "Macro" })
      -- vim.api.nvim_set_hl(0, "Comment", macro)
      -- -- Make it clearly visible which argument we're at.
      -- local marked = vim.api.nvim_get_hl(0, { name = "PMenu" })
      -- -- Make CMP arg. matching bold ^
      -- local marked_sbar = vim.api.nvim_get_hl(0, { name = "CmpItemAbbrMatch" })
      -- vim.api.nvim_set_hl(
      --   0,
      --   "CmpItemAbbrMatch",
      --   { fg = marked_sbar.fg, bg = marked_sbar.bg, ctermfg = marked_sbar.fg, ctermbg = marked_sbar.bg, bold = true }
      -- )
      -- vim.api.nvim_set_hl(
      --   0,
      --   "LspSignatureActiveParameter",
      --   { fg = marked.fg, bg = marked.bg, ctermfg = marked.fg, ctermbg = marked.bg, bold = true }
      -- )
    end,
  },
  --[[ {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      local gruvbox = require("gruvbox")
      gruvbox.setup({
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
        contrast = "hard", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      })
      vim.cmd("colorscheme gruvbox")
      vim.cmd("highlight SignColumn guibg=NONE")
      vim.cmd("highlight NormalFloat guibg=NONE guifg=NONE")
      vim.cmd("highlight FloatBorder guibg=NONE guifg=NONE")

      -- ref https://github.com/jonhoo/configs/blob/b1807b623b1ef00139f9cedd059f6a4f90b21736/editor/.config/nvim/init.lua#L255
      -- Comments are now VISIBLE (to my colorblidn ass)
      local bools = vim.api.nvim_get_hl(0, { name = "Macro" })
      vim.api.nvim_set_hl(0, "Comment", bools)
      -- Make it clearly visible which argument we're at.
      local marked = vim.api.nvim_get_hl(0, { name = "PMenu" })
      vim.api.nvim_set_hl(
        0,
        "LspSignatureActiveParameter",
        { fg = marked.fg, bg = marked.bg, ctermfg = marked.fg, ctermbg = marked.bg, bold = true }
      )
    end,
  }, ]]
}
