return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)

      -- Patch bufferline integration for LazyVim compatibility
      local ok, bufferline_integration = pcall(require, "catppuccin.groups.integrations.bufferline")
      if ok and not bufferline_integration.get and bufferline_integration.get_theme then
        bufferline_integration.get = function()
          return bufferline_integration.get_theme()
        end
      end
    end,
    keys = {
      {
        "<leader>tt",
        function()
          require("user.theme").toggle_flavour({
            { flavour = "mocha", background = "dark" },
            { flavour = "latte", background = "light" },
          })
        end,
        desc = "Toggle Catppuccin theme",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
