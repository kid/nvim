local layer = {}

function layer.init_config()
  local autocmd = require("core.autocmd")

  vim.api.nvim_exec(
    [[
      function! ActiveLine()
        return luaeval("require('layers.statusline').activeStatusLine()")
      endfunction
    ]],
    false
  )

  autocmd.bind("WinEnter,BufEnter *", function()
    vim.wo.statusline = "%!ActiveLine()"
  end)
end

function layer.activeStatusLine()
   local lsp_status = require("lsp-status")
   return lsp_status.status()
end

return layer
