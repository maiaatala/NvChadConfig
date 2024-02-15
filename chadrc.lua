local highlights = require "custom.configs.highlights_overrides"

---@type ChadrcConfig
local M = {}
M.ui = {
  theme = "palenight",
  transparency = true,
  hl_add = highlights.add,
  statusline = {
    theme = "default",
    separator_style = "arrow",
  },
  tabufline = {
    overriden_modules = function(modules)
      table.remove(modules, 4)
    end,
  },
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M
