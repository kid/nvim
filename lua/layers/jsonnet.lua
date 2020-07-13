local layer = {}

local plug = require("core.plug")

function layer.register_plugins()
	plug.add("google/vim-jsonnet")
end

function layer.init_config()
end

return layer
