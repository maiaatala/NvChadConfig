require "nvchad.mappings"

---@param key 'h'|'j'|'k'|'l'
local function move_or_create_win(key)
  local fn = vim.fn
  local curr_win = fn.winnr()
  vim.cmd("wincmd " .. key) --> attempt to move

  if curr_win == fn.winnr() then --> didn't move, so create a split
    if key == "h" or key == "l" then
      vim.cmd "wincmd v"
    else
      vim.cmd "wincmd s"
    end

    vim.cmd("wincmd " .. key)
  end
end

-- Check if there is a code action available at the cursor position
local function isCodeActionAvailable()
  local current_bufnr = vim.fn.bufnr()
  local params = {
    textDocument = vim.lsp.util.make_text_document_params(),
    context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() },
  }

  local actions = vim.lsp.buf_request_sync(current_bufnr, "textDocument/codeAction", params, 1000)

  return actions and next(actions) ~= nil
end

-- Disable mappings
local nomap = vim.keymap.del

nomap("n", "<leader>n", { desc = "disable toggle line number" })
nomap("n", "<leader>v", { desc = "disable create vertical terminal" })
nomap("n", "<leader>h", { desc = "disable create horizontal terminal" })
nomap("n", "<leader>b", { desc = "disable create new buffer" })

-- add mappgins
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>ttt", function()
  require("base46").toggle_transparency()
end, { desc = "󱡕 toggle transparency" })
map({ "n", "v" }, "<leader>lg", "<CMD>LazyGit<CR>", { desc = "  LazyGit" })

-- MOTIONS
map("n", "<C-d>", "<C-d>zz", { desc = "N:Keep cursor middle when moving paga down" })
map("n", "<C-u>", "<C-u>zz", { desc = "N:Keep cursor middle when moving paga up" })
map("n", "n", "nzz", { desc = "N:Keep cursor middle when searching" })
map("n", "N", "Nzz", { desc = "N:Keep cursor middle when back-searching" })
map("n", "g;", "g;zz", { desc = "N:Keep cursor middle when going BACK in insert positions" })
map("n", "g,", "g,zz", { desc = "N:Keep cursor middle when going FORWARD in insert positions" })
map("n", "zj", "zjzz", { desc = "N:Keep cursor middle when jumping NEXT fold" })
map("n", "g;", "zkzz", { desc = "N:Keep cursor middle when jumping PREV fold" })
map("n", "[c", function()
  require("treesitter-context").go_to_context(vim.v.count1)
  vim.cmd "normal! zz"
end, { desc = "Jump to stick header context" })

map("v", "K", ":m '<-2<CR>gv=gv", { desc = " Move line up" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = " Move line down" })

-- TEXT
map("n", "J", "mzJ`z", { desc = "Join line while keeping the cursor in the same position" })
map(
  "n",
  "<leader><F2>",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = " replace current word in file" }
)
map("i", "<A-d>", "<C-o>diw", { desc = " Delete word AND CONTINUES" })
-- TEXT BUT COPYING STUFF
map({ "n", "v" }, "<leader>d", '"_d', { desc = "󰗨 delete without copying" })
map({ "n", "v" }, "<leader>p", '"0p', { desc = " Special yank only paste" })
map({ "n", "v" }, "<leader>pp", '"+p', { desc = " Special clipboard only paste" })
map({ "n", "v" }, "<leader>P", '"0P', { desc = " Special yank only paste" })
map({ "n", "v" }, "<leader>PP", '"+P', { desc = " Special clipboard only paste" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "󰆏 Special clipboard only yank" })
map({ "n", "v" }, "<leader>PP", '"+P', { desc = " Special clipboard only paste" })

-- SPLIT
map("n", "<C-h>", function()
  move_or_create_win "h"
end, { desc = "[h]: Move to window on the left or create a split" })
map("n", "<C-j>", function()
  move_or_create_win "j"
end, { desc = "[j]: Move to window below or create a vertical split" })
map("n", "<C-k>", function()
  move_or_create_win "k"
end, { desc = "[k]: Move to window above or create a vertical split" })
map("n", "<C-l>", function()
  move_or_create_win "l"
end, { desc = "[l]: Move to window on the right or create a split" })
map("n", "Zz", "<C-w>|<C-w>_", { desc = " max zoom in a window" })
map("n", "Zo", "<C-w>=", { desc = " zoom out" })

-- LSP
map("n", "<leader>gR", "<CMD>Glance references<CR>", { desc = " references" })
map("n", "<leader>gD", "<CMD>Glance definitions<CR>", { desc = "󰘐 definitions" })
map("n", "<leader>gT", "<CMD>Glance type_definitions<CR>", { desc = " type def" })
map("n", "<leader>gI", "<CMD>Glance implementations<CR>", { desc = " implementations" })

-- HARPOON
map("n", "<leader>ha", function()
  local harpoon = require "harpoon"
  harpoon:list():add()
end, { desc = "󱡁 Harpoon ADD file" })
map("n", "<leader>ht", "<CMD>Telescope harpoon marks<CR>", { desc = "󱡀 Toggle quick menu" })
map("n", "<leader>hm", function()
  local harpoon = require "harpoon"
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "󱠿 Harpoon Menu" })
map("n", "<leader>1", function()
  local harpoon = require "harpoon"
  harpoon:list():select(1)
end, { desc = "󱪼 Navigate to file 1" })
map("n", "<leader>1", function()
  local harpoon = require "harpoon"
  harpoon:list():select(2)
end, { desc = "󱪼 Navigate to file 2" })
map("n", "<leader>hl", function()
  local harpoon = require "harpoon"
  harpoon:list():next()
end, { desc = "󰒭 Navigate to next file" })
map("n", "<leader>hh", function()
  local harpoon = require "harpoon"
  harpoon:list():prev()
end, { desc = "󰒮 Navigate to previous file" })

-- TROUBLE
map("n", "<leader>tt", "<CMD>TroubleToggle<CR>", { desc = "󰔫 Toggle warnings" })

-- LISTS
map("n", "<leader>cq", function()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  local action = qf_winid > 0 and "cclose" or "copen"
  vim.cmd("botright " .. action)
end, { desc = " toggle quicklist" })
map("n", "[q", "<CMD>cprev<CR>", { desc = "󰮳 prev quicklist item" })
map("n", "]q", "<CMD>cnext<CR>", { desc = "󰮱 next quicklist item" })
map("n", "[Q", "<CMD>cfirst<CR>", { desc = "󰮳 󰮳 first quicklist item" })
map("n", "[Q", "<CMD>clast<CR>", { desc = "󰮱 󰮱 last quicklist item" })
map("n", "[Q", "<CMD>clast<CR>", { desc = "󰮱 󰮱 last quicklist item" })
map("n", "[<space>", "<CMD>call append(line('.')-1, '')<CR>", { desc = " Add new line below cursor" })
map("n", "]<space>", "<CMD>call append(line('.'), '')<CR>", { desc = " Add new line below cursor" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
