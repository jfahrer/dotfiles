return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  keys = {
    { "<A-h>", function() require("smart-splits").resize_left() end, mode = { "n", "i" } },
    { "<A-j>", function() require("smart-splits").resize_down() end, mode = { "n", "i" } },
    { "<A-k>", function() require("smart-splits").resize_up() end, mode = { "n", "i" } },
    { "<A-l>", function() require("smart-splits").resize_right() end, mode = { "n", "i", "v" } },
    { "<C-h>", function() require("smart-splits").move_cursor_left() end },
    { "<C-j>", function() require("smart-splits").move_cursor_down() end },
    { "<C-k>", function() require("smart-splits").move_cursor_up() end },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end },
    {
      "<C-h>",
      function()
        vim.cmd("stopinsert")
        require("smart-splits").move_cursor_left()
      end,
      mode = "i",
    },
    {
      "<C-j>",
      function()
        vim.cmd("stopinsert")
        require("smart-splits").move_cursor_down()
      end,
      mode = "i",
    },
    {
      "<C-k>",
      function()
        vim.cmd("stopinsert")
        require("smart-splits").move_cursor_up()
      end,
      mode = "i",
    },
    {
      "<C-l>",
      function()
        vim.cmd("stopinsert")
        require("smart-splits").move_cursor_right()
      end,
      mode = "i",
    },
  },
  config = function()
    require("smart-splits").setup({
      ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
      ignored_buftypes = { "nofile" },
      multiplexer_integration = true,
    })
  end,
}
