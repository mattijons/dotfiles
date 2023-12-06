-------------------------------------------------------------------------------
-- Options
-------------------------------------------------------------------------------
vim.opt.hidden = true

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

vim.opt.cmdheight = 1
vim.opt.numberwidth = 4
vim.opt.signcolumn = 'yes'
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

vim.opt.laststatus = 3
-- Filename relative to cwd
vim.opt.winbar = "%{%v:lua.vim.fn.expand('%:~:.')%}"

vim.opt.foldcolumn = '0'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.opt.signcolumn = "auto:2"

vim.opt.list = true
vim.opt.listchars = {
    tab = '› ',
    trail = '•',
    extends = '#',
    nbsp = '.',
}

-- Run make inside docker container
vim.g['makery_config'] = {
    ['~/dev/nanitor'] = {
        make = {
            makeprg = 'docker exec --workdir /nanitor nanitor_dev_env make'
        }
    },
    ['~/dev/nancust'] = {
        make = {
            makeprg = 'docker exec --workdir /nancust nanitor_dev_env make'
        }
    }
}

-------------------------------------------------------------------------------
-- Keymaps
-------------------------------------------------------------------------------
local silent = { silent = true }

vim.g.mapleader = ' '

-- Move to end of line in insert mode
vim.keymap.set('i', '<C-l>', '<C-o>$')
-- Center screen in insert mode
vim.keymap.set('i', '<C-z>', '<C-o>zz')

-- -- Resize windows
vim.keymap.set('n', '<A-h>', ":lua require('smart-splits').resize_left()<CR>")
vim.keymap.set('n', '<A-l>', ":lua require('smart-splits').resize_right()<CR>")
vim.keymap.set('n', '<A-k>', ":lua require('smart-splits').resize_up()<CR>")
vim.keymap.set('n', '<A-j>', ":lua require('smart-splits').resize_down()<CR>")
--
-- Move up and down visually
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

vim.keymap.set('n', 'Q', '<Nop>')

-- Toggle nvim-tree
vim.keymap.set('n', '<F1>', '<Nop>')
vim.keymap.set('n', '<F1>', ':NvimTreeToggle<CR>')

-- Toggle symbol outline
vim.keymap.set('n', '<F3>', ':SymbolsOutline<CR>')

-- Use find_files if not in git repository
vim.keymap.set('n', '<C-p>',
    ":lua if not pcall(require('telescope.builtin').git_files, {}) then require('telescope.builtin').find_files({}) end <CR>"
)

-- Live grep (using ripgrep)
vim.keymap.set('n', '<S-q>',
    ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>"
)

-- LSP dynamic workspace symbols
vim.keymap.set('n', '<Leader>s', ':Telescope lsp_dynamic_workspace_symbols<CR>')

-- Harpoon
vim.keymap.set('n', '<Leader>a', ":lua require('harpoon.mark').add_file()<CR>", silent)
vim.keymap.set('n', '<C-m>', ":Telescope harpoon marks<CR>", silent)

-- Buffers and Oldfiles
vim.keymap.set('n', '<C-b>', ':Telescope buffers<CR>')
vim.keymap.set('n', '<C-s>', ':Telescope oldfiles<CR>')

-- Enter a blank line above or below the cursor.
vim.keymap.set('n', '<Leader>O', 'O<Esc>j')
vim.keymap.set('n', '<Leader>o', 'o<Esc>k')

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

-- Leap
vim.keymap.set('n', '<Leader>f', function ()
  local current_window = vim.fn.win_getid()
  require('leap').leap({ target_windows = { current_window } })
end)

-- Turn off search highlights
vim.keymap.set('n', '<Leader>/', ':nohlsearch<CR>')

-- Quick save (write)
vim.keymap.set('n', '<Leader>w', ':w<CR>')

-- Mmake
vim.keymap.set('n', '<Leader>m', ':Mmake<CR>')

-- Don't lose focus when visual tabbing
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Tab navigation
vim.keymap.set('n', ']t', ':tabnext<CR>', silent)
vim.keymap.set('n', '[t', ':tabprevious<CR>', silent)

-- Harpoon buffer navigation
vim.keymap.set('n', ']b', ':lua require("harpoon.ui").nav_next()<CR>', silent)
vim.keymap.set('n', '[b', ':lua require("harpoon.ui").nav_prev()<CR>', silent)

-- Quickfix list navigation
vim.keymap.set('n', ']q', "<Plug>(qf_qf_next)zz<CR>", silent)
vim.keymap.set('n', '[q', "<Plug>(qf_qf_previous)zz<CR>", silent)

-- Jump between last file
vim.keymap.set('n', '<Leader>e', ":e #<CR>", silent)

-- Quickfix list toggle
vim.keymap.set('n', '<Leader>q', "<Plug>(qf_qf_toggle)<CR>", silent)


-- Git status (fugitive)
local function toggleFugitiveGit()
  if vim.fn.buflisted(vim.fn.bufname('fugitive:///*/.git//$')) ~= 0 then
    vim.cmd[[ execute ":bdelete" bufname('fugitive:///*/.git//$') ]]
  else
    vim.cmd[[
        Git
        wincmd V  " Open Git window in vertical split
        setlocal winfixwidth
        horizontal resize 20
        setlocal winfixwidth
    ]]
  end
end
vim.keymap.set('n', '<Leader>gs', toggleFugitiveGit, silent)

-------------------------------------------------------------------------------
-- User commands
-------------------------------------------------------------------------------

-- Diffs current local branch against origin/development
vim.api.nvim_create_user_command('Diffdevelopment',
    'DiffviewOpen origin/development', {}
)

-------------------------------------------------------------------------------
-- Autocommands
-------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function(data)
        local is_directory = vim.fn.isdirectory(data.file) == 1
        if not is_directory then
            return
        end
        vim.cmd.cd(data.file)
        require("nvim-tree.api").tree.open()
    end
})

vim.api.nvim_create_autocmd("VimEnter", {
    command = 'NoNeckPain'
})

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '250' })
    end
})

-- Format files on save
local format_augroup = vim.api.nvim_create_augroup('FormatAutogroup', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    group = format_augroup,
    pattern = {'*.go', '*.ts', '*.rs'},
    command = 'FormatWrite'
})

-- Show cursorline only in active window
local cursorline_active_window = vim.api.nvim_create_augroup('CursorlineActiveWindow', { clear = true })
vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter' }, {
    group = cursorline_active_window,
    command = 'setlocal cursorline'
})
vim.api.nvim_create_autocmd({ 'WinLeave' }, {
    group = cursorline_active_window,
    command = 'setlocal nocursorline'
})

-- Quickscope colors
local quickscope_colors = vim.api.nvim_create_augroup('QuickscopeColors', { clear = true })
vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
    group = quickscope_colors,
    command = "highlight QuickScopePrimary guifg='#afff5f' gui=none ctermfg=155 cterm=underline",
})
vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
    group = quickscope_colors,
    command = "highlight QuickScopeSecondary guifg='#FF00FF' gui=none ctermfg=201 cterm=underline",
})

-- Turn off expandtab in go files
local no_expand_tab = vim.api.nvim_create_augroup('NoExpandtab', { clear = true })
vim.api.nvim_create_autocmd({ 'FileType', 'WinEnter', 'BufWinEnter' }, {
    group = no_expand_tab,
    pattern = { '*.go' },
    command = 'set noexpandtab'
})

local leap_tint_group = vim.api.nvim_create_augroup('leap-ast', {})
vim.api.nvim_create_autocmd("User", {
    group = leap_tint_group,
    pattern = 'LeapEnter',
    callback = function()
        require("tint").tint(vim.api.nvim_get_current_win())
    end
})

vim.api.nvim_create_autocmd("User", {
    group = leap_tint_group,
    pattern = 'LeapLeave',
    callback = function()
        require("tint").untint(vim.api.nvim_get_current_win())
    end
})

-- Format templ files.
vim.api.nvim_create_autocmd(
  {
    -- 'BufWritePre' event triggers just before a buffer is written to file.
    "BufWritePre"
  },
  {
    pattern = {"*.templ"},
    callback = function()
      -- Format the current buffer using Neovim's built-in LSP (Language Server Protocol).
      vim.lsp.buf.format()
    end,
  }
)

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
require('lazy').setup({
    { 'wellle/targets.vim' },
    { 'tpope/vim-repeat' },
    { 'raimondi/delimitmate' },
    { 'christoomey/vim-tmux-navigator' },
    { 'unblevable/quick-scope' },
    { 'igemnace/vim-makery' },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'folke/lsp-colors.nvim' },
    { 'tpope/vim-fugitive' },
    { 'romainl/vim-qf' },
    { 'kevinhwang91/nvim-bqf' },
    { 'vrischmann/tree-sitter-templ' },
    { 'ethanholz/nvim-lastplace', config = true },
    { 'numToStr/Comment.nvim', config = true },
    {
      'shortcuts/no-neck-pain.nvim',
      config = function()
        require("no-neck-pain").setup({
          width = 230,
          buffers = {
            wo = {
              fillchars = "eob: ",
            },
            right = {
                enabled = true
            }
          },
       })
      end
    },
    {
      'sontungexpt/buffer-closer',
      event = "VeryLazy",
    },
    {
        'nvim-tree/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup()
        end
    },
    {
        'yorickpeterse/nvim-pqf',
        config = function()
            require("pqf").setup()
        end
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup{}
        end
    },
    {
        "levouh/tint.nvim",
        config = function()
            require("tint").setup({})
        end
    },
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").setup({})
        end
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end
    },
    {
        'miversen33/netman.nvim',
        config = function()
            require('netman')
        end
    },
    {
        'Shatur/neovim-ayu',
        config = function()
            require('ayu').setup({
                -- Turn off italic comments
                overrides = function()
                    return { Comment = { fg = require('ayu.colors').comment } }
                end
            })
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'ayu',
                    section_separators = '',
                    component_separators = ''
                },
            })
        end
    },
    {
        'simrat39/symbols-outline.nvim',
        config = function()
            require("symbols-outline").setup({
                autofold_depth = 0
            })
        end
    },
    {
        'mrjones2014/smart-splits.nvim',
        config = function()
            require('smart-splits').setup()
        end
    },
    {
        'sindrets/diffview.nvim',
        dependencies = 'nvim-lua/plenary.nvim'
    },
    {
        'ThePrimeagen/harpoon',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('harpoon').setup({
                global_settings = {
                    mark_branch = true
                }
            })
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({
                signs = {
                    add = { hl = 'GitSignsAdd', text = '+', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
                    change = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
                    delete = { hl = 'GitSignsDelete', text = '—', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
                    topdelete = { hl = 'GitSignsDelete', text = '—', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
                    changedelete = { hl = 'GitSignsChange', text = '~—', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
                },

                _signs_staged_enable = false, -- experimental
                _signs_staged = {
                    add = { text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
                    change = { text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
                    delete = { text = '│', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
                    topdelete = {  text = '│', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
                    changedelete = {  text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
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
    {
        'ibhagwan/smartyank.nvim',
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
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
        tag = 'nightly',
        config = function()
            require('nvim-tree').setup()
        end
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && \
               cmake --build build --config Release && cmake --install build --prefix build'
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-live-grep-args.nvim',
        },
        config = function()
            local telescope = require('telescope')
            local actions = require('telescope.actions')

            local live_grep_actions = require('telescope-live-grep-args.actions')
            require('telescope').load_extension('live_grep_args')

            require('telescope').load_extension('harpoon')

            telescope.load_extension('fzf')

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

                            ['<C-x>'] = actions.delete_buffer,

                            ['<M-p>'] = require('telescope.actions.layout').toggle_preview,

                            ['<C-o>'] = live_grep_actions.quote_prompt(),
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
                                ['<C-o>'] = live_grep_actions.quote_prompt(),
                            }
                        }
                    }
                },
            }
        end
    },
    {
        'mhartington/formatter.nvim',
        config = function()
            require('formatter').setup({
                filetype = {
                    go = {
                        require('formatter.filetypes.go').gofmt,
                        -- require('formatter.filetypes.go').goimports,
                    },
                    typescript = {
                        require('formatter.filetypes.typescript').eslint_d,
                        -- require('formatter.filetypes.typescript').prettierd,
                    },
                    rust = {
                        require('formatter.filetypes.rust').rustfmt,
                    },
                    python = {
                        require('formatter.filetypes.python').ruff,
                    },
                }
            })
        end
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        },
        config = function()
            local lsp = require('lsp-zero').preset({
                name = 'recommended',
                set_lsp_keymaps = true,
                manage_nvim_cmp = true,
                suggest_lsp_servers = true,
            })

            -- Lua language server
            lsp.nvim_workspace()


            -- Rust language server
            lsp.configure('rust_analyzer')

            -- Go language server
            lsp.configure('gopls', {
                settings = {
                    gopls = {
                        env = {
                            GOOS = 'linux',
                            GOFLAGS = '-tags=linux',
                        },
                        buildFlags = {
                            '-tags=linux,!windows,integration'
                        },
                        directoryFilters = {
                            '-cmd/nanitor-scap/internal/scap',
                            '-cmd/nanitor-scap/internal/openscap',
                            '-contrib/submodules',
                        },
                        staticcheck = true,
                        analyses = {
                            ST1006 = false, -- Poorly chosen receiver name (allow this/self)
                            ST1005 = false, -- Error strings should not be capitalized
                            fieldalignment = false,
                            nilness = false,
                        },
                    },
                }
            })

            -- Python language server
            lsp.configure('pylsp', {
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                enabled = true,
                                ignore = { 'E501', 'W503' }, -- Line Too long, line break before binary operator
                            },
                            mccabe = {
                                enabled = false -- Disable cyclomatic complexity
                            }
                        }
                    }
                }
            })

            -- YAML language server
            lsp.configure('yamlls', {
                settings = {
                    yaml = {
                        keyorder = false
                    }
                }
            })

            lsp.setup()

        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()

            local treesitter_parser_config = require "nvim-treesitter.parsers".get_parser_configs()
            treesitter_parser_config.templ = {
              install_info = {
                url = "https://github.com/vrischmann/tree-sitter-templ.git",
                files = {"src/parser.c", "src/scanner.c"},
                branch = "master",
              },
            }
            vim.treesitter.language.register('templ', 'templ')

            require('nvim-treesitter.configs').setup {
                ensure_installed = { 'python', 'lua', 'go', 'typescript', 'rust' },
                highlight = { enable = true, },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            -- ['ac'] = '@conditional.outer',
                            -- ['ic'] = '@conditional.inner',
                            -- ['al'] = '@loop.outer',
                            -- ['il'] = '@loop.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']]'] = '@function.outer',
                        },
                        goto_previous_start = {
                            ['[['] = '@function.outer',
                        },
                    },
                },

            }
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        -- TODO: custom color highlights
        config = function()
            require('treesitter-context').setup({
                enable = true,
                patterns = {
                    default = {
                        'class',
                        'function',
                        'method',
                    },
                }
            })
        end
    },
    {
      'chentoast/marks.nvim',
      config = function()
        require'marks'.setup({
          force_write_shada = true,  -- Deleted marks won't reappear
          mappings = {
            set_next = "mm",
            next = "]a",
            prev = "[a",
          }
        })
      end
    },
    {
        "zeioth/garbage-day.nvim",
        dependencies = "neovim/nvim-lspconfig",
        event = "VeryLazy",
        opts = {
            -- your options here
        }
    },
})

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

-----------------------------------------------------
-- Colorschemes/Highlighting
-----------------------------------------------------

-- I'll toggle this manually
vim.cmd[[lua require("tint").disable()]]

-- Ayu
vim.cmd.colorscheme('ayu')
vim.api.nvim_set_hl(0, 'CursorLine', { fg = 'none', bg = 'gray12', default = false })
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#242A35', bg = 'None', default = true })
vim.api.nvim_set_hl(0, 'TreesitterContext', { fg = 'none', bg = '#161a20', default = true })

-- Gitsigns staged hunks (experimental)
vim.api.nvim_set_hl(0, 'GitSignsStagedAdd', { fg = '#ff8f40', bg = 'None', default = true })
vim.api.nvim_set_hl(0, 'GitSignsStagedChange', { fg = '#ff8f40', bg = 'None', default = false })
vim.api.nvim_set_hl(0, 'GitSignsStagedDelete', { fg = '#ff8f40', bg = 'None', default = false })
vim.api.nvim_set_hl(0, 'GitSignsStagedTopDelete', { fg = '#ff8f40', bg = 'None', default = false })
vim.api.nvim_set_hl(0, 'GitSignsStagedChangedDelete', { fg = '#ff8f40', bg = 'None', default = false })
