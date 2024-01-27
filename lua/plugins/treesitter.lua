return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate", 
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "rust", "diff",
          "jsdoc", "json", "jsonc", "html", "css", "yaml", "luadoc" },

        sync_install = false,
        auto_install = true,

        indent = {
          enable = true
        },

        highlight = {
          enable = true,
        },
      })

      local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      treesitter_parser_config.templ = {
        install_info = {
          url = "https://github.com/vrischmann/tree-sitter-templ.git",
          branch = "master",
        },
      }

      vim.treesitter.language.register('templ', 'templ')
    end
	}
}
