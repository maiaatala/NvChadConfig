local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#bf616a" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#ebcb8b" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#5e81ac" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#d08770" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#a3be8c" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#b48ead" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#88c0d0" })
end)

local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

vim.g.rainbow_delimiters = { highlight = highlight }

require("ibl").setup {
  scope = {
    highlight = highlight,
  },
  indent = {
    -- highlight = highlight,
    char = "┊",
  },
}

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
