local highlights = require "configs.highlights_overrides"

---@type ChadrcConfig
local M = {}
M.ui = {
  theme = "catppuccin",
  transparency = true,
  hl_add = highlights.add,
  hl_override = highlights.override,
  statusline = {
    theme = "default",
    separator_style = "arrow",
    overriden_modules = function(modules)
      -- table.remove(modules, 13) -- remove folder
      -- table.remove(modules, 11) -- remove file type
      -- table.remove(modules, 10) -- remove file encoding
      -- table.remove(modules, 9) -- remove cursor position
      -- table.remove(modules, 8) -- remove changes and additions
      -- table.remove(modules, 3) -- remove git branch info
      --
      -- table.insert(
      --   modules,
      --   8,
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

return M
