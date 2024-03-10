local cmp = require 'cmp'
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local border_opts = { border = 'single', winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None' }
return {
  cmp.setup {
    window = {
      completion = cmp.config.window.bordered(border_opts),
      documentation = cmp.config.window.bordered(border_opts),
    },
    preselect = cmp.PreselectMode.None,
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    duplicates = {
      nvim_lsp = 1,
      luasnip = 1,
      cmp_tabnine = 1,
      buffer = 1,
      path = 1,
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    mapping = cmp.mapping.preset.insert {
      ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
      ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
      ['<C-Space>'] = cmp.mapping.complete(cmp_select),
      ['<C-e>'] = cmp.mapping.close(),
      ['<C-l>'] = cmp.mapping.confirm {
        select = false,
      },
    },
    sources = {
      { name = 'nvim_lsp', priority = 1000 },
      { name = 'luasnip', priority = 750 },
      { name = 'buffer', keyword_length = 5, priority = 500 },
      { name = 'path', priority = 250 },
      { name = 'cmdline', priority = 250 },
      { name = 'cmp-git', priority = 250 },
    },
    formatting = {
      fields = { 'abbr', 'kind', 'menu' },
      format = require('lspkind').cmp_format { mode = 'symbol_text', maxwidth = 50, ellipsis_char = '…' },
    },
  },
}
