-- custom/configs/lspconfig.lua
require "plugins.configs.lspconfig"

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

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
  "htmx",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = on_attach,
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
