local config = function ()
  require('lualine').setup()
end

return function (use)
  use {
    'hoob3rt/lualine.nvim',
    requires = {
      {'kyazdani42/nvim-web-devicons', opt = true},
    },
    config = config,
  }
end
