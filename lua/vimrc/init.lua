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
      'ggandor/lightspeed.nvim',
      config = function ()
        require('lightspeed').setup {
          highlight_unique_chars = true,
          cycle_group_fwd_key = '<Tab',
          cycle_group_bwd_key = '<S-Tab>',
        }
      end
    }
    use { 'TimUntersberger/neogit', requires = { 'nvim-lua/plenary.nvim' } }
    use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('gitsigns').setup {}
      end,
    }
    use {
      'folke/which-key.nvim',
      config = function()
        require('which-key').setup()
      end,
    }
    -- FIXME conflicts with which-key.nvim
    -- use {
    --   'svermeulen/vim-cutlass', -- TODO not working?
    --   config = function()
    --     vim.api.nvim_set_keymap('n', 'm', 'd', { noremap = true })
    --     vim.api.nvim_set_keymap('x', 'm', 'd', { noremap = true })
    --     vim.api.nvim_set_keymap('n', 'mm', 'dd', { noremap = true })
    --     vim.api.nvim_set_keymap('n', 'M', 'D', { noremap = true })
    --   end,
    -- }
    -- TODO try bfredl/nvim-miniyank instead?
    -- or https://github.com/nvim-telescope/telescope.nvim/issues/255#issuecomment-731361724
    -- use 'svermeulen/vim-yoink'
    use {
      'gruvbox-community/gruvbox',
      config = function()
        vim.o.termguicolors = true
        vim.g.gruvbox_invert_selection = 0
        vim.api.nvim_command('colorscheme gruvbox')

        -- Don't wait forever for the next key
        vim.o.timeoutlen = 500

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

        vim.o.foldlevelstart = 10
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
      requires = { 'kyazdani42/nvim-web-devicons', 'folke/which-key.nvim' },
      config = function()
        require'bufferline'.setup {}
        local wk = require('which-key')

        wk.register({
          [']b'] = { '<cmd>BufferLineCycleNext<cr>', 'Next buffer' },
          ['[b'] = { '<cmd>BufferLineCyclePrev<cr>', 'Previous buffer' },
          [']t'] = { '<cmd>tabnext<cr>', 'Next tab' },
          ['[t'] = { '<cmd>tabprevious<cr>', 'Previous tab' },
        })
      end,
    }
    use {
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        vim.g.nvim_tree_gitignore = 1
        vim.g.nvim_tree_git_hl = 1
        vim.g.nvim_tree_follow = 1
        vim.g.nvim_tree_auto_close = 1
        vim.g.nvim_tree_disable_netrw = 1
        vim.g.nvim_tree_indent_markers = 1
        vim.g.nvim_tree_show_icons = { git = 0, files = 1, folders = 1 }

        vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true })
      end,
    }
    use 'towolf/vim-helm'
    use 'pearofducks/ansible-vim'
    use 'google/vim-jsonnet'
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

        vimp.nnoremap('<leader>y', '"+y')
        vimp.vnoremap('<leader>y', '"+y')
        vimp.nnoremap('<leader>Y', '"+y$')

        vimp.nnoremap('<leader>p', '"+p')
        vimp.vnoremap('<leader>p', '"+p')
        vimp.nnoremap('<leader>P', '"+P')

        vimp.nnoremap({ 'override', 'silent' }, '<C-s>', '<cmd>update<cr>')
        vimp.inoremap({ 'override', 'silent' }, '<C-s>', '<cmd>update<cr>')
        vimp.vnoremap({ 'override', 'silent' }, '<C-s>', '<cmd>update<cr>')

        vimp.inoremap({ 'silent' }, '<C-z>', '<cmd>stop<cr>')
        vimp.vnoremap({ 'silent' }, '<C-z>', '<cmd>stop<cr>')
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
