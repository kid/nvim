local layer = {}

function layer.plugins(use)
  use "rust-lang/rust.vim"
end


function layer.init_config()
  local lsp = require("layers.lsp")
  local lspconfig = require("lspconfig")

  lsp.register_server(lspconfig.rust_analyzer)
end

return layer
