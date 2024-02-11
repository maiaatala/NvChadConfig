local autocmd = vim.api.nvim_create_autocmd
local create_cmd = vim.api.nvim_create_user_command

vim.keymap.set("n", "<C-z>", "<NOP>")
vim.keymap.set("v", "<C-z>", "<NOP>")
vim.keymap.set("i", "<C-z>", "<NOP>")

local opt_config = vim.opt
vim.opt.relativenumber = true
opt_config.number = true -- Shows absolute line number on cursor line (when relative number is on)

autocmd({ "BufEnter", "BufNewFile" }, {
  callback = function()
    if vim.bo.filetype == "markdown" then
      -- override ufo method
      vim.opt_local.foldexpr = "NestedMarkdownFolds()"
    else
      -- revert to ufo method
      vim.opt_local.foldexpr = ""
    end
  end,
})

create_cmd("UFOOpen", function()
  require("ufo").openAllFolds()
end, {})
