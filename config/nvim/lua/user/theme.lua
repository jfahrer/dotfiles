local M = {}

local function mode_to_background(mode)
  if mode == "light" then
    return "light"
  end

  return "dark"
end

local function mode_to_variant(mode)
  if mode == "light" then
    return "day"
  end

  return "night"
end

local function theme_command()
  return vim.fn.expand("~/bin/theme")
end

local function run_theme_command(...)
  local command = theme_command()
  if vim.fn.executable(command) == 0 then
    return nil
  end

  local result = vim.system(vim.list_extend({ command }, { ... }), { text = true }):wait()
  if result.code ~= 0 then
    return nil
  end

  return vim.trim(result.stdout)
end

function M.system_mode()
  local mode = run_theme_command("current")
  if mode == "light" or mode == "dark" then
    return mode
  end

  return nil
end

function M.editor_mode()
  return vim.o.background == "light" and "light" or "dark"
end

function M.current_mode()
  local mode = M.system_mode()
  if mode then
    return mode
  end

  return M.editor_mode()
end

function M.tokyonight_opts()
  local mode = M.current_mode()
  return {
    style = mode_to_variant(mode),
    light_style = "day",
  }
end

function M.configure(opts)
  M.opts = vim.tbl_deep_extend("force", {}, opts or {})
  vim.o.background = mode_to_background(M.current_mode())
  require("tokyonight").setup(M.opts)
end

function M.apply_mode(mode, notify)
  if mode ~= "light" and mode ~= "dark" then
    return
  end

  vim.o.background = mode_to_background(mode)
  require("tokyonight").setup(vim.tbl_deep_extend("force", {}, M.opts or M.tokyonight_opts(), {
    style = mode_to_variant(mode),
  }))
  vim.cmd.colorscheme("tokyonight")

  if notify ~= false then
    vim.notify("Theme: tokyonight-" .. mode_to_variant(mode))
  end
end

function M.sync()
  M.apply_mode(M.current_mode(), false)
end

function M.toggle()
  local mode = run_theme_command("toggle")
  if mode ~= "light" and mode ~= "dark" then
    vim.notify("Unable to toggle theme", vim.log.levels.ERROR)
    return
  end

  M.apply_mode(mode)
end

function M.sync_or_toggle()
  local system_mode = M.system_mode()
  if not system_mode then
    vim.notify("Unable to determine system theme", vim.log.levels.ERROR)
    return
  end

  if M.editor_mode() == system_mode then
    M.toggle()
    return
  end

  M.apply_mode(system_mode, false)
end

return M
