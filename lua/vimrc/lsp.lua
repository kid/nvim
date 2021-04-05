return function(use)
  use {
    'neovim/nvim-lspconfig',
    requires = {'onsails/lspkind-nvim', 'kosayoda/nvim-lightbulb', 'svermeulen/vimpeccable'},
    rocks = {'luaformatter', server = 'https://luarocks.org/dev'},
    config = function()
      local lspconfig = require('lspconfig')
      local vimp = require('vimp')

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      lspconfig.rust_analyzer.setup {
        capabilities = capabilities,
        settings = {['rust-analyzer'] = {assist = {importMergeBehavior = 'last'}, procMacro = {enable = true}}},
      }

      lspconfig.sumneko_lua.setup {
        cmd = {'lua-language-server'},
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {globals = {'vim'}},
            runtime = {
              -- version = 'LuaJIT',
              path = vim.split(package.path, ';'),
            },
            workspace = {
              library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true},
            },
          },
        },
      }

      lspconfig.efm.setup {
        init_options = {documentFormatting = true},
        filetypes = {'lua'},
        settings = {languages = {lua = {{formatCommand = 'lua-format -i', formatStdin = true}}}},
      }

      require('lspkind').init()

      local opts = {noremap = true, silent = true}
      local builtin = require('telescope.builtin')

      vimp.nnoremap({'repeatable', 'silent'}, '[d', vim.lsp.diagnostic.goto_prev)
      vimp.nnoremap({'repeatable', 'silent'}, ']d', vim.lsp.diagnostic.goto_next)
      vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      vimp.nnoremap('gD', builtin.lsp_definitions)
      vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      -- TODO find an alternate binding, conflicts with windows movement shortcuts
      -- vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',    opts)
      vim.api.nvim_set_keymap('n', 'gtd', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      vimp.nnoremap('gr', builtin.lsp_references)
      vimp.nnoremap('g0', builtin.lsp_document_symbols)
      vimp.nnoremap('gw', builtin.lsp_workspace_symbols)

      vimp.nnoremap('<leader>ca', builtin.lsp_code_actions)
      vimp.vnoremap('<leader>ca', builtin.lsp_range_code_actions)
      vimp.nnoremap('<leader>cf', vim.lsp.buf.formatting)
      vimp.nnoremap('<leader>cr', vim.lsp.buf.rename)

      vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
      vim.fn.sign_define('LightBulbSign', {text = '💡', texthl = 'LspDiagnosticsSignInformation'})
    end,
  }
end
