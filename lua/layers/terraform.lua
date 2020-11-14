local layer = {}

function layer.plugins(use)
  use "hashivim/vim-terraform"
end

function layer.init_config()
  local lsp = require("layers.lsp")
  local nvim_lsp = require("nvim_lsp")

  lsp.register_server(nvim_lsp.terraformls)
end

return layer
