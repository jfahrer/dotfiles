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
        function() require("user.theme").sync_or_toggle() end,
        desc = "Toggle or sync Tokyo Night theme",
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
