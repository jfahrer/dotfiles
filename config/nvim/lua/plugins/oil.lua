return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  keys = {
    { "-", function() require("oil").open() end },
  },
  config = function()
    require("oil").setup()
  end,
}
