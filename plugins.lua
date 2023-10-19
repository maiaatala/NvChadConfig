-- custom/plugins

local plugins = {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    opts = {
      ensure_installed = {
        "typescript-language-server",
        "prettierd",
        "eslint_d",
        "lua-language-server",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.null-ls"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
  },
  {
    "NvChad/nvterm",
    config = function()
      require("nvterm").setup {

        terminals = {
          type_opts = {
            float = {
              relative = "editor",
              width = 0.5,
              col = 0.5,
              height = 0.5,
              row = 0.05,
            },
            horizontal = {
              split_ratio = 0.35,
            },
            vertical = {
              split_ratio = 0.4,
            },
          },
        },
      }
    end,
  },
}
return plugins
