local config = function()
  local cmp = require('cmp')
  local luasnip = require('luasnip')

  local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  local feedkey = function(key)
    local test = vim.api.nvim_replace_termcodes(key, true, true, true)
    vim.api.nvim_feedkeys(test, 'n', true)
  end

  cmp.setup {
    completion = { autocomplete = false },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    sources = {
      -- sources in order of priority
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'orgmode' },
      { name = 'buffer' },
    },
    formatting = {
      format = require('lspkind').cmp_format(),
    },
    mapping = {
      ['<C-e>'] = cmp.mapping.close(),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(
        function(fallback)
          if vim.fn.pumvisible() == 1 then
            feedkey('<C-n>')
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(
        function(fallback)
          if vim.fn.pumvisible() == 1 then
            feedkey('<C-p>')
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
    },
  }
end

return function(use)
  use {
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
    config = config,
  }
end
