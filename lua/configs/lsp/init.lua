local M = {}
local keymap = vim.keymap.set

local cmp_lsp = require("cmp_nvim_lsp")

M.capabilities =
	vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

local function lsp_keymaps(bufnr)
	local buf_opts = { buffer = bufnr, silent = true }
	keymap("n", "gD", "<cmd>Lspsaga finder<cr>", buf_opts)
	keymap("n", "gd", "<cmd>Lspsaga goto_definition<cr>", buf_opts)
	keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<cr>", buf_opts)
	keymap("n", "gc", "<cmd>Lspsaga show_cursor_diagnostics<cr>", buf_opts)
	keymap("n", "gp", "<cmd>Lspsaga peek_definition<cr>", buf_opts)
	keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", buf_opts)
	keymap("n", "gi", "<cmd>Telescope lsp_implementations<cr>", buf_opts)

	keymap("n", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, buf_opts)

	-- vim.keymap.set("n", "<leader>ca", function()
	-- 	vim.lsp.buf.code_action()
	-- end, buf_opts)

	keymap("n", "<leader>lh", function()
		if vim.lsp.inlay_hint.is_enabled(0) then
			vim.cmd("lua=vim.lsp.inlay_hint.enable(0, false)")
		else
			vim.cmd("lua=vim.lsp.inlay_hint.enable(0, true)")
		end
	end, { silent = true })
end

-- Highlight symbol under cursor
local function lsp_highlight(client, bufnr)
	if client.supports_method("textDocument/documentHighlight") then
		vim.api.nvim_create_augroup("lsp_document_highlight", {
			clear = false,
		})
		vim.api.nvim_clear_autocmds({
			buffer = bufnr,
			group = "lsp_document_highlight",
		})
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end


local function to_snake_case(str)
	return string.gsub(str, "%s*[- ]%s*", "_")
end

local function get_client_name()
	local clients = vim.lsp.get_active_clients()
	local client_name = ""
	for _, client in ipairs(clients) do
		if client.name == "omnisharp" then
			client_name = client.name
			return client_name
		end
	end
	return client_name
end

M.on_attach = function(client, bufnr)
	if get_client_name() == "omnisharp" then
		local token_modifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
		for i, v in ipairs(token_modifiers) do
			token_modifiers[i] = to_snake_case(v)
		end
		local token_types = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
		for i, v in ipairs(token_types) do
			token_types[i] = to_snake_case(v)
		end
	end
	lsp_keymaps(bufnr)
	lsp_highlight(client, bufnr)
end

return M
