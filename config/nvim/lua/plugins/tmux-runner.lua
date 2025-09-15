return {
  "christoomey/vim-tmux-runner",
  lazy = false,
  keys = {
    { ";a", "<cmd>VtrAttachToPane<cr>", desc = "Attach tmux runner" },
    { ";r", "<cmd>VtrFocusRunner<cr>", desc = "Focus tmux runner" },
  },
}
