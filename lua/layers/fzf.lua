local layer = {}

function layer.plugins(use)
  use "junegunn/fzf"
  use "junegunn/fzf.vim"
end

function layer.init_config()
  vim.g.fzf_preview_window = ''
end

return layer
