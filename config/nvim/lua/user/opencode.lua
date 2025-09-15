local M = {}

function M.copy_last_message_to_buffer()
  -- Save the original clipboard content
  local original_clipboard = vim.fn.getreg("+")

  -- Clear the + register
  vim.fn.setreg("+", "")

  -- Send the copy command to opencode
  require("opencode").command("messages_copy")

  -- Schedule checking for clipboard content
  local check_count = 0
  local max_checks = 10

  local function check_clipboard()
    check_count = check_count + 1
    local current_clipboard = vim.fn.getreg("+")

    if current_clipboard ~= "" then
      -- Content has been copied, create the buffer
      vim.schedule(function()
        -- Create a vertical split with a new buffer
        vim.cmd("vnew")

        local buf = vim.api.nvim_get_current_buf()

        -- Set buffer options
        vim.bo[buf].buftype = "nofile"
        vim.bo[buf].bufhidden = "wipe"
        vim.bo[buf].swapfile = false
        vim.bo[buf].filetype = "markdown"
        vim.api.nvim_buf_set_name(buf, "opencode-message")

        -- Set the content
        local lines = vim.split(current_clipboard, "\n")
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

        -- Move cursor to the top
        vim.api.nvim_win_set_cursor(0, { 1, 0 })

        -- Restore the original clipboard content
        vim.fn.setreg("+", original_clipboard)
      end)
    elseif check_count < max_checks then
      -- Schedule another check
      vim.defer_fn(check_clipboard, 40)
    else
      -- Timeout reached, restore original clipboard
      vim.fn.setreg("+", original_clipboard)
      vim.notify("Failed to copy opencode message (timeout)", vim.log.levels.WARN)
    end
  end

  -- Start checking
  vim.defer_fn(check_clipboard, 100)
end

return M
