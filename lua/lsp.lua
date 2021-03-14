return function (use)
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'onsails/lspkind-nvim',
      'kosayoda/nvim-lightbulb',
    },
    config = function ()
      local lspconfig = require('lspconfig')

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      lspconfig.rust_analyzer.setup {
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            assist = {
              importMergeBehavior = 'last',
            },
            procMacro = {
              enable = true,
            },
          },
        },
      }

      lspconfig.sumneko_lua.setup {
        cmd = {'lua-language-server'},
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = {
                'vim',
              },
            },
            runtime = {
              -- version = 'LuaJIT',
              path = vim.split(package.path, ';'),
            },
            workspace = {
              library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
              }
            },
          },
        },
      }

      require('lspkind').init {}

      local opts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap('n', '[d',    '<cmd>lua vim.lsp.diagnostics.goto_prev()<CR>', opts)
      vim.api.nvim_set_keymap('n', ']d',    '<cmd>lua vim.lsp.diagnostics.goto_next()<CR>', opts)
      vim.api.nvim_set_keymap('n', 'gd',    '<cmd>lua vim.lsp.buf.declaration()<CR>',       opts)
      vim.api.nvim_set_keymap('n', 'gD',    '<cmd>lua vim.lsp.buf.definition()<CR>',        opts)
      vim.api.nvim_set_keymap('n', 'K',     '<cmd>lua vim.lsp.buf.hover()<CR>',             opts)
      vim.api.nvim_set_keymap('n', 'gi',    '<cmd>lua vim.lsp.buf.implementation()<CR>',    opts)
      -- TODO find an alternate binding, conflicts with windows movement shortcuts
      -- vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',    opts)
      vim.api.nvim_set_keymap('n', 'gtd',   '<cmd>lua vim.lsp.buf.type_definition()<CR>',   opts)
      vim.api.nvim_set_keymap('n', 'gr',    '<cmd>lua vim.lsp.buf.references()<CR>',        opts)
      vim.api.nvim_set_keymap('n', 'g0',    '<cmd>lua vim.lsp.buf.document_symbol()<CR>',   opts)
      vim.api.nvim_set_keymap('n', 'gW',    '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>',  opts)

      vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua require"telescope.builtin".lsp_code_actions()<CR>', { noremap = true })
      vim.api.nvim_set_keymap('v', '<leader>ca', '<cmd>lua require"telescope.builtin".lsp_range_code_actions()<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>',  { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>',      { noremap = true })

      vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
      vim.fn.sign_define('LightBulbSign', { text = '💡', texthl = 'LspDiagnosticsSignInformation' })
    end
  }
end
