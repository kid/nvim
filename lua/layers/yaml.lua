local layer = {}

function layer.register_plugins()
end

function layer.init_config()
	local lsp = require("layers.lsp")
	local nvim_lsp = require("nvim_lsp")

	local config = {}

	config["yaml.schemas"] = {
		kubernetes = "/*"
	}

	lsp.register_server(nvim_lsp.yamlls, config)
end

return layer
