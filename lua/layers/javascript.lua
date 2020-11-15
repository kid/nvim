local layer = {}

function layer.init_config()
  local lsp = require("layers.lsp")
  local lspconfig = require("lspconfig")
  local configs = require("lspconfig/configs")
  local util = require("lspconfig/util")

  local server_name = "javascript_typescript_langserver"
  local bin_name = "javascript-typescript-stdio"

  configs[server_name]  = {
    default_config = {
      cmd = { bin_name };
      filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" };
      root_dir = util.root_pattern("package.json", "tsconfig.json", ".git");
      settings = {};
    };
  };

  lsp.register_server(lspconfig.javascript_typescript_langserver)
end

return layer
