local layer = {}

local reload = require("core.reload")
local log = require("core.log")

layer.layers = {}

function layer.add_layer(name)
  table.insert(
    layer.layers,
    {
      name = name,
      module = require(name),
    }
  )
end

local function err_handler(err)
  return {
    err = err,
    traceback = debug.traceback(),
  }
end

local function call_on_layers(func_name)
  for _, v in ipairs(layer.layers) do
    local ok, err = xpcall(v.module[func_name], err_handler)
    if not ok then
      log(" ")
      log.set_highlight("WarningMsg")
      log("Error while loading layer " .. v.name .. " / " .. func_name)
      log("================================================================================")
      log.set_highlight("None")
      log(err.err)
      log.set_highlight("WarningMsg")
      log("================================================================================")
      log.set_highlight("None")
      log(err.traceback)
    end
  end
end

function layer.finish_layer_registration()
  require('plugins').startup {
    function (use)

      -- let packer manage itself
      use {'wbthomason/packer.nvim', opt = true}

      for _, v in ipairs(layer.layers) do
        if v.module.plugins then
          v.module.plugins(use)
        end
      end
    end
  }

  reload.update_package_path()
  call_on_layers("init_config")
end

return layer
