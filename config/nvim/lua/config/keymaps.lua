-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local del = vim.keymap.del

-- I'm using `;` as my language leader. Unmapping the default behavior
del("n", ";")

-- Core stuff
map("n", ";w", function() vim.cmd.write() end, { desc = "Write current buffer", noremap = true, silent = true })
map("n", ";W", "<CMD>wall<CR>", { desc = "Write all buffers", noremap = true, silent = true })
map("i", "jk", "<ESC>", { desc = "Exit insert mode", noremap = true, silent = true })
map("n", "<C-c>", "<CMD>nohlsearch<CR>", { desc = "Stop highlighting search results", noremap = true, silent = true })

-- Buffer / window management
map("n", "q", require("user.smart-q").smart_q, { desc = "Close buffer (or stop macro if recording)", noremap = true, silent = true })
map("n", "Q", "<CMD>close<CR>", { desc = "Close window", noremap = true, silent = true })
map("n", "<leader>O", function()
  vim.cmd("only!")
  Snacks.bufdelete.other()
end, { desc = "Close window", noremap = true, silent = true })

-- Macro recording re-mappings
map("n", "<leader>q", "qq", { desc = "Start recording macro to q", noremap = true, silent = true })
map("n", "<leader>Q", "qqqqq", { desc = "Start recursive macro recording to q", noremap = true, silent = true })

-- Default mappings I don't want
--- Session Management
del("n", "<leader>qq")
del("n", "<leader>qd")
del("n", "<leader>qs")
del("n", "<leader>qS")
del("n", "<leader>ql")
--- Saving files
del({ "n", "i", "x", "s" }, "<C-s>")
--- Terminal
del({ "n" }, "<leader>ft")
del({ "n" }, "<leader>fT")
