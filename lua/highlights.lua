local H = {}

---@param name string # the name of the hl group to get
---@return vim.api.keyset.hl_info # the hl group info
H.get_hl = function(name)
  return vim.api.nvim_get_hl(0, { name = name })
end

---@param name string # the name of the highlight to set
---@param link string # the name of the highlight to link to
---@param hl_info vim.api.keyset.hl_info # the highlight info to set
---@param bold boolean # whether to make the text bold
H.set_hl = function(name, link, hl_info, bold)
  if hl_info then
    vim.api.nvim_set_hl(
      0,
      name,
      { fg = hl_info.fg, bg = hl_info.bg, ctermfg = hl_info.fg, ctermbg = hl_info.bg, bold = bold }
    )
  else
    vim.api.nvim_set_hl(0, name, link)
  end
end

H.set_signature_hl = function()
  local marked = H.get_hl("PMenu")
  H.set_hl("LspSignatureActiveParameter", nil, marked, true)
end

H.set_comment_hl = function()
  local hl = H.get_hl("Macro")
  H.set_hl("Comment", hl, nil, false)
end

H.set_cmp_match_hl = function()
  local my_hl = "CmpItemAbbrMatch"
  local hl = H.get_hl(my_hl)
  H.set_hl(my_hl, nil, hl, true)
end

-- BUG: This doesn't work
H.set_fileinfo_hl = function()
  local hl_fg = H.get_hl("Macro")
  local hl_rest = H.get_hl("Statusline")
  vim.api.nvim_set_hl(0, "MiniStatusLineFileInfo", {
    fg = hl_fg.fg,
    bg = hl_rest.bg,
    ctermfg = hl_fg.fg,
    ctermbg = hl_rest.bg,
    bold = false,
  })
end

--- Set all declared highlights
H.set_all_highlights = function()
  H.set_signature_hl()
  H.set_comment_hl()
  H.set_cmp_match_hl()
  H.set_fileinfo_hl()
end

return H
