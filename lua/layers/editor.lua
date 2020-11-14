local layer = {}

function layer.plugins(use)
  use "tpope/vim-commentary"
  use "tpope/vim-surround"
  use "editorconfig/editorconfig-vim"
  use "easymotion/vim-easymotion"
end

function layer.init_config()
  vim.o.shortmess = vim.o.shortmess .. "c"
  vim.o.swapfile = false
end

return layer
