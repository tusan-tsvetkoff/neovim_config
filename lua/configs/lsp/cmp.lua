---@diagnostic disable-next-line: different-requires
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local border_opts =
  { winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None', scrollbar = false }
local icons = require('icons')
local context = require('cmp.config.context')

return {
  cmp.setup({
    window = {
      completion = {
        winhighlight = 'Normal:CmpMenu,CursorLine:PmenuSel,FloatBorder:CmpMenu,Search:None',
        col_offset = -4,
        side_padding = 1,
        scrollbar = false,
        border = 'rounded',
      },
      documentation = {
        winhighlight = 'Normal:Normal,FloatBorder:CmpMenu,CursorLine:CursorLineBG,Search:None',
        border = 'rounded',
      },
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
      ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
      ['<C-Space>'] = cmp.mapping.complete(cmp_select),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-l>'] = cmp.mapping.confirm({
        select = true,
      }),
    }),
    sources = {
      {
        name = 'nvim_lsp',
        filter = function(_, _)
          return not context.in_syntax_group('Comment')
            or not context.in_treesitter_capture('comment')
        end,
      },
      { name = 'path' },
      {
        name = 'buffer',
        option = { keyword_length = 4, keyword_pattern = [[\k\+]] },
      },
      {
        name = 'luasnip',
        filter = function(_, _)
          return not context.in_syntax_group('Comment')
            or not context.in_treesitter_capture('comment')
        end,
      },
      { name = 'nvim_lua' },
      { name = 'treesitter' },
      { name = 'path', option = { trailing_slash = true } },
    },
    formatting = {
      fields = { 'abbr', 'kind', 'menu' },
      format = function(entry, item)
        item.kind = string.format('%s %s', icons.kind[item.kind], item.kind)

        -- item.menu = ({
        --   nvim_lsp = '[LSP]',
        --   luasnip = '[Snip]',
        --   nvim_lua = '[NvLua]',
        --   buffer = '[Buf]',
        -- })[entry.source.name]

        local half_win_width = math.floor(vim.api.nvim_win_get_width(0) * 0.5)
        if vim.api.nvim_strwidth(item.abbr) > half_win_width then
          item.abbr = ('%s…'):format(item.abbr:sub(1, half_win_width))
        end

        if item.menu then -- Add exta space to visually differentiate `abbr` and `menu`
          item.abbr = ('%s '):format(item.abbr)
        end

        item.dup = ({
          luasnip = 1,
          nvim_lsp = 0,
          nvim_lua = 0,
          buffer = 0,
        })[entry.source.name] or 0

        return item
      end,
    },
  }),
}
