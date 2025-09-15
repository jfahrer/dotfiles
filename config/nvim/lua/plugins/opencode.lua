return {
  "NickvanDyke/opencode.nvim",
  lazy = false,
  dependencies = {
    { "folke/snacks.nvim", opts = { input = { enabled = true } } },
  },
  keys = {
    { "<leader>at", function() require("opencode").toggle() end, desc = "Toggle opencode" },
    { "<leader>aA", function() require("opencode").ask() end, desc = "Ask opencode" },
    { "<leader>aa", function() require("opencode").ask("@cursor: ") end, desc = "Ask opencode about this", mode = "n" },
    { "<leader>aa", function() require("opencode").ask("@selection: ") end, desc = "Ask opencode about selection", mode = "v" },
    { "<leader>an", function() require("opencode").command("session_new") end, desc = "New opencode session" },
    { "<leader>ay", function() require("user.opencode").copy_last_message_to_buffer() end, desc = "Copy opencode message to buffer" },
    { "<leader>aY", function() require("opencode").command("messages_copy") end, desc = "Copy last opencode response" },
    { "<S-C-u>", function() require("opencode").command("messages_half_page_up") end, desc = "Messages half page up" },
    { "<S-C-d>", function() require("opencode").command("messages_half_page_down") end, desc = "Messages half page down" },
    { "<leader>as", function() require("opencode").select() end, desc = "Select opencode prompt", mode = { "n", "v" } },
    { "<leader>ae", function() require("opencode").prompt("Explain @cursor and its context") end, desc = "Explain this code" },
  },
}
