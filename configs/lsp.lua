local capabilities = vim.lsp.protocol.make_client_capabilities()

local servers = {
  "gopls",
  "eslint",
  "ts_ls",
  "lua_ls",
  "ocamllsp",
  "htmx",
}

for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

-- pyright
vim.lsp.config("basedpyright", {
  settings = {
    python = {
      venvPath = ".",
      venv = ".venv",
    },
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

vim.lsp.enable("basedpyright")

-- Ruff LSP
vim.lsp.config("ruff", {
  cmd = { "ruff", "server" },
  filetypes = { "python" },

  -- root_dir = function(bufnr)
  --   return vim.fs.root(bufnr, {
  --     "pyproject.toml",
  --     "ruff.toml",
  --     ".git",
  --   })
  -- end,

  capabilities = capabilities,
})

vim.lsp.enable "ruff"
