local log = {}

local echo

function log.init()
	vim.api.nvim_exec(
		[[
			function! CLogEcho(text)
				echo a:text
			endfunction
		]],
		false
	)

	echo = vim.fn["CLogEcho"]
end

function log.log(...)
	local entries = {...}
	local str_entries = {}

	for k, v in pairs(entries) do
		str_entries[k] = tostring(v)
	end

	local str = table.concat(str_entries, " ")
	echo(str)
end

function log.set_highlight(highlight_name)
	vim.api.nvim_command("echohl " .. highlight_name)
end

setmetatable(
	log,
	{
		__call = function(_, ...)
			log.log(...)
		end,
	}
)

return log
