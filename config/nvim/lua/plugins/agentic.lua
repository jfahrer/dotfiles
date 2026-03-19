local function setup_highlights()
  local is_day = vim.o.background == "light"

  if is_day then
    vim.api.nvim_set_hl(0, "AgenticDiffDelete", { link = "DiffDelete" })
    vim.api.nvim_set_hl(0, "AgenticDiffAdd", { link = "DiffAdd" })
    vim.api.nvim_set_hl(0, "AgenticDiffDeleteWord", { bg = "#f5c6cb", fg = "#d20f39", bold = true })
    vim.api.nvim_set_hl(0, "AgenticDiffAddWord", { bg = "#c1f09d", fg = "#2e7afe", bold = true })
    vim.api.nvim_set_hl(0, "AgenticStatusPending", { bg = "#e8d0f5", fg = "#6b2a8b", bold = true })
    vim.api.nvim_set_hl(0, "AgenticStatusCompleted", { bg = "#c1f09d", fg = "#4fd71b", bold = true })
    vim.api.nvim_set_hl(0, "AgenticStatusFailed", { bg = "#f5c6cb", fg = "#d20f39", bold = true })
    vim.api.nvim_set_hl(0, "AgenticCodeBlockFence", { link = "Directory" })
    vim.api.nvim_set_hl(0, "AgenticTitle", { bg = "#2e7afe", fg = "#f5f5f5", bold = true })
  else
    vim.api.nvim_set_hl(0, "AgenticDiffDelete", { link = "DiffDelete" })
    vim.api.nvim_set_hl(0, "AgenticDiffAdd", { link = "DiffAdd" })
    vim.api.nvim_set_hl(0, "AgenticDiffDeleteWord", { bg = "#c53b53", bold = true })
    vim.api.nvim_set_hl(0, "AgenticDiffAddWord", { bg = "#2d5a3d", bold = true })
    vim.api.nvim_set_hl(0, "AgenticStatusPending", { bg = "#fca7ea", fg = "#1e2030", bold = true })
    vim.api.nvim_set_hl(0, "AgenticStatusCompleted", { bg = "#2d5a3d", fg = "#c3e88d", bold = true })
    vim.api.nvim_set_hl(0, "AgenticStatusFailed", { bg = "#c53b53", fg = "#ff757f", bold = true })
    vim.api.nvim_set_hl(0, "AgenticCodeBlockFence", { link = "Directory" })
    vim.api.nvim_set_hl(0, "AgenticTitle", { bg = "#82aaff", fg = "#1e2030", bold = true })
  end
end

return {
  "carlos-algms/agentic.nvim",
  lazy = false,

  dependencies = {
    { "hakonharnes/img-clip.nvim", opts = {} },
  },

  init = function()
    setup_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = setup_highlights,
    })
  end,

  opts = {
    -- Available by default: "claude-agent-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "auggie-acp" | "mistral-vibe-acp"
    provider = "opencode-acp", -- setting the name here is all you need to get started
    diff_preview = {
      enabled = true,
      layout = "split", -- "split" or "inline"
      center_on_navigate_hunks = true,
    },
  },

  -- these are just suggested keymaps; customize as desired
  keys = {
    {
      "<leader>ai",
      function() require("agentic").toggle() end,
      mode = { "n", "v" },
      desc = "Toggle Agentic Chat",
    },
    {
      "<C-'>",
      function() require("agentic").add_selection_or_file_to_context() end,
      mode = { "n", "v" },
      desc = "Add file or selection to Agentic to Context",
    },
    {
      "<C-,>",
      function() require("agentic").new_session() end,
      mode = { "n", "v", "i" },
      desc = "New Agentic Session",
    },
    {
      "<leader>ar", -- ai Restore
      function() require("agentic").restore_session() end,
      desc = "Agentic Restore session",
      silent = true,
      mode = { "n", "v", "i" },
    },
    {
      "<leader>ad", -- ai Diagnostics
      function() require("agentic").add_current_line_diagnostics() end,
      desc = "Add current line diagnostic to Agentic",
      mode = { "n" },
    },
    {
      "<leader>aD", -- ai all Diagnostics
      function() require("agentic").add_buffer_diagnostics() end,
      desc = "Add all buffer diagnostics to Agentic",
      mode = { "n" },
    },
  },
}
