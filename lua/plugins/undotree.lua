--- Undotree (disabled)
-- return {
-- 	"mbbill/undotree",
-- 	keys = { "<leader>u", "<cmd>UndotreeToggle<cr>" },
-- 	config = function()
-- 		require("undotree").setup({})
-- 		-- vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
-- 	end,
-- }

--- Telescope undo (enabled)
return {
  'debugloop/telescope-undo.nvim',
  dependencies = { { 'nvim-telescope/telescope.nvim', dependencies = 'nvim-lua/plenary.nvim' } },
  keys = { { '<leader>u', '<cmd>Telescope undo<cr>' } },
  opts = {
    extensions = {
      undo = {
        side_by_side = true,
        layout_strategy = 'vertical',
        layout_config = {
          preview_height = 0.8,
        },
      },
    },
  },
  config = function(_, opts)
    require('telescope').setup(opts)
    require('telescope').load_extension 'undo'
  end,
}
