local layer = {}

local plug = require("core.plug")

function layer.register_plugins()
	plug.add("neovim/nvim-lsp")
	plug.add("haorenW1025/completion-nvim")
	plug.add("haorenW1025/diagnostic-nvim")
	plug.add("hrsh7th/vim-vsnip")
	plug.add("hrsh7th/vim-vsnip-integ")
	plug.add("wbthomason/lsp-status.nvim")
end

function layer.init_config()
	vim.o.completeopt = "menuone,noinsert,noselect"

	local lsp_status = require("lsp-status")
	lsp_status.register_progress()

	vim.g.diagnostic_enable_virtual_text = 1
	vim.g.completion_enable_snippet = 'vim-vsnip'

	lsp_status.config { kind_labels = vim.g.completion_customize_lsp_label }

	-- if plug.has("vim-airline") then
		vim.api.nvim_exec(
			[[
				function! LspStatus() abort
					if luaeval('#vim.lsp.buf_get_clients() > 0')
						return luaeval('require("lsp-status").status()')
					endif

					return ''
					-- return luaeval("require('layers.lsp')._get_airline_part()")
				endfunction
			]],
			false
		)

		vim.fn["airline#parts#define_function"]("c_lsp", "LspStatus")
		-- vim.fn["airline#parts#define_function"]("c_lsp", "LspStatus")
		-- vim.fn["airline#parts#define_accent"]("c_lsp", "yellow")
		vim.g.airline_section_y = vim.fn["airline#section#create_right"]{"c_lsp", "ffenc"}
	-- end
end

function layer.register_server(server, config)
	local lsp_status = require("lsp-status")
	local completion = require("completion")
	local diagnostic = require("diagnostic")

	config = config or {}

	config.on_attach = function(client, bufnr)
		completion.on_attach(client)
		diagnostic.on_attach(client, bufnr)
		lsp_status.on_attach(client)
	end

	config.capabilities = lsp_status.capabilities

	config = vim.tbl_extend("keep", config, server.document_config.default_config)

	server.setup(config)

	-- for _, v in pairs(config.filetypes) do
	-- 	layer.filetype_servers[v] = server
	-- end

end

--- Get the LSP status line part for vim-airline
function layer._get_airline_part()
	local clients = vim.lsp.buf_get_clients()
	local client_names = {}

	for _, v in pairs(clients) do
		table.insert(client_names, v.name)
	end

	if #client_names > 0 then
		local sections = { "LSP:", table.concat(client_names, ", ") }

		local error_count = vim.lsp.util.buf_diagnostics_count("Error")
		if error_count ~= nil and error_count > 0 then table.insert(sections, "E: " .. error_count) end

		local warn_count = vim.lsp.util.buf_diagnostics_count("Warning")
		if error_count ~= nil and warn_count > 0 then table.insert(sections, "W: " .. warn_count) end

		local info_count = vim.lsp.util.buf_diagnostics_count("Information")
		if error_count ~= nil and info_count > 0 then table.insert(sections, "I: " .. info_count) end

		local hint_count = vim.lsp.util.buf_diagnostics_count("Hint")
		if error_count ~= nil and hint_count > 0 then table.insert(sections, "H: " .. hint_count) end

		return table.concat(sections, " ")
	else
		return ""
	end
end

return layer
