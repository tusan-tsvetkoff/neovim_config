local header = require('dashboards')
local icons = require('icons')
local copilot_exists = false

local clients_min_format = function(clients)
  if #clients == 0 or clients[1] == nil then
    return ''
  end
  if #clients == 1 then
    return string.format('%s[󰒓 LSP] %s', copilot_exists and ' ' or '', clients[1])
  else
    local first_client = clients[1]
    table.remove(clients, 1)
    local new_client_names = {}
    for _, client in ipairs(clients) do
      copilot_exists = client == '' and true or false
      client = #client >= 3 and string.sub(client, 1, 3) or client
      table.insert(new_client_names, client)
    end
    local res = string.format(
      '%s[󰒓 LSP] %s %s',
      copilot_exists and ' ' or '',
      first_client,
      table.concat(new_client_names, '')
    )
    print(res)
    return res
  end
end

local function split_string(inputstr, sep)
  if sep == nil then
    sep = '%s'
  end
  local t = {}
  for str in string.gmatch(inputstr, '([^' .. sep .. ']+)') do
    table.insert(t, str)
  end
  return t
end

local function trunc_file_name()
  local full_path = vim.fn.expand('%:p')
  local parent = vim.fn.fnamemodify(full_path, ':h:t')
  local name = vim.fn.fnamemodify(full_path, ':t')

  if vim.bo.buftype == 'terminal' then
    return ' pwsh'
  end

  if parent == '.' then
    return name
  end

  return string.format('%s/%s', parent, name)
end

return {
  {
    -- 'echasnovski/mini.nvim',
    'tusan/mini.nvim',
    dev = true,
    dependencies = {
      {
        'lewis6991/gitsigns.nvim',
        opts = {
          signs = {
            add = { text = '▎' },
            change = { text = '▎' },
            delete = { text = '▎' },
            topdelete = { text = '契' },
            changedelete = { text = '▎' },
            untracked = { text = '▎' },
          },
        },
        config = function(_, opts)
          require('gitsigns').setup(opts)

          vim.keymap.set('n', '<leader>gj', function()
            require('gitsigns').next_hunk()
          end, { desc = 'Next Hunk' })
          vim.keymap.set('n', '<leader>gk', function()
            require('gitsigns').prev_hunk()
          end, { desc = 'Prev Hunk' })
          vim.keymap.set('n', '<leader>gp', function()
            require('gitsigns').preview_hunk()
          end, { desc = 'Preview Hunk' })
          vim.keymap.set('n', '<leader>gS', function()
            require('gitsigns').stage_hunk()
          end, { desc = 'Stage Hunk' })
          vim.keymap.set('n', '<leader>gu', function()
            require('gitsigns').undo_stage_hunk()
          end, { desc = 'Undo Stage Hunk' })
        end,
      },
      { 'f-person/git-blame.nvim', opts = {} },
    },
    config = function()
      require('mini.ai').setup({ n_lines = 500 })
      require('mini.starter').setup({ header = header.get_header })
      require('mini.indentscope').setup()

      local s = require('mini.statusline')

      s.setup({
        use_git_blame = true,
        content = {
          active = function()
            local mode, mode_hl = s.section_mode({ trunc_width = 120 })
            local git = s.section_git({ trunc_width = 75 })
            local git_parts = split_string(git, ' ')[2]
            local git_section = string.format('%s %s', icons.general.branch, git_parts)
            git = git_parts ~= nil and git_section or ''
            local my_git_blame = s.section_git_blame({ trunc_width = 120 })
            local diagnostics = s.section_diagnostics({ trunc_width = 75 })
            local fileinfo = s.section_fileinfo({ trunc_width = 120 })
            local search = s.section_searchcount({ trunc_width = 75 })
            local location = function()
              return '%2l:%-2v'
            end

            local split_info = split_string(fileinfo, ' ')
            local icon = split_info[1]

            local clients = {}
            for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
              if client.name ~= 'copilot' then
                table.insert(clients, client.name)
              else
                copilot_exists = true
              end
            end

            return s.combine_groups({
              {
                hl = mode_hl,
                strings = { string.format('%s %s', icons.general.neovim, mode) },
              },
              { hl = 'MiniStatusLineDevInfo', strings = { git, diagnostics } },
              '%<',
              { hl = 'MiniStatuslineFilename', strings = { icon, trunc_file_name() } },
              '%=',
              { hl = 'MiniStatuslineFilename', strings = { my_git_blame } },
              {
                hl = 'MiniStatuslineFileinfo',
                strings = { clients_min_format(clients) },
              },
              { hl = mode_hl, strings = { search, location() } },
            })
          end,
        },
      })
    end,
  },
}
