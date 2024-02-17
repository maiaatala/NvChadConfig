-- local NvimTreeAttach = require "custom.configs.nvimTree_config"
-- l1cal overrides = require "custom.configs.plugin_overrides"

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
              width = 0.6,
              col = 0.4,
              height = 0.6,
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
    lazy = false,
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
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = {
      settings = {
        save_on_toggle = true,
      },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {},
    -- config = function()
    --   require("nvim-surround").setup {
    --     -- Configuration here, or leave empty to use defaults
    -- end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    config = function()
      require "custom.configs.todo_comments"
    end,
  },
  {
    "f-person/git-blame.nvim",
    cmd = "GitBlameToggle",
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require "custom.configs.trouble"
    end,
  },
  {
    "dnlhc/glance.nvim",
    cmd = "Glance",
    config = function()
      require "custom.configs.glance"
    end,
  },
}
return plugins
