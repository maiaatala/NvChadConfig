local M = {}

M.disabled = {
  n = {},
}

M.abc = {
  n = {
    ["<C-d>"] = { "<C-d>zz", "N:Keep cursor middle when moving paga down" },
    ["<C-u>"] = { "<C-u>zz", "N:Keep cursor middle when moving paga up" },
    ["<n>"] = { "nzzzv", "N:Keep cursor middle when searching" },
    ["<N>"] = { "Nzzzv", "N:Keep cursor middle when searching" },
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>|"] = { "<cmd>:vsp<CR>", "split screen vertically", opts = { nowait = true } },
    ["<leader>_"] = { "<cmd>:sp<CR>", "split screen horizontally", opts = { nowait = true } },
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
