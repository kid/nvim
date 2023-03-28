return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    opts.mapping["<C-y>"] = cmp.mapping.confirm { select = true }
    opts.mapping["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }
    opts.mapping["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }
    opts.mapping["<c-l>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end)
    opts.mapping["<c-h>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable( -1) then
        luasnip.jump( -1)
      else
        fallback()
      end
    end)
    opts.mapping["<Tab>"] = nil
    opts.mapping["<S-Tab>"] = nil

    return opts
  end
}
