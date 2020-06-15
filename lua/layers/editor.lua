local layer = {}

local plug = require("core.plug")

local log = require("core.log")

function layer.register_plugins()
	plug.add("tpope/vim-commentary")
	plug.add("tpope/vim-surround")
	plug.add("editorconfig/editorconfig-vim")
	plug.add("easymotion/vim-easymotion")
end

function layer.init_config()
	vim.o.shortmess = vim.o.shortmess .. "c"
	vim.o.swapfile = false
end

return layer
