local M = {}

M.disabled = {
  n = {},
}

M.abc = {
  n = {
    ["<C-d>"] = { "<C-d>zz", "N:Keep cursor middle when moving paga down" },
    ["<C-u>"] = { "<C-u>zz", "N:Keep cursor middle when moving paga up" },
  },

  i = {},
  v = {
    ["J"] = { ":m '>+1<CR>gv=gv", "V:Move line down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "V:Move line up" },
  },
}

return M
