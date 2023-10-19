local M = {}

M.disabled = {
  n = {},
}

M.abc = {
  n = {
    ["<C-d>"] = { "<C-d>zz", "N:Keep cursor middle when moving paga down" },
    ["<C-u>"] = { "<C-u>zz", "N:Keep cursor middle when moving paga up" },
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>v"] = { ":vsp", "split screen vertically", opts = { nowait = true } },
    ["<leader>h"] = { ":sp", "split screen horizontally", opts = { nowait = true } },
    ["<leader>tt"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "toggle transparency",
    },
  },

  i = {},
  v = {
    ["J"] = { ":m '>+1<CR>gv=gv", "V:Move line down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "V:Move line up" },
  },
}

return M
