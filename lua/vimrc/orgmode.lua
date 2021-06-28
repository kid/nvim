function config()
  require('orgmode').setup {

  }
end

return function(use)
  use { 'kristijanhusak/orgmode.nvim', config = config }
end
