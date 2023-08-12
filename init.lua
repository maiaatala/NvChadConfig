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
