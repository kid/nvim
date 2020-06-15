local plug = {}

-- local log = require("core.log")

plug.plugins = {}

function plug.add(repo_name)
	table.insert(plug.plugins, repo_name)

	local split = vim.split(repo_name, "/", true)
	local name = split[#split]

	vim.api.nvim_command("packadd " .. name)
end

function plug.has(name)
	for _, v in ipairs(plug.plugins) do
		if string.match(v, name) then
			return true
		end
	end

	return false
end

return plug
