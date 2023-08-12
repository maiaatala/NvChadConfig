-- custom/configs/lspconfig.lua

local lspconfig = require "lspconfig"
local configs = require "plugins.configs.lspconfig"

-- lspconfig.tsserver.setup {
--   on_attach = function(client)
--     client.resolved_capabilities.document_formatting = false
--     configs.on_attach(client)
--   end,
--   capabilities = configs.capabilities,
-- }

local servers = {
  "tsserver",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = configs.on_attach,
    capabilities = configs.capabilities,
  }
end
