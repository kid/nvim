local layer = {}

local plug = require("core.plug")

function layer.register_plugins()
	plug.add("junegunn/fzf")
	plug.add("junegunn/fzf.vim")
end

function layer.init_config()
	vim.g.fzf_buffers_jump = 1
	vim.g.fzf_preview_window = ''
end

return layer
