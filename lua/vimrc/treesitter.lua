return function(use)
  use {
    'nvim-treesitter/nvim-treesitter',
    require = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = {'org'},
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },
        refactor = {
          highlight_defintions = { enable = false },
          smart_rename = {
            -- enable = true,
            -- smart_rename = 'grr',             -- mapping to rename reference under cursor
          },
          navigation = {
            -- enable = true,
            -- goto_definition = 'gnd',          -- mapping to go to definition of symbol under cursor
            -- list_definitions = 'gnD'          -- mapping to list all definitions in current file
          },
        },
        context_commentstring = {
          enable = true
        },
        ensure_installed = { 'bash', 'dockerfile', 'go', 'javascript', 'json', 'json5', 'lua', 'nix', 'regex', 'ruby', 'rust', 'haskell', 'org', },
      }

      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

      -- vim.api.nvim_set_keymap(
      --   'n', '<Tab>', [[@=(foldlevel('.')?'za':"\<Tab>")<CR>]],
      --   { expr = false, noremap = true, silent = true }
      -- )

      local wk = require('which-key')

      wk.register { gnn = 'Init selection', grn = 'Increase node', grm = 'Decrease node', grc = 'Increase scope' }
    end,
  }
end
