local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
return {
	cmp.setup({
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
			["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
			["<C-Space>"] = cmp.mapping.complete(cmp_select),
			["<C-e>"] = cmp.mapping.close(),
			["<C-l>"] = cmp.mapping.confirm({
				select = true,
			}),
		}),
		sources = {
			{ name = "nvim_lua" },
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "luasnip" },
			{ name = "buffer", keyword_length = 5 },
			{ name = "cmdline" },
			{ name = "cmp-git" },
		},
		formatting = {
			fields = { "abbr", "kind", "menu" },
			format = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50, ellipsis_char = "…" }),
		},
	}),
}
