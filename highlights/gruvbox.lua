local config = require("gruvbox").config
local colors = require("gruvbox.palette").get_base_colors(vim.o.background, config.contrast)

return {
  FoldColumn = { bg = nil },
  -- SignColumn = { bg = nil },
  StatusLine = { fg = colors.fg1, bg = nil },
  -- StatusLine = { fg = colors.fg1, bg = colors.bg1 },
  -- GitSignsAdd = { bg = nil },
  -- GitSignsChange = { bg = nil },
  -- GitSignSDelete = { bg = nil },
  -- WinBarNC = { fg = colors.fg4, bg = nil },

  -- https://github.com/ellisonleao/gruvbox.nvim/issues/230
  SignColumn = { link = "Normal" },
  GruvboxGreenSign = { bg = "" },
  GruvboxOrangeSign = { bg = "" },
  GruvboxPurpleSign = { bg = "" },
  GruvboxYellowSign = { bg = "" },
  GruvboxRedSign = { bg = "" },
  GruvboxBlueSign = { bg = "" },
  GruvboxAquaSign = { bg = "" },
  CursorLineNr = { fg = colors.yellow, bg = nil },
  -- CursorLineFold = { bg = colors.fg1 },
  -- CursorLineSign = { bg = colors.fg1 },
}
