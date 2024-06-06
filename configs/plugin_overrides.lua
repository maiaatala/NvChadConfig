local M = {}

M.treesitter = {
  auto_install = true,
  ensure_installed = {
    "vim",
    "lua",
    "bash",
    "json",
    "json5",
    "jq",
    "yaml",
    "comment",
    -- "java",
    "dockerfile",
    "regex",
    "toml",

    -- Markdown
    "markdown",
    "markdown_inline",
    -- -- Go Lang
    "go",
    "gomod",
    "gowork",
    "gosum",

    -- Web Dev
    "javascript",
    "typescript",
    "tsx",
    "html",
    "astro",
    "css",
  },
  indent = {
    enable = true,
  },
  playground = {
    enable = true,
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  textsubjects = {
    enable = true,
    prev_selection = ",",
    keymaps = {
      ["."] = "textsubjects-smart",
      ["a."] = "textsubjects-container-outer",
      ["i."] = "textsubjects-container-inner",
    },
  },
  -- tree_setter = {
  --   enable = true,
  -- },
  rainbow = {
    enable = false,
    extended_mode = false,
    max_file_lines = 1000,
    -- query = {
    --   "rainbow-parens",
    --   html = "rainbow-tags",
    --   javascript = "rainbow-tags-react",
    --   tsx = "rainbow-tags",
    -- },
  },
}

M.blankline = {
  indentLine_enabled = 1,
  filetype_exclude = {
    "help",
    "terminal",
    "lazy",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
    "mason",
    "nvdash",
    "nvcheatsheet",
    "",
  },
  buftype_exclude = { "terminal" },
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  show_current_context = true,
  show_current_context_start = false,
}

return M
