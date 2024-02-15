local highlights = require "custom.configs.highlights_overrides"

---@type ChadrcConfig
local M = {}
M.ui = { theme = "monekai", transparency = true, hl_add = highlights.add }
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M
