local highlights = require "configs.highlights_overrides"

---@type ChadrcConfig
local M = {}
M.ui = {
  theme = "onenord",
  transparency = true,
  hl_add = highlights.add,
  hl_override = highlights.override,
  statusline = {
    theme = "vscode_colored",
    order = { "mode", "file", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd" },
    modules = {},
  },
}

return M
