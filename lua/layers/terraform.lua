local layer = {}

function layer.plugins(use)
  use "hashivim/vim-terraform"
end

function layer.init_config()
  local lsp = require("layers.lsp")
  local lspconfig = require("lspconfig")

  lsp.register_server(lspconfig.terraformls)
end

return layer
