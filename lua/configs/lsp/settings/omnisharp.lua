local lspconfig = require("lspconfig")
return {
	-- cmd = { "dotnet", "C:\\Users\\User\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\libexec\\OmniSharp.dll" },
	-- enable_editorconfig_support = true,
	-- sdk_include_prereleases = true,
	enable_roslyn_analyzers = true,
	enable_import_completion = true,
	enable_ms_build_load_projects_on_demand = true,
	root_dir = function(fname)
		local primary = lspconfig.util.root_pattern("*.sln")(fname)
		local fallback = lspconfig.util.root_pattern("*.csproj")(fname)
		local git_root = lspconfig.util.find_git_ancestor(fname)
		return primary or git_root or fallback
	end,
}
