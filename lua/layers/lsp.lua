local layer = {}

function layer.plugins(use)
  use "neovim/nvim-lsp"
  use "nvim-lua/completion-nvim"
  use "nvim-lua/lsp-status.nvim"
  use "nvim-lua/lsp_extensions.nvim"
  use "hrsh7th/vim-vsnip"
  use "hrsh7th/vim-vsnip-integ"
end

function layer.init_config()
  vim.o.completeopt = "menuone,noinsert,noselect"

  local lsp_status = require("lsp-status")
  lsp_status.register_progress()

  vim.g.completion_enable_auto_paren = 1
  vim.g.completion_enable_snippet = 'vim-vsnip'

  lsp_status.config { kind_labels = vim.g.completion_customize_lsp_label }

    vim.api.nvim_exec(
      [[
        function! LspStatus() abort
          if luaeval('#vim.lsp.buf_get_clients() > 0')
            return luaeval('require("lsp-status").status()')
          endif

          return ''
        endfunction
      ]],
      false
    )

    -- vim.fn["airline#parts#define_function"]("c_lsp", "LspStatus")
    -- vim.g.airline_section_y = vim.fn["airline#section#create_right"]{"c_lsp", "ffenc"}
end

function layer.register_server(server, config)
  local lsp_status = require("lsp-status")
  local completion = require("completion")

  config = config or {}

  config.on_attach = function(client)
    completion.on_attach(client)
    lsp_status.on_attach(client)
  end

  config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, lsp_status.capabilities)

  config = vim.tbl_extend("keep", config, server.document_config.default_config)

  server.setup(config)
end

return layer
