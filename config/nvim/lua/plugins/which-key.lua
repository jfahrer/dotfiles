return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>w", proxy = false },
        { "<leader>v", proxy = "<c-w>", group = "windows" },
      },
    },
  },
}
