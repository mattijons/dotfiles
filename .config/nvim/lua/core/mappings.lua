local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Set leader to space
vim.g.mapleader = ' '

----------------------------------------------
-- SEARCH
----------------------------------------------
-- Turn off search highlighting
map('n', '<Leader>/', ':nohlsearch<CR>')

-- Keep searches in the middle of the screen
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')

-- Quick search and replace ('.' to confirm, 'n' to skip)
map('n', 'c*', "/\\<<C-R>=expand('<cword>')<CR>\\>\\C<CR>``cgn") -- \\ (escape \)
map('n', 'c#', "?\\<<C-R>=expand('<cword>')<CR>\\>\\C<CR>``cgN")

-- Telescope grep string
map('n', '<Leader>*', ':Telescope grep_string<CR>') -- TODO: make better
----------------------------------------------

----------------------------------------------
-- WINDOWS/BUFFERS
----------------------------------------------
-- Easier moving between windows
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Resizing windows
map('n', '<M-h>', ':vertical resize -2<CR>')
map('n', '<M-l>', ':vertical resize +2<CR>')

-- Tab navigation
-- map('n', '<TAB>', ':tabnext<CR>') -- Meses with Ctrl-i?
map('n', '<S-TAB>', ':tabnext<CR>')

-- Open quickfix window
map('n', '<Leader>q', '<Plug>(qf_qf_toggle)zt')
map('n', ']q', '<Plug>(qf_qf_next)zz')
map('n', '[q', '<Plug>(qf_qf_prev)zz')

map('n', '<F4>', ':NvimTreeToggle<CR>')
----------------------------------------------

----------------------------------------------
-- TELESCOPE
----------------------------------------------
-- Fall back to find_files if not in git directory
map('n', '<C-p>', "<CMD>lua require('plugins/telescope').project_files()<CR>")

map('n', '<C-b>', ':Telescope buffers<CR>')
map('n', '<C-s>', ':Telescope oldfiles<CR>')

map('n', 'Q', '<Nop>')
map('n', '<S-q>', ':Telescope live_grep<CR>')
----------------------------------------------

-- Don't lose focus when visual tabbing
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Move text up and down
map('n', '<M-j>', '<Esc>:m .+1<CR>')
map('n', '<M-k>', '<Esc>:m .-2<CR>')

-- j and k move visually
map('n', 'k', 'gk')
map('n', 'j', 'gj')

-- Enter a blank line above or below the cursor.
map('n', '<Leader>k', 'O<Esc>j')
map('n', '<Leader>j', 'o<Esc>k')

-- Move to end of line in insert mode
map('i', '<C-l>', '<C-o>$')

-- Center screen in insert mode
map('i', '<C-z>', '<C-o>zz')

-- Quick save (write)
map('n', '<Leader>w', ':w<CR>')

