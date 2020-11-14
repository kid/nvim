local layer = {}

function layer.plugins(use)
  use "akinsho/nvim-bufferline.lua"
end

function layer.init_config()
  require('bufferline').setup{
    options = {
      view = "multiwindow",
    }
  }
end

return layer
