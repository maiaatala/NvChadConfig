local M = {}

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

M.disabled = {
  n = {
    ["<leader>b"] = { "", "disable create new buffer" },
    ["<leader>h"] = { "", "disable create horizontal terminal" },
    ["<leader>v"] = { "", "disable create vertical terminal" },
    ["<leader>n"] = { "", "disable toggle line number" },
  },
}

M.abc = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>ttt"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "󱡕 toggle transparency",
    },
  },
  i = {},
  v = {},
}

M.git = {
  n = {
    ["<leader>lg"] = { "<CMD>LazyGit<CR>", "  LazyGit" },
  },
}

M.motions = {
  n = {
    ["<C-d>"] = { "<C-d>zz", "N:Keep cursor middle when moving paga down" },
    ["<C-u>"] = { "<C-u>zz", "N:Keep cursor middle when moving paga up" },
    ["n"] = { "nzz", "N:Keep cursor middle when searching" },
    ["N"] = { "Nzz", "N:Keep cursor middle when searching" },
    ["g;"] = { "g;zz", "N:Keep cursor middle when going BACK in insert positions" },
    ["g,"] = { "g,zz", "N:Keep cursor middle when going FORWARD in insert positions" },
    ["zj"] = { "zjzz", "N:Keep cursor middle when jumping NEXT fold" },
    ["zk"] = { "zkzz", "N:Keep cursor middle when jumping PREV fold 0" },
    ["[c"] = {
      function()
        require("treesitter-context").go_to_context(vim.v.count1)
        vim.cmd "normal! zz"
      end,
      "Jump to stick header context",
    },
  },
  i = {},
  v = {
    ["K"] = { ":m '<-2<CR>gv=gv", " Move line up" },
    ["J"] = { ":m '>+1<CR>gv=gv", " Move line down" },
  },
}

M.text = {
  n = {
    ["J"] = { "mzJ`z", "Join line while keeping the cursor in the same position" },
    ["<leader>d"] = { '"_d', "󰗨 delete without copying" },
    -- ["<C-c>"] = { "<ESC>", "makes ctrl c behave like esc when column editing" },
    ["<leader><F2>"] = {
      [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
      " replace current word in file",
    },
    ["<leader>p"] = { '"0p', " Special yank only paste" },
    ["<leader>pp"] = { '"+p', " Special clipboard only paste" },
    ["<leader>P"] = { '"0P', " Special yank only paste" },
    ["<leader>PP"] = { '"+P', " Special clipboard only paste" },
    ["<leader>y"] = { '"+y', "󰆏 Special clipboard only yank" },
  },
  i = {
    ["<A-d>"] = { "<C-o>diw", " Delete word AND CONTINUES" },
  },
  v = {
    ["K"] = { ":m '<-2<CR>gv=gv", " Move line up" },
    ["J"] = { ":m '>+1<CR>gv=gv", " Move line down" },
    ["<leader>d"] = { '"_d', "󰗨 delete without copying" },
    ["<leader>p"] = { '"0p', " Special yank only paste" },
    ["<leader>P"] = { '"0P', " Special yank only paste" },
  },
}

M.split = {
  n = {
    ["<C-h>"] = {
      function()
        move_or_create_win "h"
      end,
      "[h]: Move to window on the left or create a split",
    },
    ["<C-j>"] = {
      function()
        move_or_create_win "j"
      end,
      "[j]: Move to window below or create a vertical split",
    },
    ["<C-k>"] = {
      function()
        move_or_create_win "k"
      end,
      "[k]: Move to window above or create a vertical split",
    },
    ["<C-l>"] = {
      function()
        move_or_create_win "l"
      end,
      "[l]: Move to window on the right or create a split",
    },
    ["Zz"] = { "<C-w>|<C-w>_", " max zoom in a window" },
    ["Zo"] = { "<C-w>=", " zoom ou" },
  },
}

M.lspconfig = {
  n = {
    ["<leader><leader>n"] = { "<CMD> lua require('tsht').nodes() <CR>", " Select Node" },
    ["<leader><leader>a"] = {
      function()
        if isCodeActionAvailable() then
          vim.lsp.buf.code_action()
        else
          print "No code actions available"
        end
      end,
      "Go: Code Action",
    },
    ["<leader>gR"] = { "<CMD>Glance references<CR>", " References" },
    ["<leader>gD"] = { "<CMD>Glance definitions<CR>", "󰘐 definitions" },
    ["<leader>gT"] = { "<CMD>Glance type_definitions<CR>", " type def" },
    ["<leader>gI"] = { "<CMD>Glance implementations<CR>", " implementations" },
  },
}

M.harpoon = {
  n = {
    ["<leader>ha"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():add()
      end,
      "󱡁 Harpoon ADD file",
    },
    ["<leader>ht"] = { "<CMD>Telescope harpoon marks<CR>", "󱡀 Toggle quick menu" },
    ["<leader>hm"] = {
      function()
        local harpoon = require "harpoon"
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      "󱠿 Harpoon Menu",
    },
    ["<leader>1"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(1)
      end,
      " 󱪼 Navigate to file 1",
    },
    ["<leader>2"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(2)
      end,
      " 󱪽 Navigate to file 2",
    },
    ["<leader>3"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(3)
      end,
      " 󱪾 Navigate to file 3",
    },
    ["<leader>4"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(4)
      end,
      " 󱪿 Navigate to file 4",
    },
    ["<leader>hl"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():next()
      end,
      "󰒭 Navigate to next file",
    },
    ["<leader>hh"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():prev()
      end,
      "󰒮 Navigate to previous file",
    },
  },
}

M.trouble = {
  n = {
    ["<leader>tt"] = { "<CMD>TroubleToggle<CR>", "󰔫 Toggle warnings" },
  },
}

M.lists = {
  n = {
    ["<leader>cq"] = {
      function()
        local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
        local action = qf_winid > 0 and "cclose" or "copen"
        vim.cmd("botright " .. action)
      end,
      " toggle quicklist",
    },
    ["[q"] = { "<CMD>cprev<CR>", "󰮳 prev quicklist item" },
    ["]q"] = { "<CMD>cnext<CR>", "󰮱 next quicklist item" },
    ["[Q"] = { "<CMD>cfirst<CR>", "󰮳 󰮳 first quicklist item" },
    ["]Q"] = { "<CMD>clast<CR>", "󰮱 󰮱 last quicklist item" },
    ["[<space>"] = { "<CMD>call append(line('.')-1, '')<CR>", " Add new line below cursor" },
    ["]<space>"] = { "<CMD>call append(line('.'), '')<CR>", " Add new line below cursor" },
  },
}

return M
