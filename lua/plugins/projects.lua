return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  opts = { -- Manual mode doesn't automatically change your root directory, so you have
    manual_mode = false,
    detection_methods = { "pattern", "lsp" },
    patterns = {
      ".git",
      "Cargo.toml",
      "pubspec.yaml",
      "*.cfg",
      "CMakeLists.txt",
      "build.zig",
      ".sln",
      ".vscode",
      ".svn",
      "Makefile",
      "package.json",
    },

    ignore_lsp = {},
    exclude_dirs = {
      "~/",
    },
    show_hidden = false,
    silent_chdir = true,
    scope_chdir = "global",
    datapath = vim.fn.stdpath("data"),
    event = "VeryLazy",
  },
  config = function(_, opts)
    require("project_nvim").setup(opts)
  end,
}
