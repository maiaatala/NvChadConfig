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
    overriden_modules = function(modules)
      table.remove(modules, 3) -- remove git branch info

      table.insert(
        modules,
        3,
        (function()
          return (
            "%#St_codeiumStatus#"
            .. " 󰘦 "
            .. vim.api.nvim_call_function("codeium#GetStatusString", {})
            .. " ~"
          )
        end)()
      )
    end,
  },
  tabufline = {
    overriden_modules = function(modules)
      table.remove(modules, 4) -- remove the buttons from upper left corner
    end,
  },
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M
