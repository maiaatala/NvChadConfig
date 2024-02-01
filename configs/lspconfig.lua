-- custom/configs/lspconfig.lua
local configs = require "plugins.configs.lspconfig"
local lspconfig = require "lspconfig"

-- lspconfig.tsserver.setup {
--   on_attach = function(client)
--     client.resolved_capabilities.document_formatting = false
--     configs.on_attach(client)
--   end,
--   capabilities = configs.capabilities,
-- }

local servers = {
  "tsserver",
  "ocamllsp",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = configs.on_attach,
    capabilities = configs.capabilities,
  }
end
--
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
