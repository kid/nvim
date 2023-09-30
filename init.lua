return {
  -- colorscheme = "gruvbox",
  colorscheme = "gruvbox-baby",
  options = {
    opt = {
      clipboard = "",
    },
  },
  lsp = {
    servers = {
      "lua_ls",
      "rnix",
      "nil_ls",
    },
    formatting = {
      disabled = {
        "tsserver",
      },
    },
  },
}
