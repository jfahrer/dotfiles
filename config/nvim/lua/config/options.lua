-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Ruby development settings
-- Use standardrb as the default formatter and linter for Ruby
vim.g.lazyvim_ruby_lsp = "ruby_lsp"
vim.g.lazyvim_ruby_formatter = "standardrb"
vim.g.lazyvim_ruby_linter = "standardrb"
