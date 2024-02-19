-- local NvimTreeAttach = require "custom.configs.nvimTree_config"
local overrides = require "custom.configs.plugin_overrides"

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
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
      vim.keymap.set("i", "<c-Right>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-Left>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-Up>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-Down>", function()
        return vim.fn["codeium#Complete"]()
      end, { expr = true, silent = true })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = {
      {
        "windwp/nvim-ts-autotag",
        opts = { enable_close_on_slash = false },
      },
      -- "filNaj/tree-setter",
      "echasnovski/mini.ai",
      "piersolenski/telescope-import.nvim",
      "RRethy/nvim-treesitter-textsubjects",
      "kevinhwang91/promise-async",
      {
        "kevinhwang91/nvim-ufo",
        lazy = false,
        config = function()
          require "custom.configs.ufo"
        end,
      },
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        init = function()
          vim.g.skip_ts_context_commentstring_module = true
        end,
        config = function()
          require("ts_context_commentstring").setup {
            enable_autocmd = false,
          }
        end,
      },
    },
    opts = overrides.treesitter,
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
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      settings = {
        save_on_toggle = true,
        save_on_change = true,
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
  {
    "hiphish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = function()
      local rainbow_delimiters = require "rainbow-delimiters"

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },
}
return plugins
