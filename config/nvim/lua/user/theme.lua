local M = {}

function M.toggle_flavour(flavours)
  if not flavours or #flavours < 2 then
    vim.notify("At least 2 colorschemes required for toggle", vim.log.levels.WARN)
    return
  end

  local current_flavour = require("catppuccin").flavour or "mocha"
  local current_index = 1

  for i, colorscheme in ipairs(flavours) do
    if colorscheme.flavour == current_flavour then
      current_index = i
      break
    end
  end

  local next_index = current_index % #flavours + 1
  local next_colorscheme = flavours[next_index]

  if next_colorscheme.background then
    vim.o.background = next_colorscheme.background
  end

  require("catppuccin").setup({ flavour = next_colorscheme.flavour })
  vim.cmd.colorscheme("catppuccin")
  vim.notify("Switched to catppuccin-" .. next_colorscheme.flavour)
end

return M
