return {
  "vim-test/vim-test",
  lazy = false,
  dependencies = {
    "christoomey/vim-tmux-runner",
  },
  config = function() vim.g["test#strategy"] = "vtr" end,
  keys = {
    { ";;", "<cmd>TestLast<cr>", desc = "Run last test" },
    { ";s", "<cmd>TestSuite<cr>", desc = "Run test suite" },
    { ";f", "<cmd>TestFile<cr>", desc = "Run test file" },
    { ";d", "<cmd>TestNearest<cr>", desc = "Run nearest test" },
  },
}

