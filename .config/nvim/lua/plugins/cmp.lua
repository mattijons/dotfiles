local ok, cmp = pcall(require, 'cmp')
if not ok then
  return
end

cmp.setup {
  snippet = {
     -- REQUIRED - you must specify a snippet engine
     expand = function(args)
       -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
       -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
       -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
       -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
     end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({select = true}), -- TODO: find better binding
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'buffer', keyword_length = 5 },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  },
}
