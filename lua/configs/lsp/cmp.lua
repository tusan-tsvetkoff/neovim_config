local cmp = require 'cmp'
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local border_opts = { border = 'single', winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None' }
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
      { name = 'nvim_lsp' },
      { name = 'path', priority = 250 },
      { name = 'buffer', keyword_length = 3, priority = 500 },
    },
    formatting = {
      fields = { 'abbr', 'kind', 'menu' },
      format = require('lspkind').cmp_format {
        mode = 'symbol_text',
        maxwidth = 50,
        ellipsis_char = '…',
        menu = {
          nvim_lsp = '[LSP]',
          ultisnips = '[US]',
          nvim_lua = '[Lua]',
          path = '[Path]',
          buffer = '[Buffer]',
          emoji = '[Emoji]',
          omni = '[Omni]',
        },
      },
    },
  },
}
