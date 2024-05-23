-- custom/configs/null-ls.lua

local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local sources = {
  formatting.prettierd.with {
    extra_filetypes = { "typescriptreact", "javascriptreact", "md", "json", "html" },
    -- condition = function(utils)
    --   return utils.root_has_file ".prettierrc" or utils.root_has_file "prettier.config.js"
    -- end,
  },
  -- formatting.eslint_d,
  formatting.stylua,
  formatting.ocamlformat,
  formatting.gofmt,

  null_ls.builtins.code_actions.eslint_d, -- suggest fixes from eslint

  null_ls.builtins.diagnostics.eslint_d.with {
    condition = function(utils)
      return utils.root_has_file { ".eslintrc.js", ".eslintrc.json", ".eslintrc.cjs" }
    end,
  }, --show error message on the screen
}

null_ls.setup {
  debug = true,
  sources = sources,

  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
          vim.lsp.buf.format {
            bufnr = bufnr,
            filter = function(cliente)
              return cliente.name == "null-ls" --this ensures null_ls client is called to format, not normal LspFormatting
            end,
            async = false,
          }
        end,
      })
    end
  end,
}
