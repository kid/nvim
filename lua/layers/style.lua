local layer = {}
local plug = require("core.plug")

function layer.register_plugins()
	-- plug.add('vim-airline/vim-airline')
	plug.add('gruvbox-community/gruvbox')
end

function layer.init_config()
	vim.o.termguicolors = true
	vim.api.nvim_command("colorscheme gruvbox")

	-- Faster updatetime for quick CursorHold updates
	vim.o.updatetime = 250

	-- Faster redrawing
	vim.o.lazyredraw = true

	-- Allow hidden buffers
	vim.o.hidden = true

	-- Don't show current mode, we have the status line for this
	vim.o.showmode = false

	-- Show partial commands in the bottim right
	-- TODO seems to be the default?
	vim.o.showcmd = true

	-- Highlight the cursorline
	vim.wo["cursorline"] = true

	-- Line numbers and relative line numbers
	vim.wo.number = true
	vim.wo.relativenumber = true

	-- Open splits to the right
	vim.o.splitright = true

	-- Show tabs and trailign spaces
	vim.wo.list = true
	vim.wo.listchars = "tab:→ ,trail:-,extends:>,precedes:<,nbsp:+,eol:¬"

	-- Always show the sign column
	vim.wo.signcolumn = "yes"

	-- Allow mouse support
	vim.o.mouse = "a"

	-- Incremental search and search/replace
	vim.o.incsearch = true
	vim.o.inccommand = "split"

	-- Case insensitive search if the query is lowercase
	vim.o.ignorecase = true
	vim.o.smartcase = true

	-- Highlight while searching
	vim.o.hlsearch = true

	if plug.has('vim-airline') then
		-- Use vim-airline's tabline, and enable powerline symbols
		vim.g.airline_powerline_fonts = 1
		vim.g["airline#extensions#tabline#enabled"] = 1
	end


	vim.wo.statusline = ""
end

return layer
