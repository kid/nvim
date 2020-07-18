local layer = {}

local plug = require("core.plug")

function layer.register_plugins()
	plug.add("kyazdani42/nvim-web-devicons")
	plug.add("kyazdani42/nvim-tree.lua")
end

function layer.init_config()
	vim.g.lua_tree_ignore = {'.git', 'node_modules', '.cache'}
	vim.g.lua_tree_auto_open = 1
	vim.g.lua_tree_auto_close = 1
	vim.g.lua_tree_follow = 1
	vim.g.lua_tree_indent_markers = 1
end

return layer
