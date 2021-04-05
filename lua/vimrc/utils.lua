local M = {}

M['unload_lua_namespace'] = function(prefix)
  local prefix_with_dot = prefix .. '.'
  for key, _ in pairs(package.loaded) do
    if key == prefix or key:sub(1, #prefix_with_dot) == prefix_with_dot then
      package.loaded[key] = nil
    end
  end
end

M['reload']  = function(prefix)
  local vimp = require('vimp')
  local packer = require('packer')

  prefix = prefix or 'vimrc'

  vim.cmd('silent wa')
  vim.lsp.stop_client(vim.lsp.get_active_clients())

  vimp.unmap_all()
  M.unload_lua_namespace(prefix)

  require(prefix)
  packer.compile()

  print('Reloaded ' .. prefix)
end

return M
