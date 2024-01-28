local function create_namespace_from_path(path)
	return "namespace" .. path:gsub("[a-zA-Z]:[\\/]", ""):gsub("[\\/]", "."):gsub("[\\/]", ".")
end

local function get_namespace()
	local fname = vim.api.nvim_buf_get_name(0)
	print("fname: ", fname)
	local util = require("lspconfig.util")
	local path = util.root_pattern("*.csproj")(fname)
		or util.root_pattern("*.sln")(fname)
		or util.root_pattern("*.sln")("./")
		or util.root_pattern("*.csproj")("./")
		or util.root_pattern("*.slnx")("./")
	print("path: ", path)

	if path == nil then
		path = ""
	end

	local result = fname:gsub(path .. "/", ""):gsub(path .. "\\", "")
	print("temp-result: ", result)
	local no_fname = result:gsub("[\\/]?[a-zA-Z0-9_@]+.cs", "")

	print("no_fname: ", no_fname)

	local namespace = create_namespace_from_path(no_fname)
	return namespace
end

local function get_class_name()
	local start_index, end_index, file_name = string.find(vim.api.nvim_buf_get_name(0), "([a-zA-Z_@<>0-9]+).cs")
	local name = file_name:gsub(".cs", ""):gsub("/", ""):gsub("\\", "")

	return name
end

local function get_class_with_namespace()
	local namespace = get_namespace()
	local class_name = get_class_name()
	local type = "class"

	if class_name:sub(1, 1) == "I" then
		type = "interface"
	end

	return {
		namespace,
		[[]],
		"public" .. type .. " " .. class_name,
		[[{]],
		[[]],
		"}",
	}
end

return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"benfowler/telescope-luasnip.nvim",
	},
	config = function()
		local luasnip = require("luasnip")
		luasnip.config.set_config({
			enable_autosnippets = true,
			history = true,
		})
		luasnip.config.setup({
			enable_autosnippets = true,
			history = true,
		})
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip").filetype_extend("lua", { "luadoc" })

		luasnip.add_snippets(nil, {
			cs = {
				luasnip.snippet({
					trig = "namespace",
					name = "add namesapce",
					dscr = "Add namespace",
				}, {
					luasnip.function_node(get_namespace, {}),
				}),
				luasnip.snippet({
					trig = "class",
					name = "class with namesapce",
					dscr = "class with namesapce",
				}, {
					luasnip.function_node(get_class_with_namespace, {}),
				}),
			},
		})

		luasnip.setup()
	end,
}
