local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
  return
end

-- -- Use floating windows for diagnostics
-- vim.diagnostic.config({
--   float = {
--     source = 'always',
--     border = rounded
--   },
-- })

-- Called on buffer enter
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  local opts = { noremap=true, silent=true }

  -- Needed for completion/suggestion
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Nice stuff
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>zz', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>zz', opts)
  buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<Leader>t', '<Cmd>lua vim.lsp.buf.type_definition()<CR>zz', opts)
  buf_set_keymap('n', '<Leader>i', '<Cmd>lua vim.lsp.buf.implementation()<CR>zz', opts)
  buf_set_keymap('n', '<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

  -- Diagnostics
  buf_set_keymap('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>zz', opts)
  buf_set_keymap('n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>zz', opts)
  -- Put diagnostics in quickfix list
  buf_set_keymap('n', '<Leader>d', '<Cmd>lua vim.diagnostic.setqflist()<CR>', opts)

  -- Format
  buf_set_keymap("n", "<Leader>ff", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

  -- Highligt word under cursor
  require('illuminate').on_attach(client)
  -- Cycle through highlighted words
  buf_set_keymap('n', '<M-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<CR>zz', opts)
  buf_set_keymap('n', '<M-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<CR>zz', opts)

end

lspconfig.gopls.setup {
  cmd = {'gopls'},
  settings = {
    gopls =  {
      env = {
        GOOS="linux",
        GOFLAGS="-tags=linux,windows", -- Needed for syscalls
      },
      -- Ignore OS specific code
      -- Switch tag when working with OS specific code
      buildFlags = {
          "-tags=!windows"
      },
      -- Pulled when building - ignore
      directoryFilters = {
        "-cmd/nanitor-scap/internal/scap",
        "-cmd/nanitor-scap/internal/openscap",
      },
    },
  },
  on_attach = on_attach
}
