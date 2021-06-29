function config()
  local is_mac = vim.fn.has('macunix')
  local folder = is_mac and '/Volumes/org' or '~/org'

  require('orgmode').setup {
    org_agenda_files = { folder .. '/**/*' },
    org_default_notes_file = folder .. '/notes.org',
  }
end

return function(use)
  use { 'kristijanhusak/orgmode.nvim', config = config }
end
