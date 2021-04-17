return function(use)
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim', 'unblevable/quick-scope', 'svermeulen/vimpeccable'},
    config = function()
      local vimp = require('vimp')
      local builtin = require('telescope.builtin')

      local ensure_out_of_tree = function(func)
        return function()
          -- if NvimTree is currently focussed, switch to the previous window first
          if vim.api.nvim_buf_get_option(0, 'ft') == 'NvimTree' then
            vim.cmd('wincmd p')
          end
          func()
        end
      end

      vimp.nnoremap('<leader><leader>', ensure_out_of_tree(builtin.find_files))
      vimp.nnoremap('<leader>,', ensure_out_of_tree(builtin.buffers))
      vimp.nnoremap('<leader>h', ensure_out_of_tree(builtin.help_tags))
      vimp.nnoremap('<leader>s', ensure_out_of_tree(builtin.live_grep))
      vimp.nnoremap('<leader>k', ensure_out_of_tree(builtin.keymaps))
    end,
  }
end
