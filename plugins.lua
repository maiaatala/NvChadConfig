-- local NvimTreeAttach = require "custom.configs.nvimTree_config"
-- local overrides = require "custom.configs.plugin_overrides"

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
        "ocamlformat",
        "stylua",
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
    "nvim-tree/nvim-tree.lua",
    dependencies = { "antosha417/nvim-lsp-file-operations" },
    config = function()
      require("nvim-tree").setup(require "custom.configs.nvimTree_config")
    end,
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
  {
    "stevearc/oil.nvim",
    lazy = false, -- we need this plugin at startup
    config = function()
      require "custom.configs.oil_config"
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      require "custom.configs.ufo"
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
  },
}
return plugins
