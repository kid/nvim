local layer = {}

function layer.plugins(use)
  use "tpope/vim-commentary"
  use "tpope/vim-surround"
  use "tpope/vim-fugitive"
  use "tpope/vim-rhubarb"
  use "tpope/vim-repeat"
  use "editorconfig/editorconfig-vim"
  use "easymotion/vim-easymotion"
  use "liuchengxu/vim-which-key"
  use "svermeulen/vim-cutlass"
  -- TODO try bfredl/nvim-miniyank instead?
  use "svermeulen/vim-yoink"
  end

function layer.init_config()
  vim.o.shortmess = vim.o.shortmess .. "c"
  vim.o.swapfile = false

  vim.o.autoread = true
  vim.o.autowrite = true
  vim.o.autowriteall = true

  -- make vim-yoink work with vim-cutlass
  vim.g.yoinkIncludeDeleteOperations = 1
end

return layer
