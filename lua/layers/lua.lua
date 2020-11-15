local layer = {}

function layer.init_config()
  local lsp = require("layers.lsp")
  local lspconfig = require("lspconfig")

  lsp.register_server(
  lspconfig.sumneko_lua,
    {
      settings = {
        Lua = {
          diagnostics = {
            globals = {
              "vim",
            },
          },
          runtime = {
            version = "LuaJIT",
          },
        },
      },
    }
  )
end

return layer
