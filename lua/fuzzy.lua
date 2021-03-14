return function (use)
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function ()
      vim.api.nvim_set_keymap('n', '<leader><leader>', '<cmd>Telescope find_files<cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>h', '<cmd>Telescope help_tags<cr>', { noremap = true })
    end
  }
end
