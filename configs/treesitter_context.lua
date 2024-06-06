require("treesitter-context").setup {
  enable = true,
  max_lines = 5,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 1, -- this is because react const headers are actually multiline
  trim_scope = "outer",
  mode = "cursor",
  separator = "=",
  zindex = 20,
  -- patterns = {
  --   default = {
  --     'class',
  --     'function',
  --     'method',
  --     'for',
  --     'while',
  --     'if',
  --     'switch',
  --     'case',
  --   },
  -- },
}
