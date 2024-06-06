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
    -- "dockerfile",
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

return M
