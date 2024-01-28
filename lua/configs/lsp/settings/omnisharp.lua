local lspconfig = require("lspconfig")
return {
  cmd = { "dotnet", "C:\\Users\\User\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\libexec\\OmniSharp.dll" },
  enable_editorconfig_support = false,
  sdk_include_prereleases = true,
  enable_roslyn_analyzers = false,
  enable_import_completion = true,
  enable_ms_build_load_projects_on_demand = true,
	-- on_new_config = function(new_config, new_root_dir)
	-- 	if new_root_dir then
	-- 		table.insert(new_config.cmd, "-z") -- https://github.com/OmniSharp/omnisharp-vscode/pull/4300
	-- 		vim.list_extend(new_config.cmd, { "-s", new_root_dir })
	-- 		vim.list_extend(new_config.cmd, { "--hostPID", tostring(vim.fn.getpid()) })
	-- 		table.insert(new_config.cmd, "DotNet:enablePackageRestore=false")
	-- 		vim.list_extend(new_config.cmd, { "--encoding", "utf-8" })
	-- 		table.insert(new_config.cmd, "--languageserver")
	--
	-- 		if new_config.enable_editorconfig_support then
	-- 			table.insert(new_config.cmd, "FormattingOptions:EnableEditorConfigSupport=true")
	-- 		end
	--
	-- 		if new_config.organize_imports_on_format then
	-- 			table.insert(new_config.cmd, "FormattingOptions:OrganizeImports=false")
	-- 		end
	--
	-- 		if new_config.enable_ms_build_load_projects_on_demand then
	-- 			table.insert(new_config.cmd, "MsBuild:LoadProjectsOnDemand=true")
	-- 		end
	--
	-- 		if new_config.enable_roslyn_analyzers then
	-- 			table.insert(new_config.cmd, "RoslynExtensionsOptions:EnableAnalyzersSupport=true")
	-- 		end
	--
	-- 		if new_config.enable_import_completion then
	-- 			table.insert(new_config.cmd, "RoslynExtensionsOptions:EnableImportCompletion=true")
	-- 		end
	--
	-- 		if new_config.sdk_include_prereleases then
	-- 			table.insert(new_config.cmd, "Sdk:IncludePrereleases=true")
	-- 		end
	--
	-- 		if new_config.analyze_open_documents_only then
	-- 			table.insert(new_config.cmd, "RoslynExtensionsOptions:AnalyzeOpenDocumentsOnly=false")
	-- 		end
	-- 	end
	-- end,
	root_dir = function(fname)
		local primary = lspconfig.util.root_pattern("*.sln")(fname)
		local fallback = lspconfig.util.root_pattern("*.csproj")(fname)
		return primary or fallback
	end,
}
