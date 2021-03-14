local layer = {}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local compe_config = function()
  require("compe").setup {
    enabled = true,
    autocomplete = true,
    preselect = "enable",

    source = {
      path = true,
      buffer = true,
      vsnip = true,
      nvim_lsp = true,
      nvim_lua = true,
      spell = true,
    },
  }

  _G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      print("foo")
      return t "<C-n>"
    elseif vim.fn.call("vsnip#available", {1}) == 1 then
    elseif vim.fn.call("vsnip#available", {1}) == 1 then
      print("bar")
      return t "<Plug>(vsnip-expand-or-jump)"
    else
      print("baz")
      return t "<Tab>"
    end
  end

  _G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      print("FOO")
      return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
      print("BAR")
      return t "<Plug>(vsnip-jump-prev)"
    else
      print("BAZ")
      return t "<S-Tab>"
    end
  end

  vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
  vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
  vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
  vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
end

function layer.plugins(use)
  use "neovim/nvim-lspconfig"
  -- use "nvim-lua/completion-nvim"
  use "nvim-lua/lsp-status.nvim"
  use "nvim-lua/lsp_extensions.nvim"
  use {
    "hrsh7th/nvim-compe",
    requires = {
      -- "hrsh7th/vim-vsnip"
    },
  }
  use {
    "norcalli/snippets.nvim",
    config = function()
      -- require("snippets").use_suggested_mappings()
    end,
  }
  use "hrsh7th/vim-vsnip"
  -- use "hrsh7th/vim-vsnip-integ"
  use {
    "ojroques/nvim-lspfuzzy",
    requires = {
      "junegunn/fzf",
      "junegunn/fzf.vim",
    }
  }
end

function layer.init_config()
  vim.o.completeopt = "menu,menuone,noselect"

  require("lspfuzzy").setup{
    fzf_preview = {
      'right:+{2}-/2:noborder'
    },
  }

  -- require("snippets").use_suggested_mappings()
  compe_config()
  -- local lsp_status = require("lsp-status")
  -- lsp_status.register_progress()

  vim.g.completion_enable_auto_paren = 1
  vim.g.completion_enable_snippet = "vim-vsnip"
  vim.g.completion_timer_cycle = 200

  -- lsp_status.config { kind_labels = vim.g.completion_customize_lsp_label }

  -- vim.api.nvim_exec(
  --   [[
  --     function! LspStatus() abort
  --       if luaeval('#vim.lsp.buf_get_clients() > 0')
  --         return luaeval('require("lsp-status").status()')
  --       endif

  --       return ''
  --     endfunction
  --   ]],
  --   false
  -- )

  -- vim.fn["airline#parts#define_function"]("c_lsp", "LspStatus")
  -- vim.g.airline_section_y = vim.fn["airline#section#create_right"]{"c_lsp", "ffenc"}
end

function layer.register_server(server, config)
  local lsp_status = require("lsp-status")
  -- local completion = require("completion")

  config = config or {}

  config.on_attach = function(client)
    -- completion.on_attach(client)
    lsp_status.on_attach(client)
  end

  config.capabilities = vim.tbl_extend("keep", config.capabilities or {}, lsp_status.capabilities)

  config = vim.tbl_extend("keep", config, server.document_config.default_config)

  server.setup(config)
end

return layer
