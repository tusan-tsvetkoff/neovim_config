return {
  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup {
        level = 2,
        minimum_width = 50,
        render = 'default',
        stages = 'fade',
        timeout = 3000,
        top_down = true,
        icons = {
          ERROR = '',
          WARN = '',
          INFO = '',
          DEBUG = '',
          TRACE = '✎',
        },
      }
      local notify = require 'notify'
      vim.notify = notify
      vim.api.nvim_notify = notify
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
  },
}
