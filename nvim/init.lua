-------------------------------------------------------------------------------
-- Options
-------------------------------------------------------------------------------
vim.opt.encoding = 'utf-8'
vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.termguicolors = true
vim.opt.lazyredraw = true

vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.laststatus = 2
vim.opt.cmdheight = 0
vim.opt.numberwidth = 4
vim.opt.signcolumn = 'yes'
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

vim.opt.foldcolumn = '0'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Run make inside docker container
vim.g['makery_config'] = {
    ['~/dev/nanitor'] = {
        make = {
            makeprg = 'docker exec --workdir /nanitor nanitor_dev_env make'
        }
    }
}

-- -- Show tabs as › and trailing whitespace as •
-- vim.cmd[[
--   set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
-- ]]

-------------------------------------------------------------------------------
-- Keymap
-------------------------------------------------------------------------------
-- Tab/Shift+tab to indent/dedent
vim.g.mapleader = ' '

-- Move to end of line in insert mode
vim.keymap.set('i', '<C-l>', '<C-o>$')
-- Center screen in insert mode
vim.keymap.set('i', '<C-z>', '<C-o>zz')

vim.keymap.set('n', 'Q', '<Nop>')

-- Toggle diagnostics lines
vim.keymap.set('n', '<Leader>l', ':lua require("lsp_lines").toggle()<CR>')

-- Use find_files if not in git repository
vim.keymap.set('n', '<C-p>',
    ":lua if not pcall(require('telescope.builtin').git_files, {}) then require('telescope.builtin').find_files({}) end <CR>"
)

vim.keymap.set('n', '<S-q>',
    ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>"
)

vim.keymap.set('n', '<Leader>a', ":lua require('harpoon.mark').add_file()<CR>")
vim.keymap.set('n', '<C-m>', ":Telescope harpoon marks<CR>")

vim.keymap.set('n', '<C-b>', ':Telescope buffers<CR>')
vim.keymap.set('n', '<C-s>', ':Telescope oldfiles<CR>')

-- Enter a blank line above or below the cursor.
vim.keymap.set('n', '<Leader>k', 'O<Esc>j')
vim.keymap.set('n', '<Leader>j', 'o<Esc>k')

-- Easier moving between windows
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Quick search and replace ('.' to confirm, 'n' to skip)
vim.keymap.set('n', 'c*', "/\\<<C-R>=expand('<cword>')<CR>\\>\\C<CR>``cgn")
vim.keymap.set('n', 'c#', "?\\<<C-R>=expand('<cword>')<CR>\\>\\C<CR>``cgN")

-- Keep searches in the middle of the screen
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

vim.keymap.set('n', '<Leader>f', 'za')

vim.keymap.set('n', '<Leader>/', ':nohlsearch<CR>')

-- Quick save (write)
vim.keymap.set('n', '<Leader>w', ':w<CR>')

-- Don't lose focus when visual tabbing
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-------------------------------------------------------------------------------
-- Autocommands
-------------------------------------------------------------------------------
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanked text
local yankGroup = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
    group = yankGroup,
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '250' })
    end
})

-- Format go files on save (gofmt + goimports)
local formatAutogroup = augroup('FormatAutogroup', { clear = true })
autocmd('BufWritePost', {
    group = formatAutogroup,
    pattern = '*.go',
    command = 'FormatWrite'
})

-- Show cursorline only in active window
local cursorlineActiveWindow = augroup('CursorlineActiveWindow', { clear = true })
autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter' }, {
    group = cursorlineActiveWindow,
    command = 'setlocal cursorline'
})
autocmd({ 'WinLeave' }, {
    group = cursorlineActiveWindow,
    command = 'setlocal nocursorline'
})

-- Quickscope colors
local quickscopeColors = augroup('QuickscopeColors', { clear = true })
autocmd({ 'ColorScheme' }, {
    group = quickscopeColors,
    command = "highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline",
})
autocmd({ 'ColorScheme' }, {
    group = quickscopeColors,
    command = "highlight QuickScopeSecondary guifg='#FF00FF' gui=underline ctermfg=201 cterm=underline",
})

-------------------------------------------------------------------------------
-- Bootstrap Package Manager
-------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    print("Installing 'folke/lazy.nvim'...")
    vim.fn.system({ 'git', 'clone', 'https://github.com/folke/lazy.nvim.git', lazypath })
end
vim.opt.rtp:prepend(lazypath)

-------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------
require('lazy').setup {
    { 'wellle/targets.vim' },
    { 'tpope/vim-surround' },
    { 'tpope/vim-repeat' },
    { 'raimondi/delimitmate' },
    { 'christoomey/vim-tmux-navigator' },
    { 'miversen33/netman.nvim' },
    { 'jacoborus/tender.vim' },
    { 'unblevable/quick-scope' },
    { 'igemnace/vim-makery' },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'folke/lsp-colors.nvim' },
    { 'tpope/vim-fugitive' },
    { 'savq/melange' },
    { 'ethanholz/nvim-lastplace', config = true },
    { 'ojroques/nvim-hardline', config = true },
    { 'numToStr/Comment.nvim', config = true },
    {'kevinhwang91/nvim-bqf', ft = 'qf'},
    { 'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        config = function()
            require('ufo').setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return { 'treesitter', 'indent' }
                end
            })
        end
    },
    { 'ThePrimeagen/harpoon',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('harpoon').setup({
                global_settings = {
                    mark_branch = true
                }
            })
        end
    },
    { 'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({
                signs = {
                    add = { hl = 'GitSignsAdd', text = '+', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
                    change = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr',
                        linehl = 'GitSignsChangeLn' },
                    delete = { hl = 'GitSignsDelete', text = '-', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
                    topdelete = { hl = 'GitSignsDelete', text = '-', numhl = 'GitSignsDeleteNr',
                        linehl = 'GitSignsDeleteLn' },
                    changedelete = { hl = 'GitSignsChange', text = '~-', numhl = 'GitSignsChangeNr',
                        linehl = 'GitSignsChangeLn' },
                },

                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true })

                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true })

                    -- Actions
                    map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
                    map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
                    map('n', '<leader>hS', gs.stage_buffer)
                    map('n', '<leader>hu', gs.undo_stage_hunk)
                    map('n', '<leader>hR', gs.reset_buffer)
                    map('n', '<leader>hp', gs.preview_hunk)
                    map('n', '<leader>hb', function() gs.blame_line { full = true } end)
                    map('n', '<leader>tb', gs.toggle_current_line_blame)
                    map('n', '<leader>hd', gs.diffthis)
                    map('n', '<leader>hD', function() gs.diffthis('~') end)
                    map('n', '<leader>td', gs.toggle_deleted)

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end
            })
        end
    },
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('alpha').setup(require('alpha.themes.startify').config)
        end
    },
    { 'ibhagwan/smartyank.nvim',
        config = function()
            require('smartyank').setup({
                highlight = {
                    enabled = false,
                }
            })
        end
    },
    {
        'nvim-tree/nvim-tree.lua',
        config = true,
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
        tag = 'nightly'
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && \
               cmake --build build --config Release && cmake --install build --prefix build'
    },
    { 'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-live-grep-args.nvim',
        },
        config = function()
            local telescope = require('telescope')
            local actions = require('telescope.actions')

            local live_grep_actions = require("telescope-live-grep-args.actions")
            require('telescope').load_extension('live_grep_args')

            require("telescope").load_extension('harpoon')

            telescope.setup {
                defaults = {
                    layout_config = {
                        width = 0.90,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
                    path_display = { 'truncate' },
                    file_sorter = require('telescope.sorters').get_fuzzy_file,
                    file_ignore_patterns = { 'node_modules' },
                    mappings = {
                        i = {
                            ['<C-n>'] = actions.cycle_history_next,
                            ['<C-p>'] = actions.cycle_history_prev,

                            ['<C-j>'] = actions.move_selection_next,
                            ['<C-k>'] = actions.move_selection_previous,

                            ["<C-x>"] = actions.delete_buffer,

                            ["<C-o>"] = live_grep_actions.quote_prompt(),
                        }
                    }
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = 'smart_case',
                    },
                    live_grep_args = {
                        auto_quoting = false,
                        mappings = {
                            i = {
                                ["<C-o>"] = live_grep_actions.quote_prompt(),
                            }
                        }
                    }
                }
            }
        end
    },
    { 'mhartington/formatter.nvim',
        config = function()
            require("formatter").setup({
                filetype = {
                    go = {
                        require("formatter.filetypes.go").gofmt,
                        require("formatter.filetypes.go").goimports,
                    }
                }
            })
        end
    },
    { 'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
            { "lukas-reineke/lsp-format.nvim", config = true },
        },
        config = function()
            local lsp = require('lsp-zero')
            lsp.preset('recommended')
            lsp.nvim_workspace()
            lsp.on_attach(
            -- TODO: Learn how to disable specific formatting
            -- function(client, bufnr)
            --     require("lsp-format").on_attach(client, bufnr)
            -- end
            )

            lsp.configure('pylsp', {
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                enabled = true,
                                ignore = { 'E501' }, -- Line Too long
                            }
                        }
                    }
                }
            })

            lsp.configure('gopls', {
                settings = {
                    gopls = {
                        env = {
                            GOOS = "linux",
                            GOFLAGS = "-tags=linux,windows",
                        },
                        buildFlags = {
                            "-tags=!windows,integration"
                        },
                        directoryFilters = {
                            "-cmd/nanitor-scap/internal/scap",
                            "-cmd/nanitor-scap/internal/openscap",
                        },
                    },
                }
            })

            lsp.setup()
            vim.diagnostic.config {
                virtual_text = false,
                underline = false
            }
        end
    },
    { url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    },
    { 'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { 'python', 'lua', 'go', 'typescript' },
                highlight = { enable = true, },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            -- ["ac"] = "@conditional.outer",
                            -- ["ic"] = "@conditional.inner",
                            -- ["al"] = "@loop.outer",
                            -- ["il"] = "@loop.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]]"] = "@function.outer",
                        },
                        goto_previous_start = {
                            ["[["] = "@function.outer",
                        },
                    },
                },

            }
        end
    },
}

-- TODO: FIX!
require('netman')
require('telescope').load_extension('fzf')
vim.cmd.colorscheme('tender')
