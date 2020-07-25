local layer = {}

local plug = require("core.plug")

function layer.register_plugins()
	plug.add("rust-lang/rust.vim")
end

function layer.init_config()
	local lsp = require("layers.lsp")
	local nvim_lsp = require("nvim_lsp")

	lsp.register_server(nvim_lsp.rust_analyzer)
end

return layer
