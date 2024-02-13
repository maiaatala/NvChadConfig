local autocmd = vim.api.nvim_create_autocmd
local create_cmd = vim.api.nvim_create_user_command

-- DISABLE CTRL Z YOU WILL THANK ME LATER
vim.keymap.set("n", "<C-z>", "<NOP>")
vim.keymap.set("v", "<C-z>", "<NOP>")
vim.keymap.set("i", "<C-z>", "<NOP>")

vim.opt.relativenumber = true
vim.opt.number = true -- Shows absolute line number on cursor line (when relative number is on)
vim.o.foldenable = true
vim.o.foldlevelstart = 1 -- this need to be configured globally and not just when UFO starts

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

-- vim.opt.colorcolumn = "80"
local function open_nvim_tree(data)
  -- is buffer a real file
  local real_file = vim.fn.filereadable(data.file) == 1
  -- is buffer a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if real_file then
    -- Expand the file path to resolve special characters and expressions
    local expanded_file = vim.fn.expand(data.file)
    -- Extract the directory from the expanded file path
    local fileDir = vim.fn.fnamemodify(expanded_file, ":h")
    -- Change the current working directory to the file directory
    vim.cmd("cd " .. fileDir)
    return
  end

  if directory then
    -- change to the directory
    vim.cmd.cd(data.file)
  end

  -- open the tree
  require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
