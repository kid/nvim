local layer = {}

function layer.init_config()
  local lsp = require("layers.lsp")
  local lspconfig = require("lspconfig")

  lsp.register_server(lspconfig.gopls)
end

return layer
