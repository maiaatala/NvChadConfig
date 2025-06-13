local none_ls = require "null-ls"
local formatting = none_ls.builtins.formatting
-- local diagnostics = none_ls.builtins.diagnostics
-- local code_actions = none_ls.builtins.code_actions

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

none_ls.setup {
  sources = {
    formatting.prettierd.with {
      extra_filetypes = { "typescriptreact", "javascriptreact", "md", "json", "html" },
    },
    formatting.stylua,
    -- formatting.ocamlformat,
    formatting.gofmt,
    formatting.black,
    -- diagnostics.eslint_d.with({
    --   condition = function(utils)
    --     return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json", ".eslintrc.cjs" })
    --   end,
    -- }),

    -- code_actions.eslint_d,
  },

  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format {
            bufnr = bufnr,
            filter = function(cl)
              return cl.name == "none-ls"
            end,
            async = false,
          }
        end,
      })
    end
  end,
}
