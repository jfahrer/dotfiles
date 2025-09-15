local M = {}

-- Strop recording if currently recording, close buffer otherwise
function M.smart_q()
  local recording = vim.fn.reg_recording()
  if recording ~= "" then
    -- Stop recording
    vim.cmd("normal! q")
  else
    Snacks.bufdelete.delete()
  end
end

return M
