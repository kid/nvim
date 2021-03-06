local layer = {}

function layer.init_config()
  local lsp = require("layers.lsp")
  local lspconfig = require("lspconfig")

  lsp.register_server(lspconfig.sumneko_lua, {
    cmd = {"lua-language-server"},
    settings = {
      Lua = {
        diagnostics = {
          globals = {
            "vim",
          },
        },
        runtime = {
          -- version = "LuaJIT",
          path = vim.split(package.path, ';'),
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          }
        },
      },
    },
  })
end

return layer
