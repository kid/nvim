local layer = {}

function layer.register_plugins()
end

function layer.init_config()
	local lsp = require("layers.lsp")
	local nvim_lsp = require("nvim_lsp")

	lsp.register_server(nvim_lsp.flow)
end

return layer
