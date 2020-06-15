local reload = require('core.reload')
reload.unload_user_modules()

local log = require('core.log')
log.init()

local autocmd = require('core.autocmd')
autocmd.init()

local layer = require('core.layer')
layer.add_layer('layers.style')
layer.add_layer('layers.statusline')
layer.add_layer('layers.editor')
layer.add_layer('layers.lsp')
layer.add_layer('layers.lua')
layer.add_layer('layers.rust')
layer.finish_layer_registration()
