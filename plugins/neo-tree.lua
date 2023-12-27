
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        -- visible = true,
        -- never_show = {
        --   ".direnv",
        --   ".git",
        -- },
        hide_gitignored = true,
      },
    },
    -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/844
    renderers = {
      message = {
        { "indent", with_markers = true },
        { "name", highlight = "NeoTreeMessage" },
      },
    },
  },
}
