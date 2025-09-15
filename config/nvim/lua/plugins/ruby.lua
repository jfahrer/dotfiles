return {
  "stevearc/conform.nvim",
  lazy = false,
  opts = {
    formatters_by_ft = {
      ruby = { "standardrb", lsp_format = "prefer" },
    },
  },
}
