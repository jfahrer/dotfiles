-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local helpers = require("user.keymap")
local map = vim.keymap.set
local del = vim.keymap.del

-- I'm using `;` as my language leader. Unmapping the default behavior
del("n", ";")

-- Change some LazyVim default mappings:
--- Change window management to <leader>v (also see plugins/which-key.lua) since <leader>w is used to write the buffer
helpers.remap({ "n", "v", "x" }, "<leader>w", "<leader>v")
--- Change session management to <leader>z as <leader>q is used for <leader>q us used for macro recording
helpers.remap({ "n", "v", "x" }, "<leader>q", "<leader>z")

-- Use CWD as the default for finding stuff
helpers.switch({ "n" }, "<leader>ff", "<leader>fF")
helpers.switch({ "n" }, "<leader>fe", "<leader>fE")
helpers.switch({ "n" }, "<leader>fr", "<leader>fR")
helpers.switch({ "n" }, "<leader>sg", "<leader>sG")
helpers.copy("n", "<leader>sg", "<leader>/")
helpers.copy("n", "<leader>ff", "<leader><leader>")

-- Default mappings I don't want
--- Saving files
del({ "n", "i", "x", "s" }, "<C-s>")
--- Terminal stuff
del({ "n" }, "<leader>ft")
del({ "n" }, "<leader>fT")

-- Core stuff
map("n", "<leader>w", "<CMD>write<CR>", { desc = "Write current buffer", noremap = true, silent = true })
map("n", "<leader>W", "<CMD>wall<CR>", { desc = "Write all buffers", noremap = true, silent = true })
map("i", "jk", "<ESC>", { desc = "Exit insert mode", noremap = true, silent = true })
map("n", "<C-c>", "<CMD>nohlsearch<CR>", { desc = "Stop highlighting search results", noremap = true, silent = true })

-- Buffer / window management
map("n", "q", require("user.smart-q").smart_q, { desc = "Close buffer (or stop macro if recording)", noremap = true, silent = true })
map("n", "Q", "<CMD>close<CR>", { desc = "Close window", noremap = true, silent = true })
map("n", "<leader>O", function()
  vim.cmd("only!")
  Snacks.bufdelete.other()
end, { desc = "Close all other windows and buffers", noremap = true, silent = true })

-- Macro recording re-mappings
map("n", "<leader>q", "q", { desc = "Start recording a macro", noremap = true, silent = true })
map("n", "<leader>Q", "qqqqq", { desc = "Start recursive macro recording to q", noremap = true, silent = true })
