-- vim.opt.colorcolumn = "80"
local function open_nvim_tree(data)
  -- is buffer a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if directory then
    -- change to the directory
    vim.cmd.cd(data.file)
  end

  -- open the tree
  require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
vim.keymap.set("n", "<C-z>", "<NOP>")
vim.keymap.set("v", "<C-z>", "<NOP>")
vim.keymap.set("i", "<C-z>", "<NOP>")

local opt_config = vim.opt

opt_config.relativenumber = true -- Show relative line numbers
opt_config.number = true -- Shows absolute line number on cursor line (when relative number is on)
