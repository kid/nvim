local execute = vim.api.nvim_command

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

execute('packadd packer.nvim')

-- Theses need to be done as early as possible
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require('packer').startup {
  function(use)
    -- let packer manage itself
    use { 'wbthomason/packer.nvim', opt = true }
    use 'editorconfig/editorconfig-vim'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'tpope/vim-repeat'
    use {
      'unblevable/quick-scope',
      config = function()
        -- Reduce slowdowns, specifically when using V-Block mode
        vim.g.qs_lazy_highlight = 1
      end
    }
    use {
      'easymotion/vim-easymotion',
      config = function()
        vim.g.EasyMotion_do_mapping = 0
        vim.api.nvim_set_keymap('n', '<LocalLeader><LocalLeader>', '<Plug>(easymotion-prefix)', {})
        vim.api.nvim_set_keymap('n', '<LocalLeader><LocalLeader>w', '<Plug>(easymotion-bd-w)', {})
      end,
    }
    use { 'TimUntersberger/neogit', requires = { 'nvim-lua/plenary.nvim' } }
    use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('gitsigns').setup {}
      end,
    }
    use 'liuchengxu/vim-which-key'
    use {
      'svermeulen/vim-cutlass', -- TODO not working?
      config = function()
        vim.api.nvim_set_keymap('n', 'm', 'd', { noremap = true })
        vim.api.nvim_set_keymap('x', 'm', 'd', { noremap = true })
        vim.api.nvim_set_keymap('n', 'mm', 'dd', { noremap = true })
        vim.api.nvim_set_keymap('n', 'M', 'D', { noremap = true })
      end,
    }
    -- TODO try bfredl/nvim-miniyank instead?
    -- or https://github.com/nvim-telescope/telescope.nvim/issues/255#issuecomment-731361724
    -- use 'svermeulen/vim-yoink'
    use {
      'gruvbox-community/gruvbox',
      config = function()
        vim.api.nvim_command('colorscheme gruvbox')
        vim.g.gruvbox_invert_selection = 0
        vim.o.termguicolors = true

        -- Don't wait forever for the next key
        vim.g.timeoutlen = 200

        -- Faster updatetime for quick CursorHold updates
        vim.o.updatetime = 100

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
        vim.wo['cursorline'] = true

        -- Line numbers and relative line numbers
        vim.wo.number = true
        vim.wo.relativenumber = true

        -- Show tabs and trailign spaces
        -- vim.wo.list = true
        -- vim.wo.listchars = 'tab:→ ,trail:-,extends:>,precedes:<,nbsp:+,eol:¬'

        -- Always show the sign column
        vim.wo.signcolumn = 'yes'

        -- Allow mouse support
        vim.o.mouse = 'a'

        -- Incremental search and search/replace
        vim.o.incsearch = true
        vim.o.inccommand = 'nosplit'

        vim.o.hlsearch = false

        -- Case insensitive search if the query is lowercase
        vim.o.ignorecase = true
        vim.o.smartcase = true

        -- Highlight while searching
        -- vim.o.hlsearch = true
      end,
    }
    use {
      'lukas-reineke/indent-blankline.nvim',
      branch = 'lua',
      config = function()
        vim.g.indent_blankline_char = '│'
        vim.g.indent_blankline_use_treesitter = true
        vim.g.indent_blankline_filetype_exclude = { 'NvimTree' }
      end,
    }
    use {
      'akinsho/nvim-bufferline.lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require'bufferline'.setup {}
        local vimp = require('vimp')
        vimp.nnoremap({ 'repeatable' }, '[b', ':BufferLineCyclePrev<CR>')
        vimp.nnoremap({ 'repeatable' }, ']b', ':BufferLineCycleNext<CR>')
        vimp.nnoremap({ 'repeatable' }, '[t', ':tabprevious<CR>')
        vimp.nnoremap({ 'repeatable' }, ']t', ':tabnext<CR>')
      end,
    }
    use {
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        vim.g.nvim_tree_gitignore = 1
        vim.g.nvim_tree_follow = 1
        vim.g.nvim_tree_auto_close = 0
        vim.g.vim_tree_disable_netrw = 1

        vim.api.nvim_set_keymap('n', '<Leader>n', ':NvimTreeToggle<CR>', { noremap = true })
      end,
    }
    use 'towolf/vim-helm'
    use 'pearofducks/ansible-vim'
    use {
      'svermeulen/vimpeccable',
      config = function()
        local vimp = require('vimp')
        vimp.nnoremap('<leader>r', require('vimrc.utils').reload)

        vimp.inoremap('jk', '<Esc>')
        vimp.vnoremap('jk', '<Esc>')

        vimp.cnoremap('<C-a>', '<Home>')
        vimp.cnoremap('<C-e>', '<End>')

        vimp.nnoremap('<C-h>', '<C-w>h')
        vimp.nnoremap('<C-j>', '<C-w>j')
        vimp.nnoremap('<C-k>', '<C-w>k')
        vimp.nnoremap('<C-l>', '<C-w>l')

        vimp.nnoremap('Y', 'y$')

        vimp.nnoremap('<Leader>y', '"+y')
        vimp.vnoremap('<Leader>y', '"+y')
        vimp.nnoremap('<Leader>Y', '"+y$')

        vimp.nnoremap('<Leader>p', '"+p')
        vimp.vnoremap('<Leader>p', '"+p')
        vimp.nnoremap('<Leader>P', '"+P')

        vimp.nnoremap({ 'silent' }, '<C-s>', '<cmd>update<cr>')
        vimp.inoremap({ 'silent' }, '<C-s>', '<cmd>update<cr>')
        vimp.vnoremap({ 'silent' }, '<C-s>', '<cmd>update<cr>')
      end,
    }

    require('vimrc.fuzzy')(use)
    require('vimrc.statusline')(use)
    require('vimrc.lsp')(use)
    require('vimrc.completion')(use)
    require('vimrc.treesitter')(use)

    vim.api.nvim_command([[
      autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
    ]])
  end,
  config = {
    display = {
      -- Enable non interactive mode when running in headless mode
      non_interactive = vim.tbl_isempty(vim.api.nvim_list_uis()),
    },
  },
}
