local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif vim.fn.call('vsnip#available', { 1 }) == 1 then
    return t '<Plug>(vsnip-expand-or-jump)'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  elseif vim.fn.call('vsnip#jumpable', { -1 }) == 1 then
    return t '<Plug>(vsnip-jump-prev)'
  else
    return t '<S-Tab>'
  end
end

local config = function()
  local compe = require('compe')
  compe.setup {
    enabled = true,
    autocomplete = true,
    preselect = 'enable',

    source = {
      path = true,
      buffer = true,
      vsnip = true,
      nvim_lsp = true,
      nvim_lua = true,
      spell = true,
      orgmode = packer_plugins['orgmode.nvim'] ~= nil,
    },
  }

  vim.o.completeopt = 'menuone,noselect'

  vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
  vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
  vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
  vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
  vim.api.nvim_set_keymap('i', '<CR>', 'compe#confirm("<CR>")', { expr = true })

  require('snippets').use_suggested_mappings()

  -- local k = require('astronauta.keymap')

  -- k.iremap { '<Tab>', tab_complete }
  -- k.sremap { '<Tab>', tab_complete }
  -- k.iremap { '<S-Tab>', s_tab_complete }
  -- k.sremap { '<S-Tab>', s_tab_complete }
  -- k.inoremap { '<CR>', function () compe.confirm('<CR>') end, silent = true }
end

return function(use)
  use { 'hrsh7th/nvim-compe', requires = { 'hrsh7th/vim-vsnip', 'norcalli/snippets.nvim' }, config = config }
end
