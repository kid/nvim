local layer = {}

function layer.init_config()
  local lsp = require("layers.lsp")
  local lspconfig = require("lspconfig")

  local config = {}

  config["yaml.schemas"] = {
    kubernetes = "/*"
  }

  lsp.register_server(lspconfig.yamlls, config)
end

return layer
