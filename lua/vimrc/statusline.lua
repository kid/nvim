return function(use)
  use {
    'hoob3rt/lualine.nvim',
    requires = {{'kyazdani42/nvim-web-devicons', opt = true}},
    config = function()
      require('lualine').setup {options = {section_separators = '', component_separators = ''}}
    end,
  }
end
