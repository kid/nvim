local config = require("gruvbox").config
local colors = require("gruvbox.palette").get_base_colors(vim.o.background, config.contrast)

return {
  StatusLine = { fg = colors.fg1, bg = colors.bg1 }
}
