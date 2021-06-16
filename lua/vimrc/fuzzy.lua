

return function(use)
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim', 'folke/which-key.nvim' },
    config = function()
      local wk = require('which-key')
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

      wk.register({
        ["<leader>"] = {
          ["<leader>"] = { ensure_out_of_tree(builtin.find_files), 'Find files' },
          [','] = { ensure_out_of_tree(builtin.buffers), 'Buffers' },
          h = { ensure_out_of_tree(builtin.help_tags), 'Help tags' },
          s = { ensure_out_of_tree(builtin.live_grep), 'Search' },
          k = { ensure_out_of_tree(builtin.keymaps), 'Keymaps' },
        }
      })
    end,
  }
end
