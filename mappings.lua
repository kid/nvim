local maps = { n = {}, v = {} }

maps.n["<leader>gg"] = { "<cmd>Neogit<cr>", desc = "Neogit" }

maps.n["<leader>y"] = { '"+y' }
maps.v["<leader>y"] = { '"+y' }
maps.n["<leader>Y"] = { '"+y$' }

maps.n["<leader>p"] = { '"+p' }
maps.v["<leader>p"] = { '"+p' }
maps.n["<leader>P"] = { '"+P' }

return maps
