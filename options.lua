require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local autocmd = vim.api.nvim_create_autocmd
local create_cmd = vim.api.nvim_create_user_command

vim.cmd "command! Slinefeed :%s/\\r//" -- fix for ^M at the end of pasted lines

-- DISABLE CTRL Z YOU WILL THANK ME LATER
vim.keymap.set("n", "<C-z>", "<NOP>")
vim.keymap.set("v", "<C-z>", "<NOP>")
vim.keymap.set("i", "<C-z>", "<NOP>")

vim.opt.clipboard = "unnamed"

vim.opt.relativenumber = true
vim.opt.relativenumber = true
vim.opt.number = true -- Shows absolute line number on cursor line (when relative number is on)
-- vim.o.foldenable = true
vim.opt.breakindent = true

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

-- Auto format on save, but it will mess with undo history
-- autocmd("BufWritePre", {
--   pattern = { "*" },
--   callback = function()
--     vim.lsp.buf.format { async = false }
--   end,
-- })

-- like the one below but for eslint fix all
autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  command = "EslintFixAll",
})

-- auto organize imports using tsserver but it conflicts with eslint project configs
-- autocmd("BufWritePre", {
--   group = vim.api.nvim_create_augroup("TS_on_save_actions", { clear = true }),
--   desc = "TS_on_save_actions",
--   pattern = { "*.ts" },
--   callback = function()
--     local params = vim.lsp.util.make_range_params()
--     params.context = { only = { "source.organizeImports.ts" } }
--     local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
--     for _, res in pairs(result or {}) do
--       for _, r in pairs(res.result or {}) do
--         if r.kind == "source.organizeImports.ts" then
--           vim.lsp.buf.code_action { apply = true, context = { only = { "source.organizeImports.ts" } } }
--           vim.cmd "write"
--         end
--       end
--     end
--   end,
-- })
