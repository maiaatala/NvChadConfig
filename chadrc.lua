local highlights = require "configs.highlights_overrides"

vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#bf616a" })
vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#ebcb8b" })
vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#5e81ac" })
vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#d08770" })
vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#a3be8c" })
vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#b48ead" })
vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#88c0d0" })

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
