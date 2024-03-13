local function NvimTreeAttach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts "Up")
  vim.keymap.set("n", "?", api.tree.toggle_help, opts "Help")
  vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close Directory")
  vim.keymap.set("n", "q", api.tree.close, opts "Close")
  vim.keymap.set("n", "yn", api.fs.copy.filename, opts "Copy Name")
  vim.keymap.set("n", "yr", api.fs.copy.relative_path, opts "Copy Relative Path")
  vim.keymap.set("n", "yy", api.fs.copy.absolute_path, opts "Copy Absolute Path")
end

local Config = {}

Config = {
  on_attach = NvimTreeAttach,
  filters = {
    dotfiles = false,
    custom = {
      "**/node_modules",
      "**/%.git",
      "**/%.github",
    },
  },
  git = {
    enable = true,
    ignore = false,
  },
  hijack_unnamed_buffer_when_opening = true,
  hijack_cursor = true,
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    debounce_delay = 50,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  sync_root_with_cwd = true,
  renderer = {
    highlight_opened_files = "name",
    highlight_git = true,
    -- root_folder_label = ":~",
    group_empty = true,
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      show = {
        git = true,
      },
      glyphs = {
        git = {
          unstaged = "",
          -- unstaged = "",
          staged = "",
          unmerged = "",
          renamed = "➜",
          -- untracked = "",
          untracked = "",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  actions = {
    open_file = {
      quit_on_open = true,
      resize_window = false,
    },
  },
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    adaptive_size = true,
  },
}

return Config
