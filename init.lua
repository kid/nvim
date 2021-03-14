local execute = vim.api.nvim_command

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

execute('packadd packer.nvim')

-- Theses need to be done as early as possible
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'


require('packer').startup {
  function (use)
    -- let packer manage itself
    use {'wbthomason/packer.nvim', opt = true}
    use 'editorconfig/editorconfig-vim'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'tpope/vim-repeat'
    use 'unblevable/quick-scope'
    use {
      'easymotion/vim-easymotion',
      config = function ()
         vim.api.nvim_set_keymap('n', '<LocalLeader><LocalLeader>', '<Plug>(easymotion-prefix)', {})
         vim.api.nvim_set_keymap('n', '<LocalLeader><LocalLeader>w', '<Plug>(easymotion-bd-w)', {})
      end,
    }
    -- use {
    --   'lewis6991/gitsigns.nvim',
    --   requires = {
    --     'nvim-lua/plenary.nvim',
    --   },
    --   config = function ()
    --     require('gitsigns').setup {
    --       signs = {
    --         add          = {hl = 'DiffAdd'   , text = '│', numhl='GitSignsAddNr'},
    --         -- add    = { hl = 'GitGutterAdd' },
    --         change = { hl = 'GitGutterChange' },
    --       },
    --     }
    --   end
    -- }
    -- use 'liuchengxu/vim-which-key'
    use {
      'svermeulen/vim-cutlass', -- TODO not working?
      config = function ()
        vim.api.nvim_set_keymap('n', 'm',  'd',  { noremap = true })
        vim.api.nvim_set_keymap('x', 'm',  'd',  { noremap = true })
        vim.api.nvim_set_keymap('n', 'mm', 'dd', { noremap = true })
        vim.api.nvim_set_keymap('n', 'M',  'D',  { noremap = true })
      end,
    }
    -- TODO try bfredl/nvim-miniyank instead?
    -- or https://github.com/nvim-telescope/telescope.nvim/issues/255#issuecomment-731361724
    -- use 'svermeulen/vim-yoink'
    use {
      'gruvbox-community/gruvbox',
      config = function ()
        vim.api.nvim_command('colorscheme gruvbox')
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
        vim.wo.list = true
        vim.wo.listchars = 'tab:→ ,trail:-,extends:>,precedes:<,nbsp:+,eol:¬'

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
        vim.o.hlsearch = true

      end,
    }
    require('fuzzy')(use)
    require('statusline')(use)
    require('lsp')(use)
    require('completion')(use)
    require('treesitter')(use)

    vim.api.nvim_set_keymap('i', 'jk', '<esc>', {})
    vim.api.nvim_set_keymap('v', 'jk', '<esc>', {})

    vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
  end,
  config = {
    display = {
      -- Enable non interactive mode when running in headless mode
      non_interactive = vim.tbl_isempty(vim.api.nvim_list_uis()),
    },
  },
}
