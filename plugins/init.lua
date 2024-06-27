local overrides = require "configs.plugin_overrides"

return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
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
        "htmx-lsp",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.null-ls"
      require "configs.lspconfig"
    end,
    event = "BufReadPre",
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "configs.cmp_overrides"
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "BufReadPre",
    opts = {
      enable_close_on_slash = false,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = {
      -- "filNaj/tree-setter",
      "echasnovski/mini.ai",
      "piersolenski/telescope-import.nvim",
      "RRethy/nvim-treesitter-textsubjects",
      "kevinhwang91/promise-async",
      {
        "kevinhwang91/nvim-ufo",
        lazy = false,
        config = function()
          require "configs.ufo"
        end,
      },
      {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
          require "configs.treesitter_context"
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
      require("nvim-tree").setup(require "configs.nvimTree_config")
    end,
  },
  {
    "zbirenbaum/nvterm",
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
      require "configs.oil_config"
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
      require "configs.todo_comments"
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
      require "configs.trouble"
    end,
  },
  {
    "dnlhc/glance.nvim",
    cmd = "Glance",
    config = function()
      require "configs.glance"
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
          -- tsx = "rainbow-parens",
          typescript = "rainbow-parens",
          javascript = "rainbow-delimiters-react",
        },
        highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
        },
      }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require "configs.indent_blankline"
    end,
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
    -- config = function()
    --   require("treesj").setup {--[[ your config ]]
    --   }
    -- end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup {
        "*",
        css = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = true, -- "Name" codes like Blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          mode = "background", -- Set the display mode.
        },
      }
    end,
  },
}
