local layer = {}

local plug = require("core.plug")

function layer.register_plugins()
	plug.add("neovim/nvim-lsp")
	plug.add("nvim-lua/completion-nvim")
	plug.add("nvim-lua/diagnostic-nvim")
	plug.add("nvim-lua/lsp-status.nvim")
	plug.add("hrsh7th/vim-vsnip")
	plug.add("hrsh7th/vim-vsnip-integ")
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
				endfunction
			]],
			false
		)

		vim.fn["airline#parts#define_function"]("c_lsp", "LspStatus")
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

return layer
