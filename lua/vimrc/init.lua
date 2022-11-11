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
    use 'tpope/vim-surround'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'tpope/vim-repeat'
    -- use {
    --   'startup-nvim/startup.nvim',
    --   requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    --   config = function()
    --     require('startup').setup {
    --       theme = 'startify',
    --     }
    --   end,
    -- }
    use {
      'numToStr/Comment.nvim',
      requires = {},
      config = function()
        require('Comment').setup()
      end,
    }
    use {
      'ggandor/lightspeed.nvim',
      config = function()
        require('lightspeed').setup {}
      end,
    }
    use {
      'https://gitlab.com/yorickpeterse/nvim-window.git',
      config = function()
        require('which-key').register { ['<leader>w'] = { require('nvim-window').pick, 'Pick window' } }
      end,
    }
    use {
      'chentoast/marks.nvim',
      config = function()
        require('marks').setup {}
      end,
    }
    use {
      'ldelossa/gh.nvim',
      requires = { 'ldelossa/litee.nvim' },
      config = function()
        require('litee.lib').setup()
        require('litee.gh').setup()
        local wk = require("which-key")
        wk.register({
          g = {
            name = "+Git",
            h = {
              name = "+Github",
              c = {
                name = "+Commits",
                c = { "<cmd>GHCloseCommit<cr>", "Close" },
                e = { "<cmd>GHExpandCommit<cr>", "Expand" },
                o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
                p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
                z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
              },
              i = {
                name = "+Issues",
                p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
              },
              l = {
                name = "+Litee",
                t = { "<cmd>LTPanel<cr>", "Toggle Panel" },
              },
              r = {
                name = "+Review",
                b = { "<cmd>GHStartReview<cr>", "Begin" },
                c = { "<cmd>GHCloseReview<cr>", "Close" },
                d = { "<cmd>GHDeleteReview<cr>", "Delete" },
                e = { "<cmd>GHExpandReview<cr>", "Expand" },
                s = { "<cmd>GHSubmitReview<cr>", "Submit" },
                z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
              },
              p = {
                name = "+Pull Request",
                c = { "<cmd>GHClosePR<cr>", "Close" },
                d = { "<cmd>GHPRDetails<cr>", "Details" },
                e = { "<cmd>GHExpandPR<cr>", "Expand" },
                o = { "<cmd>GHOpenPR<cr>", "Open" },
                p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
                r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
                t = { "<cmd>GHOpenToPR<cr>", "Open To" },
                z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
              },
              t = {
                name = "+Threads",
                c = { "<cmd>GHCreateThread<cr>", "Create" },
                n = { "<cmd>GHNextThread<cr>", "Next" },
                t = { "<cmd>GHToggleThread<cr>", "Toggle" },
              },
            },
          },
        }, { prefix = "<leader>" })
      end
    }
    use {
      'TimUntersberger/neogit',
      requires = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
      config = function()
        local neogit = require('neogit')
        neogit.setup { kind = 'tab', disable_commit_confirmation = true, integrations = { diffview = true } }

        require('which-key').register { ['<leader>g'] = { name = '+Git', g = { neogit.open, 'Neogit' } } }
      end,
    }
    use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('gitsigns').setup {}
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

        vim.o.title = true;

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

        vim.opt.splitright = true

        -- Incremental search and search/replace
        vim.o.incsearch = true
        vim.o.inccommand = 'nosplit'

        vim.o.hlsearch = false

        -- Case insensitive search if the query is lowercase
        vim.o.ignorecase = true
        vim.o.smartcase = true

        -- Highlight while searching
        -- vim.o.hlsearch = true

        -- Don't insert comments when hitting 'o' or 'O'
        vim.opt.formatoptions:remove('o')

        vim.o.foldlevelstart = 10

        vim.o.shiftwidth = 2
        vim.o.tabstop = 2
        vim.o.expandtab = true
      end,
    }
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        vim.g.indent_blankline_char = '│'
        vim.g.indent_blankline_use_treesitter = true
        vim.g.indent_blankline_filetype_exclude = { 'startup', 'NvimTree', 'Trouble', 'man' }
      end,
    }
    use {
      'akinsho/bufferline.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require('bufferline').setup {}
        local wk = require('which-key')

        wk.register {
          [']b'] = { '<cmd>BufferLineCycleNext<cr>', 'Next buffer' },
          ['[b'] = { '<cmd>BufferLineCyclePrev<cr>', 'Previous buffer' },
          [']t'] = { '<cmd>tabnext<cr>', 'Next tab' },
          ['[t'] = { '<cmd>tabprevious<cr>', 'Previous tab' },
        }
      end,
    }
    use {
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require('nvim-tree').setup {
          disable_netrw = true,
          diagnostics = { enable = true },
          update_focused_file = { enable = true },
          -- view = { auto_resize = true },
          renderer = {
            indent_markers = {
              enable = true,
            },
          },
        }

        vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true })
      end,
    }
    use 'towolf/vim-helm'
    use {
      'pearofducks/ansible-vim',
      config = function()
        vim.g.ansible_unindent_after_newline = 1
      end,
    }
    use 'google/vim-jsonnet'
    use 'hashivim/vim-terraform'
    use 'tsandall/vim-rego'
    use {
      'folke/which-key.nvim',
      config = function()
        local wk = require('which-key')

        wk.setup()
        wk.register({ ['<leader>r'] = { require('vimrc.utils').reload, 'Reload config' } })

        vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {})
        vim.api.nvim_set_keymap('v', 'jk', '<Esc>', {})

        vim.api.nvim_set_keymap('c', '<C-a>', '<Home>', {})
        vim.api.nvim_set_keymap('c', '<C-e>', '<End>', {})

        vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {})
        vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {})
        vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {})
        vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {})

        vim.api.nvim_set_keymap('n', 'Y', 'y$', {})

        vim.api.nvim_set_keymap('n', '<leader>y', '"+y', {})
        vim.api.nvim_set_keymap('v', '<leader>y', '"+y', {})
        vim.api.nvim_set_keymap('n', '<leader>Y', '"+y$', {})

        vim.api.nvim_set_keymap('n', '<leader>p', '"+p', {})
        vim.api.nvim_set_keymap('v', '<leader>p', '"+p', {})
        vim.api.nvim_set_keymap('n', '<leader>P', '"+P', {})

        vim.api.nvim_set_keymap('i', '<C-s>', '<cmd>update<cr>', { silent = true })
        vim.api.nvim_set_keymap('v', '<C-s>', '<cmd>update<cr>', { silent = true })
        vim.api.nvim_set_keymap('n', '<C-s>', '<cmd>update<cr>', { silent = true })

        vim.api.nvim_set_keymap('i', '<C-z>', '<cmd>stop<cr>', { silent = true })
        vim.api.nvim_set_keymap('v', '<C-z>', '<cmd>stop<cr>', { silent = true })
      end,
    }
    use {
      'norcalli/nvim-colorizer.lua',
      config = function()
        vim.o.termguicolors = true
        require('colorizer').setup()
      end,
    }
    use {
      'j-hui/fidget.nvim',
      config = function ()
        require('fidget').setup()
      end
    }

    -- use {
    --   'williamboman/mason.nvim',
    --   config = function()
    --     require('mason').setup()
    --   end,
    -- }


    use {
      'VonHeikemen/lsp-zero.nvim',
      requires = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },

        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },

        -- Others
        { 'windwp/nvim-autopairs' },
      },
      config = function ()
        require('mason').setup()
        require('mason-lspconfig').setup()

        local lsp = require('lsp-zero')
        lsp.preset('recommended')
        -- lsp.preset('system-lsp')

        local cmp = require('cmp')
        local cmp_mapping = lsp.defaults.cmp_mappings()

        cmp_mapping['<C-h>'] = cmp_mapping['<C-b>']
        cmp_mapping['<C-l>'] = cmp_mapping['<C-d>']
        cmp_mapping['<C-y>'] = cmp.mapping.confirm({ select = true })
        cmp_mapping['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })
        cmp_mapping['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })

        require('nvim-autopairs').setup()
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

        lsp.setup_nvim_cmp({
          mapping = cmp_mapping,
        })

        lsp.nvim_workspace()
        lsp.setup()
      end
    }

    require('vimrc.orgmode')(use)
    require('vimrc.fuzzy')(use)
    require('vimrc.statusline')(use)
    -- require('vimrc.lsp')(use)
    -- require('vimrc.completion')(use)
    require('vimrc.treesitter')(use)

    vim.api.nvim_command([[autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()]])
  end,
  config = {
    display = {
      -- Enable non interactive mode when running in headless mode
      non_interactive = vim.tbl_isempty(vim.api.nvim_list_uis()),
    },
  },
}
