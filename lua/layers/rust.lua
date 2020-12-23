local layer = {}

function layer.plugins(use)
  use "rust-lang/rust.vim"
end


function layer.init_config()
  local lsp = require("layers.lsp")
  local lspconfig = require("lspconfig")

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  lsp.register_server(lspconfig.rust_analyzer, {
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          loadOutDirsFromCheck = true,
        },
        rustfmt = {
          overrideCommand = {
            "rustup", "run", "nightly", "--", "rustfmt", "--edition", "2018", "--",
          },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  })
end

return layer
