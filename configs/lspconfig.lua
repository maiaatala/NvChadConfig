-- custom/configs/lspconfig.lua
require "plugins.configs.lspconfig"

local on_attach = require("plugins.configs.lspconfig").on_attach
local on_init = require("plugins.configs.lspconfig").on_init
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

local ok, _ = pcall(require, "ufo")
if ok then
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
end

local servers = {
  -- "tsserver",
  "eslint",
  "ocamllsp",
  "gopls",
  -- "gleam",
  "htmx",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.tsserver.setup {
  onAttach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      importModuleSpecifierPreference = "relative",
      importModuleSpecifierEnding = "minimal",
    },
  },
  on_init = on_init,
}

lspconfig.lua_ls.setup {
  onAttach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "use", "vim" },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
}

lspconfig.gleam.setup {
  cmd = { "gleam", "lsp" },
  filetypes = { "gleam" },
  -- root_dir = lspconfig.util.root_pattern("gleam.toml"),
  on_attach = on_attach,
  capabilities = capabilities,
}

-- lspconfig.ocamllsp.setup {
--   cmd = { "ocaml-lsp" },
--   filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
--   root_dir = lspconfig.util.root_pattern(
--     "*.opam",
--     "easy.json",
--     "package.json",
--     ".git",
--     "dune-project",
--     "dune-workspace"
--   ),
--   on_attach = configs.on_attach,
--   capabilities = configs.capabilities,
-- }
