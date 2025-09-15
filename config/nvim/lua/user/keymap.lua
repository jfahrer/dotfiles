local M = {}

function M.remap(modes, old_prefix, new_prefix)
  for _, mode in ipairs(modes) do
    local keymaps = (vim.keymap and vim.keymap.get and vim.keymap.get(mode)) or vim.api.nvim_get_keymap(mode)

    for _, keymap in ipairs(keymaps) do
      local lhs = keymap.lhs
      if lhs and vim.startswith(lhs, old_prefix) then
        local new_lhs = new_prefix .. lhs:sub(#old_prefix + 1)
        local rhs = keymap.rhs
        local callback = keymap.callback

        local opts = {
          noremap = keymap.noremap == 1 or keymap.noremap == true,
          silent = keymap.silent == 1 or keymap.silent == true,
          expr = keymap.expr == 1 or keymap.expr == true,
          nowait = keymap.nowait == 1 or keymap.nowait == true,
          desc = keymap.desc,
        }

        -- delete original mapping first to avoid duplicate which-key entries
        pcall(function() vim.keymap.del(mode, lhs) end)

        -- recreate mapping with either callback or rhs (skip empty rhs)
        if callback then
          vim.keymap.set(mode, new_lhs, callback, opts)
        elseif rhs and rhs ~= "" then
          vim.keymap.set(mode, new_lhs, rhs, opts)
        end
      end
    end
  end
end

return M
