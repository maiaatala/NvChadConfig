local highlights = require "custom.configs.highlights_overrides"

---@type ChadrcConfig
local M = {}
M.ui = {
  theme = "catppuccin",
  transparency = true,
  hl_add = highlights.add,
  hl_override = highlights.override,
  statusline = {
    theme = "vscode_colored",
    separator_style = "arrow",
    overriden_modules = function(modules)
      table.remove(modules, 13) -- remove folder
      table.remove(modules, 11) -- remove file type
      table.remove(modules, 10) -- remove file encoding
      table.remove(modules, 9) -- remove cursor position
      table.remove(modules, 3) -- remove git branch info

      -- table.insert(
      --   modules,
      --   7,
      --   (function()
      --     return (
      --       "%#St_codeiumStatus#"
      --       .. "󰘦 "
      --       .. vim.api.nvim_call_function("codeium#GetStatusString", {})
      --       .. " ~ "
      --     )
      --   end)()
      -- )
    end,
  },
  tabufline = {
    overriden_modules = function(modules)
      table.remove(modules, 4) -- remove the buttons from upper right corner
    end,
  },
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M
