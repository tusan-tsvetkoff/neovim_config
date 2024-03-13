---@diagnostic disable-next-line: different-requires
local cmp = require 'cmp'
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local border_opts = { border = 'single', winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None', scrollbar = false }
local icons = require 'icons'
local context = require 'cmp.config.context'

return {
  cmp.setup {
    window = {
      completion = cmp.config.window.bordered(border_opts),
      documentation = cmp.config.window.bordered(border_opts),
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
      ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
      ['<C-Space>'] = cmp.mapping.complete(cmp_select),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-l>'] = cmp.mapping.confirm {
        select = true,
      },
    },
    sources = {
      {
        name = 'nvim_lsp',
        filter = function(_, _)
          return not context.in_syntax_group 'Comment' or not context.in_treesitter_capture 'comment'
        end,
      },
      { name = 'path', priority = 250 },
      {
        name = 'buffer',
        option = { keyword_length = 4, keyword_pattern = [[\k\+]] },
      },
      {
        name = 'luasnip',
        filter = function(_, _)
          return not context.in_syntax_group 'Comment' or not context.in_treesitter_capture 'comment'
        end,
      },
      { name = 'nvim_lua' },
      { name = 'treesitter' },
      { name = 'path', option = { trailing_slash = true } },
    },
    formatting = {
      fields = { 'abbr', 'kind', 'menu' },
      format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format('%s %s', icons.kind[vim_item.kind], vim_item.kind)

        vim_item.menu = ({
          nvim_lsp = '[LSP]',
          luasnip = '[Snip]',
          nvim_lua = '[NvLua]',
          buffer = '[Buf]',
        })[entry.source.name]

        vim_item.dup = ({
          luasnip = 1,
          nvim_lsp = 0,
          nvim_lua = 0,
          buffer = 0,
        })[entry.source.name] or 0

        return vim_item
      end,
    },
  },
}
