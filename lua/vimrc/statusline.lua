return function(use)
  use {
    'nvim-lualine/lualine.nvim',
    requires = { { 'kyazdani42/nvim-web-devicons', opt = true } },
    config = function()
      require('lualine').setup { options = { section_separators = '', component_separators = '' } }
    end,
  }
end
