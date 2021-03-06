-- require('plugins')

local reload = require('core.reload')
reload.unload_user_modules()

local log = require('core.log')
log.init()

local autocmd = require('core.autocmd')
autocmd.init()

local layer = require('core.layer')
layer.add_layer('layers.style')
-- layer.add_layer('layers.statusline')
layer.add_layer('layers.editor')
layer.add_layer('layers.startify')
layer.add_layer('layers.tabline')
layer.add_layer('layers.fzf')
layer.add_layer('layers.tree')
layer.add_layer('layers.treesitter')
layer.add_layer('layers.lsp')
layer.add_layer('layers.lua')
layer.add_layer('layers.rust')
layer.add_layer('layers.go')
layer.add_layer('layers.python')
layer.add_layer('layers.ansible')
-- layer.add_layer('layers.yaml')
layer.add_layer('layers.javascript')
layer.add_layer('layers.jsonnet')
layer.add_layer('layers.terraform')
layer.add_layer('layers.helm')
layer.finish_layer_registration()
