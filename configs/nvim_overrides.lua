vim.keymap.set("n", "<C-z>", "<NOP>")
vim.keymap.set("v", "<C-z>", "<NOP>")
vim.keymap.set("i", "<C-z>", "<NOP>")

local opt_config = vim.opt
vim.opt.relativenumber = true
opt_config.number = true -- Shows absolute line number on cursor line (when relative number is on)
