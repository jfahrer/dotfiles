local M = {}

-- Internal helpers shared by remap & switch
local function fetch_keymaps(mode)
  -- Always use the legacy API for a full list of keymaps; more reliable for bulk scans
  return vim.api.nvim_get_keymap(mode)
end

local function resolve_leader(lhs)
  local leader = vim.g.mapleader or " "
  return lhs:gsub("<leader>", leader)
end

local function set_mapping(mode, lhs, keymap)
  local opts = {
    noremap = keymap.noremap == 1 or keymap.noremap == true,
    silent = keymap.silent == 1 or keymap.silent == true,
    expr = keymap.expr == 1 or keymap.expr == true,
    nowait = keymap.nowait == 1 or keymap.nowait == true,
    desc = keymap.desc,
  }
  if keymap.callback then
    vim.keymap.set(mode, lhs, keymap.callback, opts)
  elseif keymap.rhs and keymap.rhs ~= "" then
    vim.keymap.set(mode, lhs, keymap.rhs, opts)
  end
end

function M.remap(modes, old_prefix, new_prefix)
  old_prefix = resolve_leader(old_prefix)
  for _, mode in ipairs(modes) do
    for _, keymap in ipairs(fetch_keymaps(mode)) do
      local lhs = keymap.lhs
      if lhs and vim.startswith(lhs, old_prefix) then
        local new_lhs = new_prefix .. lhs:sub(#old_prefix + 1)
        -- delete original mapping first to avoid duplicate which-key entries
        pcall(function() vim.keymap.del(mode, lhs) end)
        -- recreate mapping at new lhs
        set_mapping(mode, new_lhs, keymap)
      end
    end
  end
end

function M.switch(modes, mapping_a, mapping_b)
  local res_a = resolve_leader(mapping_a)
  local res_b = resolve_leader(mapping_b)

  for _, mode in ipairs(modes) do
    local maps_a, maps_b = {}, {}
    for _, keymap in ipairs(fetch_keymaps(mode)) do
      local lhs = keymap.lhs
      if lhs == res_a or lhs == mapping_a then
        table.insert(maps_a, keymap)
      elseif lhs == res_b or lhs == mapping_b then
        table.insert(maps_b, keymap)
      end
    end

    if #maps_a > 0 or #maps_b > 0 then
      -- remove originals (try both forms)
      pcall(function() vim.keymap.del(mode, mapping_a) end)
      pcall(function() vim.keymap.del(mode, res_a) end)
      pcall(function() vim.keymap.del(mode, mapping_b) end)
      pcall(function() vim.keymap.del(mode, res_b) end)

      -- a -> b
      for _, km in ipairs(maps_a) do
        set_mapping(mode, mapping_b, km) -- preserve <leader> form user passed
      end
      -- b -> a
      for _, km in ipairs(maps_b) do
        set_mapping(mode, mapping_a, km)
      end
    elseif #maps_a > 0 then
      vim.notify("Couldn't find mapping b (" .. mapping_b .. ")")
    elseif #maps_b > 0 then
      vim.notify("Couldn't find mapping a (" .. mapping_a .. ")")
    else
      vim.notify("Couldn't find mappings for " .. mapping_a .. " or " .. mapping_b)
    end
  end
end

function M.copy(mode, source, destination)
  local src_resolved = resolve_leader(source)
  local maps = {}
  for _, keymap in ipairs(fetch_keymaps(mode)) do
    if keymap.lhs == src_resolved or keymap.lhs == source then
      table.insert(maps, keymap)
    end
  end
  if #maps == 0 then
    vim.notify("copy: source mapping not found: " .. source, vim.log.levels.WARN)
    return
  end
  -- delete destination if it exists (both forms)
  pcall(function() vim.keymap.del(mode, destination) end)
  pcall(function() vim.keymap.del(mode, resolve(destination)) end)
  for _, km in ipairs(maps) do
    set_mapping(mode, destination, km)
  end
end

return M
