local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local clear_autocmd = vim.api.nvim_clear_autocmds

-- Highlight yanked text
local yankGroup = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = yankGroup,
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '250' })
  end
})

-- Use hard tabs in Go files
vim.cmd [[
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
]]

-- Forgot what this does
vim.cmd [[
    autocmd User TelescopePreviewerLoaded setlocal number
]]

-- Quickscope colors TODO: translate to lua
vim.cmd [[
    augroup QuickScopeColors
      autocmd!
      autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
      autocmd ColorScheme * highlight QuickScopeSecondary guifg='#FF00FF' gui=underline ctermfg=201 cterm=underline
    augroup END
]]

vim.cmd [[
    augroup CursorLineOnlyInActiveWindow
        autocmd!
        autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
        autocmd WinLeave * setlocal nocursorline
    augroup END
]]

-- -- Only cursorline in active window -- TODO: make work
-- local cursor_group = augroup('CursorLineFocus', { clear = false })
-- clear_autocmd({ group = cursor_group })
-- autocmd('VimEnter, WinEnter, BufWinEnter', {
--   pattern = '*', command = 'setlocal cursorline', group = cursor_group
-- })
-- autocmd('WinLeave', {
--   pattern = '*', command = 'setlocal nocursorline', group = cursor_group
-- })
