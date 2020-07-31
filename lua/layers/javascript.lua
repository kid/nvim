local layer = {}

function layer.register_plugins()
end

function layer.init_config()
	local lsp = require("layers.lsp")
	local nvim_lsp = require("nvim_lsp")
	local configs = require("nvim_lsp/configs")
	local util = require("nvim_lsp/util")

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

	lsp.register_server(nvim_lsp.javascript_typescript_langserver)

	-- lsp.register_server(nvim_lsp.flow)
end

return layer
