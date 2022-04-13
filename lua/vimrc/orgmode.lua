function Config()
  local is_mac = vim.fn.has('macunix') > 0
  local folder = is_mac and '/Volumes/org' or '~/org'

  local orgmode = require('orgmode')
  orgmode.setup_ts_grammar()
  orgmode.setup { org_agenda_files = { folder .. '/**/*' }, org_default_notes_file = folder .. '/notes.org' }

  require('org-bullets').setup()
  require('headlines').setup()
end

return function(use)
  use {
    'kristijanhusak/orgmode.nvim',
    requires = { 'akinsho/org-bullets.nvim', 'lukas-reineke/headlines.nvim', 'dhruvasagar/vim-table-mode' },
    config = Config,
  }
end
