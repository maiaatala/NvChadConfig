local M = {}

M.disabled = {
  n = {},
}

M.abc = {
  n = {},
  i = {},
  v = {
    ["J"] = { ":m '>+1<CR>gv=gv" },
    ["K"] = { ":m '<-2<CR>gv=gv" },
  },
}

return M
