function Config()
  local is_mac = vim.fn.has('macunix') > 0
  local folder = is_mac and '/Volumes/org' or '~/org'

  local parser_config = require'nvim-treesitter.parsers'.get_parser_configs()
  parser_config.org = {
    install_info = {
      url = 'https://github.com/milisims/tree-sitter-org',
      revision = 'main',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    filetype = 'org',
  }

  require('orgmode').setup {
    org_agenda_files = { folder .. '/**/*' },
    org_default_notes_file = folder .. '/notes.org'
  }

  require('org-bullets').setup()
  require('headlines').setup()
end

return function(use)
  use {
    'kristijanhusak/orgmode.nvim',
    requires = { 'akinsho/org-bullets.nvim', 'lukas-reineke/headlines.nvim' },
    config = Config
  }
end
