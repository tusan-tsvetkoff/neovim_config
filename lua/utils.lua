local M = {}
local I = require("icons")

M.custom_lsp_format = function(entry, item)
  item.abbr = string.format("%s %s", I.kind[item.kind], item.abbr)
  -- item.kind = string.format('%s', icons.kind[item.kind]) -- Only icon

  -- item.menu = ({
  --   nvim_lsp = '[LSP]',
  --   luasnip = '[Snip]',
  --   nvim_lua = '[NvLua]',
  --   buffer = '[Buf]',
  -- })[entry.source.name]

  local half_win_width = math.floor(vim.api.nvim_win_get_width(0) * 0.5)
  if vim.api.nvim_strwidth(item.abbr) > half_win_width then
    item.abbr = ("%s…"):format(item.abbr:sub(1, half_win_width))
  end

  if item.menu then -- Add exta space to visually differentiate `abbr` and `menu`
    item.abbr = ("%s "):format(item.abbr)
  end

  item.dup = ({
    luasnip = 1,
    nvim_lsp = 0,
    nvim_lua = 0,
    buffer = 0,
  })[entry.source.name] or 0

  return item
end

M.get_hlgroup = function(name, fallback)
  if vim.fn.hlexists(name) == 1 then
    local hl
    if vim.api.nvim_get_hl then -- check for new neovim 0.9 API
      hl = vim.api.nvim_get_hl(0, { name = name, link = false })
      if not hl.fg then
        ---@diagnostic disable-next-line: assign-type-mismatch
        hl.fg = "NONE"
      end
      if not hl.bg then
        ---@diagnostic disable-next-line: assign-type-mismatch
        hl.bg = "NONE"
      end
    else
      ---@diagnostic disable-next-line: deprecated
      hl = vim.api.nvim_get_hl_by_name(name, vim.o.termguicolors)
      if not hl.foreground then
        hl.foreground = "NONE"
      end
      if not hl.background then
        hl.background = "NONE"
      end
      hl.fg, hl.bg = hl.foreground, hl.background
      hl.ctermfg, hl.ctermbg = hl.fg, hl.bg
      hl.sp = hl.special
    end
    return hl
  end
  return fallback or {}
end

M.telescope_hls = function()
  return {
    highlights = {
      init = function()
        -- get highlights from highlight groups
        local normal = M.get_hlgroup("Normal")
        local fg, bg = normal.fg, normal.bg
        local bg_alt = M.get_hlgroup("Visual").bg
        local green = M.get_hlgroup("String").fg
        local red = M.get_hlgroup("Error").fg
        return {
          TelescopeBorder = { fg = bg_alt, bg = bg },
          TelescopeNormal = { bg = bg },
          TelescopePreviewBorder = { fg = bg, bg = bg },
          TelescopePreviewNormal = { bg = bg },
          TelescopePreviewTitle = { fg = bg, bg = green },
          TelescopePromptBorder = { fg = bg_alt, bg = bg_alt },
          TelescopePromptNormal = { fg = fg, bg = bg_alt },
          TelescopePromptPrefix = { fg = red, bg = bg_alt },
          TelescopePromptTitle = { fg = bg, bg = red },
          TelescopeResultsBorder = { fg = bg, bg = bg },
          TelescopeResultsNormal = { bg = bg },
          TelescopeResultsTitle = { fg = bg, bg = bg },
        }
      end,
    },
  }
end

return M
