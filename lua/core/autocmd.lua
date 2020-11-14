local signal = {}

function signal.new()
  local inst = {
    _connections = {}
  }

  function inst.emit(...)
    local results = {}

    for _, v in pairs(inst._connections) do
      local ret = v(...)
      if ret ~= nil then table.insert(results, ret) end
    end

    return results
  end

  function inst.connect(func)
    table.insert(inst._connections, func)
  end

  return inst
end

local autocmd = {}

autocmd._bound_signals = {}

-- Clears auto commands created by this module
function autocmd.init()
  vim.api.nvim_command("augroup core_autocmd")
  vim.api.nvim_command("autocmd!")
  vim.api.nvim_command("augroup END")
  autocmd._bound_signals = {}
end

function autocmd.bind(trigger, func)
  local cmd_signal = autocmd._bound_signals[trigger]
  if cmd_signal == nil then
    cmd_signal = signal.new()
    autocmd._bound_signals[trigger] = cmd_signal

    local cmd = "autocmd " .. trigger .. " lua require('core.autocmd')._bound_signals['" .. trigger .. "'].emit()"
    vim.api.nvim_command("augroup core_autocmd")
    vim.api.nvim_command(cmd)
    vim.api.nvim_command("augroup END")
  end

  cmd_signal.connect(func)
end

function autocmd.bind_vim_enter(func)
  autocmd.bind("VimEnter *", func)
end

return autocmd
