return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = function() return require("user.theme").tokyonight_opts() end,
    config = function(_, opts)
      require("user.theme").configure(opts)
    end,
    keys = {
      {
        "<leader>ut",
        function() require("user.theme").toggle() end,
        desc = "Toggle Tokyo Night theme",
      },
      {
        "<leader>uT",
        function() require("user.theme").sync() end,
        desc = "Sync Tokyo Night theme",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
