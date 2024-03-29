return function(use)
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'onsails/lspkind-nvim',
      'kosayoda/nvim-lightbulb',
      'folke/lsp-colors.nvim',
      'folke/trouble.nvim',
      'simrat39/rust-tools.nvim',
      'ray-x/lsp_signature.nvim',
    },
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      require('rust-tools').setup {
        server = {
          capabilities = capabilities,
          settings = { ['rust-analyzer'] = { assist = { importMergeBehavior = 'last' }, procMacro = { enable = true } } },
        },
      }

      lspconfig.sumneko_lua.setup {
        cmd = { 'lua-language-server' },
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
            runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
            workspace = {
              library = { [vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true },
            },
          },
        },
      }

      lspconfig.rnix.setup {
        capabilities = capabilities,
      }

      lspconfig.gopls.setup {
        capabilities = capabilities,
      }

      lspconfig.ansiblels.setup {
        capabilities = capabilities,
      }

      lspconfig.hls.setup {
        capabilities = capabilities,
        settings = {
          haskell = {
            formattingProvider = 'fourmolu',
          }
        }
      }

      lspconfig.tsserver.setup {
        capabilities = capabilities,
        on_attach = function(client)
          if client.config.flags then client.config.flags.allow_incremental_sync = true end
          client.resolved_capabilities.document_formatting = false
        end,
      }

      local eslint = {
        lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
        lintStdin = true,
        lintFormat = { '%f:%l:%c: %m' },
        lintIgnoreExitCode = true,
        formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
        formatStdin = true,
      }

      local shellcheck = {
        lintCommand = 'shellcheck -f gcc -x',
        lintSource = 'shellcheck',
        lintFormats = { '%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m' },
      }

      local shfmt = { formatCommand = 'shfmt -s -ci -bn', formatStdin = true }

      lspconfig.efm.setup {
        init_options = { documentFormatting = true },
        filetypes = {
          -- 'lua',
          'rego',
          'javascript',
          'javascriptreact',
          'javascript.jsx',
          'typescript',
          'typescriptreact',
          'typescript.jsx',
          'sh',
        },
        settings = {
          languages = {
            lua = { { formatCommand = 'lua-format -i', formatStdin = true } },
            rego = { { formatCommand = 'opa fmt', formatStdin = true } },
            javascript = { eslint },
            javascriptreact = { eslint },
            ['javascript.jsx'] = { eslint },
            typescript = { eslint },
            typescriptreact = { eslint },
            ['typescript.tsx'] = { eslint },
            sh = { shellcheck, shfmt },
          },
        },
      }

      -- lspconfig.yamlls.setup { settings = { ['yaml.schemas'] = { kubernetes = '/*.yaml' } } }

      require('lspkind').init()
      require('lsp-colors').setup()
      require('trouble').setup {
        indent_lines = true,
        use_diagnostic_signs = true,
      }

      local builtin = require('telescope.builtin')
      local wk = require('which-key')

      wk.register(
        {
          [']d'] = { vim.diagnostic.goto_next, 'Next diagnostic' },
          ['[d'] = { vim.diagnostic.goto_prev, 'Previous diagnostic' },
          K = { vim.lsp.buf.hover, 'Lsp Hover' },
          gw = { builtin.lsp_dynamic_workspace_symbols, 'Workspace symbols' },
          g0 = { builtin.lsp_document_symbols, 'Document symbols' },
          gr = { builtin.lsp_references, 'References' },
          gD = { builtin.lsp_definitions, 'Go to definition(s)' },
          gi = { builtin.lsp_implementations, 'Go to implementation' },
          gd = { vim.lsp.buf.declaration, 'Go to declaration' },
          gtd = { vim.lsp.type_definition, 'Go to type definition' },
          ['<leader>c'] = {
            name = '+code',
            a = { builtin.lsp_code_actions, 'Actions' },
            f = { vim.lsp.buf.formatting, 'Format' },
            r = { vim.lsp.buf.rename, 'Rename' },
          },
        }, { noremap = true, silent = true })

      wk.register({ ['<leader>ca'] = { builtin.lsp_range_code_actions, 'Actions' } }, { noremap = true, mode = 'v' })

      -- TODO find an alternate binding, conflicts with windows movement shortcuts
      -- vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',    opts)
      -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
      vim.fn.sign_define('LightBulbSign', { text = '💡', texthl = 'LspDiagnosticsSignInformation' })

      local lsp_signature = require('lsp_signature')
      lsp_signature.setup {
        floating_window_above_cur_line = true,
      }
    end,
  }
end
