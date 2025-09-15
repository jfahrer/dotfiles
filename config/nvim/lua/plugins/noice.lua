return {
  "folke/noice.nvim",
  lazy = false,
  opts = {
    presets = {
      lsp_doc_border = true,
    },
    -- This moves the search bar into a popup as well
    -- cmdline = {
    --   view = "cmdline_popup",
    --   opts = {
    --     position = {
    --       row = "50%",
    --       col = "50%",
    --     },
    --     size = {
    --       min_width = 60,
    --       width = "auto",
    --       height = "auto",
    --     },
    --     border = {
    --       style = "rounded",
    --     },
    --   },
    -- },
    views = {
      cmdline_popup = {
        position = {
          row = "50%",
          col = "50%",
        },
        size = {
          width = 80,
          height = "auto",
        },
      },
    },
  },
}

