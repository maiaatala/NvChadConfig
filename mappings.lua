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
  },
}

M.abc = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>tt"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "toggle transparency",
    },
  },
  i = {},
  v = {},
}

M.motions = {
  n = {
    ["<C-d>"] = { "<C-d>zz", "N:Keep cursor middle when moving paga down" },
    ["<C-u>"] = { "<C-u>zz", "N:Keep cursor middle when moving paga up" },
    ["<n>"] = { "nzzzv", "N:Keep cursor middle when searching" },
    ["<N>"] = { "Nzzzv", "N:Keep cursor middle when searching" },
  },
  i = {},
  v = {
    ["J"] = { ":m '>+1<CR>gv=gv", "V:Move line down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "V:Move line up" },
  },
}

M.text = {
  n = {
    ["J"] = { "mzJ`z", "Join line while keeping the cursor in the same position" },
    ["dd"] = {
      function()
        if vim.api.nvim_get_current_line():match "^%s*$" then
          return '"_dd'
        else
          return "dd"
        end
      end,
      "Smart dd",
    },
    ["<leader>d"] = { '"_d', "delete without copying" },
    ["<C-c>"] = { "<ESC>", "makes ctrl c behave like esc when column editing" },
    ["<leader><F2>"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "replace current word in file" },
  },
  i = {
    ["<A-d>"] = { "<ESC>diwi", " Delete word AND CONTINUES" },
  },
  v = {
    ["K"] = { ":m '<-2<CR>gv=gv", "V:Move line up" },
    ["J"] = { ":m '>+1<CR>gv=gv", "V:Move line down" },
    ["<leader>d"] = { '"_d', "delete without copying" },
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
  },
}

M.lspconfig = {
  n = {
    ["<leader><leader>n"] = { "<CMD> lua require('tsht').nodes() <CR>", " Select Node" },
    ["<F12>"] = { "<CMD>Glance references<CR>", "󰘐 References" },
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
  },
}
return M
