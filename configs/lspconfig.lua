-- custom/configs/lspconfig.lua
require "nvchad.configs.lspconfig"

local base = require "nvchad.configs.lspconfig"
local on_attach = base.on_attach
local on_init = base.on_init
local capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
  workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = false,
    },
  },
})
-- folding support
local ok, _ = pcall(require, "ufo")
if ok then
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
end

local servers = {
  "eslint",
  "ocamllsp",
  "gopls",
  "ts_ls",
  "htmx",
}

for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    on_attach = on_attach,
    on_init,
    on_init,
    capabilities = capabilities,
  })
  vim.lsp.enable(server)
end

-- Ruff (python)

vim.lsp.config("ruff", {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_dir = function(bufnr)
    return vim.fs.root(bufnr, {
      "pyproject.toml",
      "ruff.toml",
    })
  end,
  init_options = {
    setting = {
      --settings here
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.enable "ruff"

-- typescript

vim.lsp.config("ts_ls", {
  on_attach = on_attach,
  capabilities = capabilities,

  init_options = {
    preferences = {
      importModuleSpecifierPreference = "relative",
      importModuleSpecifierEnding = "minimal",
    },
  },
})

vim.lsp.enable "ts_ls"
-- lua
vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  capabilities = capabilities,

  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = {
        globals = { "vim", "use" },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
})

vim.lsp.enable "lua_ls"
