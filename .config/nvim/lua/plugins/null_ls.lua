local ok, null_ls = pcall(require, 'null-ls')
if not ok then
  return
end

local format_group = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup {
  sources = {
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports
  },
  on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = format_group, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
              group = format_group,
              buffer = bufnr,
              callback = function()
                  -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                  vim.lsp.buf.format({ bufnr = bufnr })
              end,
          })
      end
  end,
}
